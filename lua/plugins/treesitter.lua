local languages = {
  'c',
  'lua',
  'markdown',
  'markdown_inline',
  'vim',
  'vimdoc',
  'query',
  'python',
}

require('nvim-treesitter').setup({
})

require('nvim-treesitter').install(languages)

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup("Treesitter", { clear = true }),
  pattern = languages,
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
