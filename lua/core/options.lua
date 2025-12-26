-- ============================================================================
-- Основні налаштування Neovim
-- ============================================================================

local opt = vim.opt

-- Загальні налаштування
opt.mouse = "a"                    -- Підтримка миші
opt.clipboard = "unnamedplus"      -- Системний буфер обміну
opt.swapfile = false               -- Без swap файлів
opt.backup = false                 -- Без backup файлів
opt.writebackup = false            -- Без backup при збереженні
opt.undofile = true                -- Постійна історія змін
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Інтерфейс
opt.number = true                  -- Номери рядків
opt.relativenumber = true          -- Відносні номери
opt.cursorline = true              -- Підсвічування поточного рядка
opt.signcolumn = "yes"             -- Завжди показувати колонку знаків
opt.wrap = false                   -- Без переносу рядків
opt.scrolloff = 8                  -- Відступ від краю при скролі
opt.sidescrolloff = 8
opt.showmode = false               -- Не показувати режим (є в statusline)
opt.termguicolors = true           -- 24-bit кольори
opt.pumheight = 10                 -- Висота popup меню
opt.cmdheight = 1                  -- Висота командного рядка

-- Розділення вікон
opt.splitbelow = true              -- Горизонтальні вікна внизу
opt.splitright = true              -- Вертикальні вікна справа

-- Відступи та табуляція
opt.tabstop = 4                    -- Ширина табуляції
opt.shiftwidth = 4                 -- Ширина відступу
opt.expandtab = true               -- Пробіли замість табів
opt.smartindent = true             -- Розумні відступи
opt.autoindent = true

-- Пошук
opt.hlsearch = false               -- Не підсвічувати пошук після знайдення
opt.incsearch = true               -- Інкрементальний пошук
opt.ignorecase = true              -- Ігнорувати регістр при пошуку
opt.smartcase = true               -- Враховувати регістр якщо є великі літери

-- Продуктивність
opt.updatetime = 250               -- Швидше оновлення
opt.timeoutlen = 300               -- Швидше спрацювання комбінацій
opt.lazyredraw = false

-- Доповнення
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess: append "c"

-- Файли
opt.fileencoding = "utf-8"
opt.conceallevel = 0

-- Список невидимих символів
opt.list = true
opt.listchars = { tab = "→ ", trail = "·", nbsp = "␣" }

-- Колонка для переносу (опціонально)
opt.colorcolumn = "100"

-- Складання коду
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false             -- Розгорнуто за замовчуванням