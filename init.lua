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

-- Minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 5

-- Sync clipboard between OS and Neovim. Schedule the setting after `UIEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:h 'clipboard'`
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- Colorscheme
vim.cmd("colorscheme catppuccin")
