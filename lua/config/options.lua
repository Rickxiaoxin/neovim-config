-- Set the <Leader> and <LocalLeader>
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Display line number and sign in front of each line
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'

-- Indents and tabs
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Ignore character case
vim.o.ignorecase = true
vim.o.smartcase = true

-- Minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 5

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard:append({ 'unnamedplus' })

-- Open all fold
vim.wo.foldlevel = 99

-- Colorscheme
vim.cmd("colorscheme catppuccin")

