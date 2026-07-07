vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" }
})

vim.api.nvim_create_autocmd("BufEnter", {
   callback = function(args)
      pcall(vim.treesitter.start, args.buf)
   end,
})

require'nvim-treesitter'.setup ({})
