-- Build hooks
local hooks = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'nvim-treesitter' and kind == 'update' then
    if not ev.data.active then
      vim.cmd.packadd('nvim-treesitter')
    end
    vim.cmd('TSUpdate')
  end
end
vim.api.nvim_create_autocmd('PackChanged', { callback = hooks })

vim.pack.add({
  -- LSP
  { src = 'https://github.com/neovim/nvim-lspconfig' },

  -- Mason
  { src = 'https://github.com/mason-org/mason.nvim.git' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim.git' },

  -- Tree sitter
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter.git' },
})

require("plugins.lsp")
require("plugins.treesitter")

