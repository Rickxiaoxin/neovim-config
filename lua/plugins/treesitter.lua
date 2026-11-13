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

install_langs(languages)

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
