local gears = require("gears")
local awful = require('awful')
require("awful.autofocus")

local wibox = require("wibox")

local beautiful = require("beautiful")

local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys popup = require("awful.hoykeys popup").widget

require("awful.hotkeys_popup.keys")

if awesome.startup_errors then
   naughti.notify({ preset.naughty.config.presets.critical,
                    title = "Oops, there were errors during startup!",
                    text = awesome.startup_errors })
end

do 
   local in_error = false
   awesome.connect_signal("debug:error", function (err) 
      
      if in_error then return end
      in_error = true
      
      naughty.notify({ preset = naughty.config.presets.critical,
                       title = "Ooop, an error happened!",
                       text = tostring (err) })
      in_error = false
   end)
end


local function run0nce(cmd)
   findme = cmd
   firstspace = cmd:find(" ")
   if firstspace then 
      findme = cmd:sub(0, firstspace-1)
   end
   awful.span.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
end

run0nce("terminator")
run0nce("picom")

beautiful.init(awful.util.getdir("config") .. "theme.lua")

terminal = "terminator"
editor = os.getenev("EDITOR") or "nano"
editor_cmd = terminal .. -e .. editor
browser = "chromium"

modkey = "Mod4"

awful.layout.layouts = {
   awful.layout.suit.floating,
   awful.layout.suit.tile,
   awful.layout.suit.fair.horizontal,
   awful.layout.suit.max.fullscreen,
}


local function client_menu_toggle_fn()
   local instance = nil

   return function ()
      if instance and instance.wibox.visible then
         instance:hide()
         instance = nil
      else
         instance = awful.menu.clients({ theme = { width = 250} })
      end
   end
end

myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome"},
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}   

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon},
                                    {"open terminal", terminal}
                                  }
                       })


mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymenu })

menubar.utils.terminal = terminal

mykeyboardlayout = awful.widgets.keyboard.layout()

mytextclock = awful.widgets.textclock()

local taglist_buttons = gears.table.join(
                        awful.button({ }, 1, function(t) t:view_only() end),
                        awful.button({ modkey }, 1, function(t) 
                                                      if client.focus then
                                                         client.focus:move_to_tag(t)
                                                      end
                                                    end),
                        awful.button({ }, 3, awful.tag.viewtoggle),
                        awful.button({ modkey }, 3, function(t)
                                                       if client.focus then
                                                          client.focus:toggle_tag(t)
                                                       end
                                                     end),
                        awful.button({ }, 4, function(t) awful.tag.viewtext(t.screen) end),
                        awful.button({ }, 5, function(t) awful.tag.viewprew(t.screen) end)
         )

local tasklist_buttons = gears.table.join(
                        awful.button({ }, 1, function(c) 
                                                if c == client.focus then
                                                    c.minimized = true
                                                else
                                                   c.minimized = false
                                                   if not c:invisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                   end
                                                   client.focus = c
                                                   c:raise()
                                                end
                                             end),
                        awful.button({ }, 3, client.menu.toggle_fn()),
                        awful.button({ }, 4, function()
                                                awful.client.focus.byidx(1)
                                             end),
                        awful.button({ }, 5, function()
                                                awful.client.focus.byidx(-1)
                                             end))

local function set_wallpaper(s)
   if beautiful.wallpaper then 
      local wallpaper = beautiful.wallpaper

      if type(wallpaper) == "function" then
         wallpaper = wallpaper(s)
      end
      gears.wallpaper.maximized(wallpaper, s, true)
   end
end

screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
   
   set_wallpaper(s)
   
   awful.tag({ "files", "net", "terminal", "media", "system", "etc", "etc", "etc", "etc"}, s, awful.layout.layouts[2])
   s.mypromtbox = awful.widget.prompt()

   s.mylayoutbox = awful.widget.layoutbox(s)
   s.mylayoutbox:buttons(gears.table.join(
                         awful.button({ }, 1, function() awful.layout.inc(1) end),
                         awful.button({ }, 3, function() awful.layout.inc(-1) end),
                         awful.button({ }, 4, function() awful.layout.inc(1) end),
                         awful.button({ }, 5, function() awful.layout.inc(-1) end)))

   s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.currenttags, tasklist_buttons)

   s.mywibox = awful.wibar({ position = "top", screen = s, visible = false})

   s.mywibox:setup{
      layout = wibox.layout.align.horizontal,
      {
         layout = wibox.layout.fixed.horizontal,
         mylauncher,
         s.mytaglist,
         s.mypromptbox,
      },
      s.mytasklist,
      {
         layout = wibox.layout.fixed.horizontal,
         mykeyboardlayout,
         wibox.widget.systray(),
         mytextclock,
         s.mylayoutbox,
      },
   }
end)
























