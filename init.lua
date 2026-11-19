-- Eable faster startup by caching compiled lua modules
vim.loader.enable()

-- Set the <Leader> and <LocalLeader>
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Display line number and sign in front of each line
vim.o.number = true
vim.o.signcolumn = 'yes'

-- Enable mouse
vim.o.mouse = 'a'

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true

-- Indents and tabs
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Ignore character case
vim.o.ignorecase = true
vim.o.smartcase = true

-- Minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 5

-- Show which line your cursor is on
vim.o.cursorline = true

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UIEnter` because it can increase startup-time.
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- Open all fold
vim.wo.foldlevel = 99

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true


-- Diagnostic Config & Keymaps
vim.diagnostic.config {
  virtual_text = true,
  virtual_lines = false,
}

vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>')

-- Build hooks
local plugins_build = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'nvim-treesitter' and kind == 'update' then
    if not ev.data.active then
      vim.cmd.packadd('nvim-treesitter')
    end
    vim.cmd('TSUpdate')
  end
end
vim.api.nvim_create_autocmd('PackChanged', { callback = plugins_build })

local gh = function(x)
  return 'https://github.com/' .. x
end

vim.pack.add({
  -- LSP
  { src = gh('neovim/nvim-lspconfig') },

  -- Mason
  { src = gh('mason-org/mason.nvim') },
  { src = gh('mason-org/mason-lspconfig.nvim') },

  -- Tree sitter
  { src = gh('nvim-treesitter/nvim-treesitter') },

  -- Fuzzy finder
  { src = gh('ibhagwan/fzf-lua') },

  { src = gh('lervag/vimtex') }
})

-- LSP Configuration
require("mason").setup({})

local servers = { "basedpyright", "ruff" }

require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_enable = true,
})

local tools = {}
local mr = require("mason-registry")
mr.refresh(function ()
  for _, tool in ipairs(tools) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end)

-- Treesitter
local parser = {
  'c',
  'lua',
  'markdown',
  'markdown_inline',
  'vim',
  'vimdoc',
  'query',
  'python',
  'latex',
}

require('nvim-treesitter').setup({})

local function install_treesitter_cli(callback)
  if not pcall(require, "mason") then
    return callback(false, "Mason.nvim is required!")
  end

  local mr = require("mason-registry")
  mr.refresh(function()
    local p = mr.get_package("tree-sitter-cli")
    if not p:is_installed() then
      p:install(
        nil,
        vim.schedule_wrap(function(success)
          if success then
            callback(true)
          else
            callback(false, "Failed to install `tree-sitter-cli` with `mason.nvim`.")
          end
        end)
      )
    end
  end)
end

local function ensure_treesitter_cli(callback)
  if vim.fn.executable("tree-sitter") == 0 then
    return install_treesitter_cli(callback)
  end
  return callback(true)
end

local function install_langs(langs)
  ensure_treesitter_cli(function(stat, msg)
    if stat then
      require('nvim-treesitter').install(langs)
    else
      vim.notify(msg, vim.log.levels.INFO)
    end
  end)
end

install_langs(parser)

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup("Treesitter", { clear = true }),
  pattern = parser,
  callback = function(_)
    -- syntax highlighting, provided by Neovim
    vim.treesitter.start()
    -- folds, provided by Neovim
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldmethod = 'expr'
    -- indentation, provided by nvim-treesitter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- Diagnostic config
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
})


-- fzf-lua
require("fzf-lua").setup({})

vim.keymap.set( {''}, '<leader>ff', "<Cmd>FzfLua files<CR>" , { desc = "Find Files" })
vim.keymap.set( {''}, '<leader>/', "<Cmd>FzfLua grep<CR>" , { desc = "Search Pattern" })

-- Colorscheme
vim.cmd("colorscheme catppuccin")

-- vim: set sts=2 sw=2 et:
