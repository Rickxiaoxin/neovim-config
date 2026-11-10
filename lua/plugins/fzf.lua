require("fzf-lua").setup({
})

vim.keymap.set( {''}, '<leader>ff', "<Cmd>FzfLua files<CR>" , { desc = "Find Files" })
vim.keymap.set( {''}, '<leader>/', "<Cmd>FzfLua grep<CR>" , { desc = "Search Pattern" })

