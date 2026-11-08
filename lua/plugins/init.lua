vim.pack.add({
  -- LSP
  { src = 'https://github.com/neovim/nvim-lspconfig' },

  -- Mason
  { src = 'https://github.com/mason-org/mason.nvim.git' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim.git' },
})

require("plugins.lsp")

