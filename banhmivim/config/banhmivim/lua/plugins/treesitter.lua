vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" }
})

vim.api.nvim_create_autocmd("BufEnter", {
   callback = function(args)
      pcall(vim.treesitter.start, args.buf)
   end,
})

local lang_list = require("config.banhmivim").treesister
require('nvim-treesitter').install(lang_list)

-- require'nvim-treesitter'.setup ({})


