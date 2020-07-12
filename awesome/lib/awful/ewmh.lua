---------------------------------------------------------------------------
--- Implements EWMH requests handling.
--
-- @author Julien Danjou &lt;julien@danjou.info&gt;
-- @copyright 2009 Julien Danjou
-- @module awful.ewmh
---------------------------------------------------------------------------

local client = client
local screen = screen
local ipairs = ipairs
local util = require("awful.util")
local aclient = require("awful.client")
local aplace = require("awful.placement")
local asuit = require("awful.layout.suit")

local ewmh = {
    generic_activate_filters    = {},
    contextual_activate_filters = {},
}

--- The list of all registered generic request::activate (focus stealing)
-- filters. If a filter is added to only one context, it will be in
-- `ewmh.contextual_activate_filters`["context_name"].
-- @table[opt={}] generic_activate_filters
-- @see ewmh.activate
-- @see ewmh.add_activate_filter
-- @see ewmh.remove_activate_filter

--- The list of all registered contextual request::activate (focus stealing)
-- filters. If a filter is added to only one context, it will be in
-- `ewmh.generic_activate_filters`.
-- @table[opt={}] contextual_activate_filters
-- @see ewmh.activate
-- @see ewmh.add_activate_filter
-- @see ewmh.remove_activate_filter

--- Update a client's settings when its geometry changes, skipping signals
-- resulting from calls within.
local geometry_change_lock = false
local function geometry_change(window)
    if geometry_change_lock then return end
    geometry_change_lock = true

    -- Fix up the geometry in case this window needs to cover the whole screen.
    local bw = window.border_width or 0
    local g = window.screen.workarea
    if window.maximized_vertical then
        window:geometry { height = g.height - 2*bw, y = g.y }
    end
    if window.maximized_horizontal then
        window:geometry { width = g.width - 2*bw, x = g.x }
    end
    if window.fullscreen then
        window.border_width = 0
        window:geometry(window.screen.geometry)
    end

    geometry_change_lock = false
end

--- Activate a window.
--
-- This sets the focus only if the client is visible.
--
-- It is the default signal handler for `request::activate` on a `client`.
--
-- @signalhandler awful.ewmh.activate
-- @client c A client to use
-- @tparam string context The context where this signal was used.
-- @tparam[opt] table hints A table with additional hints:
-- @tparam[opt=false] boolean hints.raise should the client be raised?
function ewmh.activate(c, context, hints) -- luacheck: no unused args
    hints = hints or  {}

    if c.focusable == false and not hints.force then return end

    local found, ret = false

    -- Execute the filters until something handle the request
    for _, tab in ipairs {
        ewmh.contextual_activate_filters[context] or {},
        ewmh.generic_activate_filters
    } do
        for i=#tab, 1, -1 do
            ret = tab[i](c, context, hints)
            if ret ~= nil then found=true; break end
        end

        if found then break end
    end

    if ret ~= false and c:isvisible() then
        client.focus = c
    elseif ret == false and not hints.force then
        return
    end

    if hints and hints.raise then
        c:raise()
        if not awesome.startup and not c:isvisible() then
            c.urgent = true
        end
    end
end

--- Add an activate (focus stealing) filter function.
--
-- The callback takes the following parameters:
--
-- * **c** (*client*) The client requesting the activation
-- * **context** (*string*) The activation context.
-- * **hints** (*table*) Some additional hints (depending on the context)
--
-- If the callback returns `true`, the client will be activated unless the `force`
-- hint is set. If the callback returns `false`, the activation request is
-- cancelled. If the callback returns `nil`, the previous callback will be
-- executed. This will continue until either a callback handles the request or
-- when it runs out of callbacks. In that case, the request will be granted if
-- the client is visible.
--
-- For example, to block Firefox from stealing the focus, use:
--
--    awful.ewmh.add_activate_filter(function(c, "ewmh")
--        if c.class == "Firefox" then return false end
--    end)
--
-- @tparam function f The callback
-- @tparam[opt] string context The `request::activate` context
-- @see generic_activate_filters
-- @see contextual_activate_filters
-- @see remove_activate_filter
function ewmh.add_activate_filter(f, context)
    if not context then
        table.insert(ewmh.generic_activate_filters, f)
    else
        ewmh.contextual_activate_filters[context] =
            ewmh.contextual_activate_filters[context] or {}

        table.insert(ewmh.contextual_activate_filters[context], f)
    end
