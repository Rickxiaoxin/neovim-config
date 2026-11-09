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

local gh = function(x)
  return 'https://github.com/' .. x
end

vim.pack.add({
  -- LSP
  { src = gh('neovim/nvim-lspconfig') },

  -- Mason
  { src = gh('mason-org/mason.nvim.git') },
  { src = gh('mason-org/mason-lspconfig.nvim.git') },

  -- Tree sitter
  { src = gh('nvim-treesitter/nvim-treesitter.git') },
})

require("plugins.lsp")
require("plugins.treesitter")

