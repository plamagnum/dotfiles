-- ============================================================================
-- Комбінації клавіш
-- ============================================================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- Загальні
-- ============================================================================

-- Швидке збереження
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>x", ":x<CR>", opts)

-- Очистити підсвічування пошуку
keymap("n", "<Esc>", ":noh<CR>", opts)

-- Краща навігація при переносі рядків
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Переміщення виділеного тексту
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Залишатись у візуальному режимі при зміні відступів
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Вставка без заміни буфера
keymap("v", "p", '"_dP', opts)

-- ============================================================================
-- Навігація між вікнами
-- ============================================================================

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Зміна розміру вікон
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- ============================================================================
-- Навігація між буферами
-- ============================================================================

keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)

-- ============================================================================
-- Файловий провідник
-- ============================================================================

keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>ef", ":NvimTreeFocus<CR>", opts)

-- ============================================================================
-- Telescope
-- ============================================================================

keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fc", ":Telescope colorscheme<CR>", opts)
keymap("n", "<leader>fm", ":Telescope marks<CR>", opts)

-- ============================================================================
-- LSP
-- ============================================================================

keymap("n", "gD", vim.lsp.buf.declaration, opts)
keymap("n", "gd", vim.lsp.buf.definition, opts)
keymap("n", "K", vim.lsp.buf.hover, opts)
keymap("n", "gi", vim.lsp.buf.implementation, opts)
keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
keymap("n", "gr", vim.lsp.buf.references, opts)
keymap("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
keymap("n", "[d", vim.diagnostic.goto_prev, opts)
keymap("n", "]d", vim.diagnostic.goto_next, opts)
keymap("n", "<leader>d", vim.diagnostic.open_float, opts)
keymap("n", "<leader>dl", vim.diagnostic.setloclist, opts)

-- ============================================================================
-- Git (Gitsigns)
-- ============================================================================

keymap("n", "<leader>gb", ":Gitsigns blame_line<CR>", opts)
keymap("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", opts)
keymap("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", opts)
keymap("n", "]g", ":Gitsigns next_hunk<CR>", opts)
keymap("n", "[g", ":Gitsigns prev_hunk<CR>", opts)

-- ============================================================================
-- Trouble (Діагностика)
-- ============================================================================

keymap("n", "<leader>tt", ":TroubleToggle<CR>", opts)
keymap("n", "<leader>tw", ": Trouble workspace_diagnostics<CR>", opts)
keymap("n", "<leader>td", ":Trouble document_diagnostics<CR>", opts)
keymap("n", "<leader>tq", ":Trouble quickfix<CR>", opts)

-- ============================================================================
-- Коментарі
-- ============================================================================

keymap("n", "<leader>/", ":lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("v", "<leader>/", ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

-- ============================================================================
-- Термінал
-- ============================================================================

keymap("n", "<leader>tf", ": ToggleTerm direction=float<CR>", opts)
keymap("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", opts)
keymap("n", "<leader>tv", ":ToggleTerm direction=vertical size=80<CR>", opts)

-- Вихід з термінального режиму
keymap("t", "<Esc>", "<C-\\><C-n>", opts)
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)