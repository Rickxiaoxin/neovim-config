tools = { }

require("mason").setup({})

require("mason-lspconfig").setup({
  ensure_installed = { "basedpyright", "ruff" },
  automatic_enable = true,
})

local mr = require("mason-registry")
mr.refresh(function ()
  for _, tool in ipairs(tools) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end)

-- Diagnostic config
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
})

