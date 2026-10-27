-- Options

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

-- Colorscheme
vim.cmd("colorscheme catppuccin")