end

--- Remove an activate (focus stealing) filter function.
-- This is an helper to avoid dealing with `ewmh.add_activate_filter` directly.
-- @tparam function f The callback
-- @tparam[opt] string context The `request::activate` context
-- @treturn boolean If the callback existed
-- @see generic_activate_filters
-- @see contextual_activate_filters
-- @see add_activate_filter
function ewmh.remove_activate_filter(f, context)
    local tab = context and (ewmh.contextual_activate_filters[context] or {})
        or ewmh.generic_activate_filters

    for k, v in ipairs(tab) do
        if v == f then
            table.remove(tab, k)

            -- In case the callback is there multiple time.
            ewmh.remove_activate_filter(f, context)

            return true
        end
    end

    return false
end

-- Get tags that are on the same screen as the client. This should _almost_
-- always return the same content as c:tags().
local function get_valid_tags(c, s)
    local tags, new_tags = c:tags(), {}

    for _, t in ipairs(tags) do
        if s == t.screen then
            table.insert(new_tags, t)
        end
    end

    return new_tags
end

--- Tag a window with its requested tag.
--
-- It is the default signal handler for `request::tag` on a `client`.
--
-- @signalhandler awful.ewmh.tag
-- @client c A client to tag
-- @tparam[opt] tag|boolean t A tag to use. If true, then the client is made sticky.
-- @tparam[opt={}] table hints Extra information
function ewmh.tag(c, t, hints) --luacheck: no unused
    -- There is nothing to do
    if not t and #get_valid_tags(c, c.screen) > 0 then return end

    if not t then
        if c.transient_for then
            c.screen = c.transient_for.screen
            if not c.sticky then
                c:tags(c.transient_for:tags())
            end
        else
            c:to_selected_tags()
        end
    elseif type(t) == "boolean" and t then
        c.sticky = true
    else
        c.screen = t.screen
        c:tags({ t })
    end
end

--- Handle client urgent request
-- @signalhandler awful.ewmh.urgent
-- @client c A client
-- @tparam boolean urgent If the client should be urgent
function ewmh.urgent(c, urgent)
    if c ~= client.focus and not aclient.property.get(c,"ignore_urgent") then
        c.urgent = urgent
    end
end

-- Map the state to the action name
local context_mapper = {
    maximized_vertical   = "maximize_vertically",
    maximized_horizontal = "maximize_horizontally",
    fullscreen           = "maximize"
}

--- Move and resize the client.
--
-- This is the default geometry request handler.
--
-- @signalhandler awful.ewmh.geometry
-- @tparam client c The client
-- @tparam string context The context
-- @tparam[opt={}] table hints The hints to pass to the handler
function ewmh.geometry(c, context, hints)
    local layout = c.screen.selected_tag and c.screen.selected_tag.layout or nil

    -- Setting the geometry wont work unless the client is floating.
    if (not c.floating) and (not layout == asuit.floating) then
        return
    end

    context = context or ""

    local original_context = context

    -- Now, map it to something useful
    context = context_mapper[context] or context

    local props = util.table.clone(hints or {}, false)
    props.store_geometry = props.store_geometry==nil and true or props.store_geometry

    -- If it is a known placement function, then apply it, otherwise let
    -- other potential handler resize the client (like in-layout resize or
    -- floating client resize)
    if aplace[context] then

        -- Check if it correspond to a boolean property
        local state = c[original_context]

        -- If the property is boolean and it correspond to the undo operation,
        -- restore the stored geometry.
        if state == false then
            aplace.restore(c,{context=context})
            return
        end

        local honor_default = original_context ~= "fullscreen"

        if props.honor_workarea == nil then
            props.honor_workarea = honor_default
        end

        aplace[context](c, props)
    end
end

client.connect_signal("request::activate", ewmh.activate)
client.connect_signal("request::tag", ewmh.tag)
client.connect_signal("request::urgent", ewmh.urgent)
client.connect_signal("request::geometry", ewmh.geometry)
client.connect_signal("property::border_width", geometry_change)
client.connect_signal("property::geometry", geometry_change)
screen.connect_signal("property::workarea", function(s)
    for _, c in pairs(client.get(s)) do
        geometry_change(c)
    end
end)

return ewmh

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80