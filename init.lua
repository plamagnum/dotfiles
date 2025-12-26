-- ============================================================================
-- Neovim Configuration - Modern IDE Setup
-- ============================================================================

-- Встановлення leader клавіші перед завантаженням плагінів
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Завантаження основних налаштувань
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Завантаження плагінів
require("plugins")