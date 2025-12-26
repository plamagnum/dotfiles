-- ============================================================================
-- LSP конфігурація для Neovim 0.11+
-- ============================================================================

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Діагностика
vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
    },
})

-- Іконки для діагностики
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Обробник при приєднанні LSP
local on_attach = function(client, bufnr)
    vim.bo[bufnr].omnifunc = "v:lua. vim.lsp.omnifunc"
end

-- Налаштування обробників
local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

-- Налаштування mason
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

-- Налаштування mason-lspconfig
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
        "ts_ls",
        "rust_analyzer",
        "gopls",
        "clangd",
        "html",
        "cssls",
        "jsonls",
    },
    automatic_installation = true,
})

-- ============================================================================
-- Використовуємо новий API vim.lsp для Neovim 0.11+
-- ============================================================================

-- Lua Language Server
vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_dir = vim.fs.root(0, { ". luarc.json", ".luarc. jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ". git" }),
    capabilities = capabilities,
    on_attach = on_attach,
    handlers = handlers,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
})

-- Python (Pyright)
vim.lsp.config("pyright", {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_dir = vim.fs.root(0, { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ". git" }),
    capabilities = capabilities,
    on_attach = on_attach,
    handlers = handlers,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
})

-- TypeScript/JavaScript
vim.lsp.config("ts_ls", {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", "jsconfig.json", ". git" }),
    capabilities = capabilities,
    on_attach = on_attach,
    handlers = handlers,
})

-- Rust Analyzer
vim.lsp.config("rust_analyzer", {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_dir = vim.fs.root(0, { "Cargo.toml", "rust-project.json" }),
    capabilities = capabilities,
    on_attach = on_attach,
    handlers = handlers,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
            cargo = { allFeatures = true },
        },
    },
})

-- Go (gopls)
vim.lsp.config("gopls", {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = vim.fs.root(0, { "go.work", "go.mod", ". git" }),
    capabilities = capabilities,
    on_attach = on_attach,
    handlers = handlers,
    settings = {
        gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
        },
    },
})

-- C/C++ (clangd)
vim.lsp.config("clangd", {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_dir = vim.fs.root(0, { ".clangd", ".clang-tidy", "compile_commands.json", ".git" }),
    capabilities = capabilities,
    on_attach = on_attach,
    handlers = handlers,
})

-- HTML
vim.lsp.config("html", {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
    root_dir = vim.fs.root(0, { "package.json", ". git" }),
    capabilities = capabilities,
    on_attach = on_attach,
    handlers = handlers,
})

-- CSS
vim.lsp.config("cssls", {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_dir = vim.fs.root(0, { "package.json", ".git" }),
    capabilities = capabilities,
    on_attach = on_attach,
    handlers = handlers,
})

-- JSON
vim.lsp.config("jsonls", {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    root_dir = vim.fs.root(0, { "package.json", ".git" }),
    capabilities = capabilities,
    on_attach = on_attach,
    handlers = handlers,
})

-- ============================================================================
-- Автозапуск LSP серверів
-- ============================================================================

vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
        vim.lsp.enable("lua_ls")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.lsp.enable("pyright")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    callback = function()
        vim.lsp.enable("ts_ls")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        vim.lsp.enable("rust_analyzer")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "go", "gomod", "gowork", "gotmpl" },
    callback = function()
        vim.lsp.enable("gopls")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
    callback = function()
        vim.lsp.enable("clangd")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "html",
    callback = function()
        vim.lsp.enable("html")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "css", "scss", "less" },
    callback = function()
        vim.lsp.enable("cssls")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "json", "jsonc" },
    callback = function()
        vim.lsp.enable("jsonls")
    end,
})