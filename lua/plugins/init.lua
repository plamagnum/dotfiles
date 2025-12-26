-- ============================================================================
-- Конфігурація плагінів з lazy.nvim
-- ============================================================================

-- Автоматична установка lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp: prepend(lazypath)

-- Список плагінів
require("lazy").setup({
    -- ========================================================================
    -- Теми та UI
    -- ========================================================================

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night", -- storm, moon, night, day
                transparent = false,
                terminal_colors = true,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                },
            })
            vim.cmd([[colorscheme tokyonight]])
        end,
    },

    -- Альтернативні теми (закоментовані)
    -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    -- { "ellisonleao/gruvbox.nvim", priority = 1000 },
    -- { "navarasu/onedark.nvim", priority = 1000 },

    -- Статус-бар
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "tokyonight",
                    component_separators = { left = "|", right = "|" },
                    section_separators = { left = "", right = "" },
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { { "filename", path = 1 } },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })
        end,
    },

    -- Табуляція буферів
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    numbers = "none",
                    close_command = "bdelete!  %d",
                    diagnostics = "nvim_lsp",
                    separator_style = "slant",
                    always_show_bufferline = true,
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            highlight = "Directory",
                            text_align = "left",
                        },
                    },
                },
            })
        end,
    },

    -- Іконки
    { "nvim-tree/nvim-web-devicons" },

    -- Візуалізація відступів
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup({
                indent = { char = "│" },
                scope = { enabled = false },
            })
        end,
    },

    -- Підсвічування кольорів
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                user_default_options = {
                    RGB = true,
                    RRGGBB = true,
                    names = false,
                    css = true,
                    css_fn = true,
                },
            })
        end,
    },

    -- Показ контексту коду
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({
                max_lines = 3,
            })
        end,
    },

    -- ========================================================================
    -- Файловий провідник та навігація
    -- ========================================================================

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                view = {
                    width = 35,
                    side = "left",
                },
                renderer = {
                    group_empty = true,
                    icons = {
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = true,
                        },
                    },
                },
                filters = {
                    dotfiles = false,
                    custom = { ".git", "node_modules", ". cache" },
                },
                git = {
                    enable = true,
                    ignore = false,
                },
            })
        end,
    },

    -- Telescope - fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    prompt_prefix = " 🔍 ",
                    selection_caret = " ➤ ",
                    path_display = { "truncate" },
                    file_ignore_patterns = { "node_modules", ". git/", "dist/", "build/" },
                    mappings = {
                        i = {
                            ["<C-k>"] = actions. move_selection_previous,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                },
            })

            telescope.load_extension("fzf")
        end,
    },

    -- Швидка навігація по файлах
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon: setup()

            vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon: list()) end)
            vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end)
        end,
    },

    -- ========================================================================
    -- LSP та автодоповнення
    -- ========================================================================

    -- LSP конфігурація
    {
        "williamboman/mason.nvim",
        priority = 100,
        config = true,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        priority = 90,
    },

-- LSP конфігурація
    {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        { "j-hui/fidget.nvim", opts = {} }, -- Прогрес LSP
    },
        priority = 80,
        config = function()
        require("plugins.lsp")
        end,
    },

    -- Автодоповнення
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim", -- Іконки в автодоповненні
        },
        config = function()
            require("plugins.cmp")
        end,
    },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    -- Форматування та лінтинг
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls. setup({
                sources = {
                    -- Форматування
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.gofmt,
                    null_ls.builtins.formatting.rustfmt,

                    -- Лінтинг
                    null_ls.builtins.diagnostics.eslint_d,
                    null_ls.builtins.diagnostics.pylint,
                },
            })
        end,
    },

    -- ========================================================================
    -- Treesitter
    -- ========================================================================

    {
    "nvim-treesitter/nvim-treesitter",
    branch = 'main',
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    -- dependencies = {
    --     {
    --         "nvim-treesitter/nvim-treesitter-textobjects",
    --         -- Використовуємо конкретний коміт який працює
    --         --commit = "85b9d0cbd59", -- або просто видаліть цей рядок
    --     },
    -- },
    config = function()
        require("plugins.treesitter")
    end,
    },

    -- ========================================================================
    -- Git інтеграція
    -- ========================================================================

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "│" },
                    change = { text = "│" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
                current_line_blame = true,
                current_line_blame_opts = {
                    delay = 500,
                },
            })
        end,
    },

    -- Git команди
    {
        "tpope/vim-fugitive",
    },

    -- ========================================================================
    -- Додаткові інструменти
    -- ========================================================================

    -- Підказки для комбінацій клавіш
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")
            wk.setup({
                window = {
                    border = "rounded",
                },
            })
            wk.register({
                ["<leader>f"] = { name = "+Find" },
                ["<leader>g"] = { name = "+Git" },
                ["<leader>t"] = { name = "+Trouble/Terminal" },
                ["<leader>b"] = { name = "+Buffer" },
                ["<leader>e"] = { name = "+Explorer" },
                ["<leader>c"] = { name = "+Code" },
                ["<leader>d"] = { name = "+Diagnostics" },
            })
        end,
    },

    -- Коментування коду
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },

    -- Автоматичне закриття дужок
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true, -- Treesitter інтеграція
                fast_wrap = {
                    map = "<M-e>",
                    chars = { "{", "[", "(", '"', "'" },
                },
            })
        end,
    },

    -- Оточуючі символи (дужки, лапки)
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end,
    },

    -- Список діагностики та помилок
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup()
        end,
    },

    -- TODO коментарі
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup()
        end,
    },

    -- Термінал
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                size = 20,
                open_mapping = [[<c-\>]],
                hide_numbers = true,
                shade_terminals = true,
                start_in_insert = true,
                insert_mappings = true,
                persist_size = true,
                direction = "float",
                close_on_exit = true,
                shell = vim.o.shell,
                float_opts = {
                    border = "curved",
                },
            })
        end,
    },

    -- Швидка навігація по тексту
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        },
    },

    -- Підсвічування використань змінної під курсором
    {
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure({
                delay = 200,
                large_file_cutoff = 2000,
            })
        end,
    },

    -- Покращена панель заміни
    {
        "nvim-pack/nvim-spectre",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("spectre").setup()
            vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" })
        end,
    },

    -- Markdown preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = "cd app && npx --yes yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },


    -- Session management
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        config = function()
            require("persistence").setup()
            vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end)
            vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end)
        end,
    },
})