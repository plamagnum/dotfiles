-- ============================================================================
-- Автоматичні команди
-- ============================================================================

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Група для загальних автокоманд
local general = augroup("General", { clear = true })

-- Підсвічування при копіюванні
autocmd("TextYankPost", {
    group = general,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})

-- Видалення пробілів в кінці рядків при збереженні
autocmd("BufWritePre", {
    group = general,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- Автоматичне форматування при збереженні (опціонально)
autocmd("BufWritePre", {
    group = general,
    pattern = { "*. lua", "*.py", "*.js", "*.ts", "*.jsx", "*.tsx", "*.go", "*.rs" },
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

-- Відновлення позиції курсору при відкритті файлу
autocmd("BufReadPost", {
    group = general,
    pattern = "*",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Автоматичне закриття nvim-tree при закритті останнього буфера
autocmd("BufEnter", {
    group = general,
    pattern = "*",
    callback = function()
        if vim.fn.winnr("$") == 1 and vim.bo.filetype == "nvimtree" then
            vim. cmd("quit")
        end
    end,
})

-- Налаштування для певних типів файлів
autocmd("FileType", {
    group = general,
    pattern = { "html", "css", "javascript", "typescript", "json", "yaml", "xml" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

-- Автоматичне оновлення плагінів при збереженні plugins/init.lua
autocmd("BufWritePost", {
    group = general,
    pattern = "*/plugins/init.lua",
    command = "source <afile> | Lazy sync",
})