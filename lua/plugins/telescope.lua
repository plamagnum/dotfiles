-- ============================================================================
-- Telescope - Fuzzy Finder конфігурація
-- ============================================================================

return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            local themes = require("telescope.themes")

            telescope.setup({
                defaults = {
                    -- Вигляд
                    prompt_prefix = " 🔍 ",
                    selection_caret = " ➤ ",
                    entry_prefix = "  ",
                    multi_icon = " + ",
                    initial_mode = "insert",
                    selection_strategy = "reset",
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },

                    -- Поведінка
                    path_display = { "truncate" },
                    winblend = 0,
                    border = {},
                    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    color_devicons = true,
                    set_env = { ["COLORTERM"] = "truecolor" },

                    -- Ігнорувати файли/папки
                    file_ignore_patterns = {
                        "node_modules",
                        ".git/",
                        "dist/",
                        "build/",
                        "target/",
                        "vendor/",
                        "%.lock",
                        "__pycache__",
                        "%.pyc",
                        "%.o",
                        "%.a",
                        "%.out",
                        "%.class",
                        "%.pdf",
                        "%.mkv",
                        "%.mp4",
                        "%.zip",
                    },

                    -- Прев'ю
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

                    -- Історія
                    history = {
                        path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
                        limit = 100,
                    },

                    -- Маппінги
                    mappings = {
                        i = {
                            -- Навігація
                            ["<C-n>"] = actions.move_selection_next,
                            ["<C-p>"] = actions.move_selection_previous,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions. move_selection_previous,

                            -- Скрол превью
                            ["<C-u>"] = actions.preview_scrolling_up,
                            ["<C-d>"] = actions.preview_scrolling_down,

                            -- Закрити вікно
                            ["<C-c>"] = actions.close,
                            ["<Esc>"] = actions.close,

                            -- Відкрити файл
                            ["<CR>"] = actions.select_default,
                            ["<C-x>"] = actions.select_horizontal,
                            ["<C-v>"] = actions. select_vertical,
                            ["<C-t>"] = actions.select_tab,

                            -- Quickfix список
                            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                            -- Історія
                            ["<C-Down>"] = actions.cycle_history_next,
                            ["<C-Up>"] = actions.cycle_history_prev,

                            -- Виділення
                            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

                            -- Інше
                            ["<C-l>"] = actions.complete_tag,
                            ["<C-_>"] = actions.which_key,
                        },

                        n = {
                            -- Навігація
                            ["j"] = actions.move_selection_next,
                            ["k"] = actions.move_selection_previous,
                            ["H"] = actions.move_to_top,
                            ["M"] = actions.move_to_middle,
                            ["L"] = actions.move_to_bottom,

                            -- Скрол превью
                            ["<C-u>"] = actions. preview_scrolling_up,
                            ["<C-d>"] = actions.preview_scrolling_down,

                            -- Закрити
                            ["<Esc>"] = actions.close,
                            ["q"] = actions.close,

                            -- Відкрити файл
                            ["<CR>"] = actions.select_default,
                            ["<C-x>"] = actions.select_horizontal,
                            ["<C-v>"] = actions.select_vertical,
                            ["<C-t>"] = actions.select_tab,

                            -- Quickfix
                            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                            -- Виділення
                            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

                            -- Інше
                            ["gg"] = actions.move_to_top,
                            ["G"] = actions.move_to_bottom,
                            ["? "] = actions.which_key,
                        },
                    },
                },

                -- ====================================================================
                -- Конфігурація окремих picker'ів
                -- ====================================================================

                pickers = {
                    -- Пошук файлів
                    find_files = {
                        theme = "dropdown",
                        previewer = false,
                        hidden = true,
                        find_command = { "rg", "--files", "--hidden", "--glob", "! . git/*" },
                    },

                    -- Недавні файли
                    oldfiles = {
                        theme = "dropdown",
                        previewer = false,
                    },

                    -- Буфери
                    buffers = {
                        theme = "dropdown",
                        previewer = false,
                        initial_mode = "normal",
                        mappings = {
                            i = {
                                ["<C-d>"] = actions.delete_buffer,
                            },
                            n = {
                                ["dd"] = actions.delete_buffer,
                            },
                        },
                    },

                    -- Live grep
                    live_grep = {
                        theme = "ivy",
                        previewer = true,
                        additional_args = function()
                            return { "--hidden", "--glob", "!.git/*" }
                        end,
                    },

                    -- Grep string
                    grep_string = {
                        theme = "ivy",
                    },

                    -- Git файли
                    git_files = {
                        theme = "dropdown",
                        previewer = false,
                        show_untracked = true,
                    },

                    -- Git commits
                    git_commits = {
                        theme = "ivy",
                    },

                    -- Git branches
                    git_branches = {
                        theme = "dropdown",
                    },

                    -- LSP references
                    lsp_references = {
                        theme = "cursor",
                        initial_mode = "normal",
                    },

                    -- LSP definitions
                    lsp_definitions = {
                        theme = "cursor",
                        initial_mode = "normal",
                    },

                    -- LSP implementations
                    lsp_implementations = {
                        theme = "cursor",
                        initial_mode = "normal",
                    },

                    -- Diagnostics
                    diagnostics = {
                        theme = "ivy",
                        initial_mode = "normal",
                    },

                    -- Colorscheme
                    colorscheme = {
                        enable_preview = true,
                    },

                    -- Help tags
                    help_tags = {
                        theme = "ivy",
                    },

                    -- Man pages
                    man_pages = {
                        theme = "ivy",
                    },

                    -- Marks
                    marks = {
                        theme = "dropdown",
                    },

                    -- Registers
                    registers = {
                        theme = "cursor",
                    },

                    -- Команди
                    commands = {
                        theme = "ivy",
                    },

                    -- Command history
                    command_history = {
                        theme = "dropdown",
                    },

                    -- Search history
                    search_history = {
                        theme = "dropdown",
                    },
                },

                -- ====================================================================
                -- Розширення
                -- ====================================================================

                extensions = {
                    -- FZF для швидшого пошуку
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },

                    -- File browser
                    file_browser = {
                        theme = "ivy",
                        hijack_netrw = true,
                        mappings = {
                            ["i"] = {
                                ["<C-w>"] = function()
                                    vim.cmd("normal vbd")
                                end,
                            },
                            ["n"] = {
                                ["N"] = require("telescope._extensions.file_browser.actions").create,
                                ["h"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
                                ["/"] = function()
                                    vim.cmd("startinsert")
                                end,
                            },
                        },
                    },

                    -- UI select
                    ["ui-select"] = {
                        themes.get_dropdown({}),
                    },

                    -- Live grep args
                    live_grep_args = {
                        auto_quoting = true,
                        mappings = {
                            i = {
                                ["<C-k>"] = require("telescope-live-grep-args. actions").quote_prompt(),
                            },
                        },
                    },
                },
            })

            -- Завантаження розширень
            telescope.load_extension("fzf")
            telescope.load_extension("file_browser")
            telescope.load_extension("ui-select")
            
            -- Перевірка наявності live_grep_args перед завантаженням
            local has_live_grep_args = pcall(require, "telescope-live-grep-args")
            if has_live_grep_args then
                telescope.load_extension("live_grep_args")
            end

            -- ====================================================================
            -- Кастомні функції
            -- ====================================================================

            local M = {}

            -- Пошук в поточній директорії буфера
            M.find_files_from_project_git_root = function()
                local function is_git_repo()
                    vim.fn.system("git rev-parse --is-inside-work-tree")
                    return vim.v.shell_error == 0
                end

                local function get_git_root()
                    local dot_git_path = vim.fn.finddir(".git", ".;")
                    return vim.fn.fnamemodify(dot_git_path, ": h")
                end

                local opts = {}
                if is_git_repo() then
                    opts = {
                        cwd = get_git_root(),
                    }
                end
                require("telescope.builtin").find_files(opts)
            end

            -- Пошук в конфігураційних файлах Neovim
            M.search_nvim_config = function()
                require("telescope.builtin").find_files({
                    prompt_title = "< Neovim Config >",
                    cwd = vim.fn.stdpath("config"),
                    hidden = true,
                })
            end

            -- Пошук в плагінах
            M.search_plugins = function()
                require("telescope.builtin").find_files({
                    prompt_title = "< Plugins >",
                    cwd = vim.fn.stdpath("data") .. "/lazy",
                })
            end

            -- Пошук TODO коментарів
            M.search_todos = function()
                require("telescope.builtin").grep_string({
                    prompt_title = "< TODO Comments >",
                    search = "TODO|HACK|PERF|NOTE|FIX",
                    use_regex = true,
                })
            end

            -- Пошук слова під курсором
            M.grep_word_under_cursor = function()
                local word = vim.fn.expand("<cword>")
                require("telescope.builtin").grep_string({
                    search = word,
                })
            end

            -- Пошук вибраного тексту
            M.grep_visual_selection = function()
                local visual_selection = function()
                    local save_previous = vim.fn.getreg("a")
                    vim.api.nvim_command('silent! normal! "ay')
                    local selection = vim.fn.trim(vim.fn.getreg("a"))
                    vim.fn.setreg("a", save_previous)
                    return vim.fn.substitute(selection, [[\n]], [[\\n]], "g")
                end
                require("telescope.builtin").grep_string({
                    search = visual_selection(),
                })
            end

            -- Пошук в відкритих буферах
            M.live_grep_in_buffers = function()
                require("telescope.builtin").live_grep({
                    grep_open_files = true,
                    prompt_title = "Live Grep in Open Buffers",
                })
            end

            -- Git status з preview
            M.git_status_with_diff = function()
                local previewers = require("telescope.previewers")
                local pickers = require("telescope.pickers")
                local finders = require("telescope.finders")
                local conf = require("telescope.config").values

                pickers
                    .new({}, {
                        prompt_title = "Git Status",
                        finder = finders.new_oneshot_job({ "git", "status", "--short" }),
                        previewer = previewers.new_termopen_previewer({
                            get_command = function(entry)
                                return { "git", "diff", entry.value: sub(4) }
                            end,
                        }),
                        sorter = conf.generic_sorter({}),
                    })
                    : find()
            end

            -- Експорт функцій
            _G.telescope_custom = M

            -- ====================================================================
            -- Додаткові keymaps для кастомних функцій
            -- ====================================================================

            vim.keymap.set("n", "<leader>fp", M.find_files_from_project_git_root, { desc = "Find files from git root" })
            vim.keymap.set("n", "<leader>fn", M.search_nvim_config, { desc = "Search Neovim config" })
            vim.keymap.set("n", "<leader>fP", M.search_plugins, { desc = "Search plugins" })
            vim.keymap.set("n", "<leader>ft", M.search_todos, { desc = "Search TODO comments" })
            vim.keymap.set("n", "<leader>fw", M.grep_word_under_cursor, { desc = "Grep word under cursor" })
            vim.keymap.set("v", "<leader>fw", M.grep_visual_selection, { desc = "Grep visual selection" })
            vim.keymap.set("n", "<leader>f/", M.live_grep_in_buffers, { desc = "Live grep in buffers" })
            vim.keymap.set("n", "<leader>gs", M.git_status_with_diff, { desc = "Git status with diff" })

            -- File browser
            vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", { desc = "File browser" })
            vim.keymap.set("n", "<leader>fB", ":Telescope file_browser path=%: p: h select_buffer=true<CR>", 
                { desc = "File browser (current dir)" })
        end,
    },

    -- ====================================================================
    -- Додаткові розширення для Telescope
    -- ====================================================================

    -- FZF алгоритм (для швидшого пошуку)
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },

    -- File browser
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    },

    -- UI Select (використовувати telescope для vim. ui.select)
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },

    -- Live grep з аргументами
    {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
    },

    -- Додаткові корисні розширення (опціонально)
    
    -- Symbols (LSP symbols)
    -- {
    --     "nvim-telescope/telescope-symbols. nvim",
    -- },

    -- Project management
    -- {
    --     "nvim-telescope/telescope-project.nvim",
    -- },

    -- Recent files
    -- {
    --     "nvim-telescope/telescope-frecency.nvim",
    --     dependencies = { "kkharji/sqlite.lua" },
    -- },

    -- GitHub integration
    -- {
    --     "nvim-telescope/telescope-github.nvim",
    -- },
}