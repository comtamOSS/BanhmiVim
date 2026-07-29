vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	once = true,
	callback = function()
      vim.pack.add({
         {  src = 'https://github.com/echasnovski/mini.pairs', version = vim.version.range('*') },
      })

      require("mini.pairs").setup({
         mappings = {
            -- ['|'] = { action = 'closeopen', pair = '||', neigh_pattern = '[^\\].', register = { cr = false } },
         }
      })
	end,
})

