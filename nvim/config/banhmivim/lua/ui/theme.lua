vim.pack.add({
  { src = "https://github.com/wnkz/monoglow.nvim" }
})

require("monoglow").setup({})

vim.cmd[[colorscheme monoglow]]
