require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = { "basedpyright", "ruff" },
  automatic_enable = true,
})

-- Diagnostic config
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
})

