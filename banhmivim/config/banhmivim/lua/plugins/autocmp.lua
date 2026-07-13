vim.pack.add({
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1.*"),
	},
  "https://github.com/rafamadriz/friendly-snippets"
})

-- Lazy load on first insert mode entry (may not necessary)
local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	group = group,
	once = true,
	callback = function()
		require("blink.cmp").setup({
      cmdline = {
         keymap = {
            preset = "none",
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<Tab>"] = { "select_next", "fallback" },
            --   ["<CR>"] = { "accept", "fallback" },
         },
         completion = { menu = { auto_show = true } },
      },

      keymap = {
         preset = "default",
         -- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
         -- ["<C-e>"] = { "hide" },
         ["<CR>"] = { "accept", "fallback" },

         ["<S-Tab>"] = { "select_prev", "fallback" },
         ["<Tab>"] = { "select_next", "fallback" },

         -- ["<C-b>"] = { "scroll_documentation_up", "fallback" },
         -- ["<C-f>"] = { "scroll_documentation_down", "fallback" },

         -- ["<Tab>"] = { "snippet_forward", "fallback" },
         -- ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
      completion = {
         list = {
            selection = {
               preselect = function(ctx)
                  return ctx.mode ~= "cmdline"
               end,
               auto_insert = function(ctx)
                  return ctx.mode == "cmdline"
               end
            }
         },
         menu = {
            -- nvim-cmp style menu
            draw = {
               columns = {
                  { "kind_icon" },
                  { "label",    "label_description", gap = 1 },
               },
            },
         },
         documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },


      appearance = {
         -- Sets the fallback highlight groups to nvim-cmp's highlight groups
         -- Useful for when your theme doesn't support blink.cmp
         -- Will be removed in a future release
         -- use_nvim_cmp_as_default = true,
         -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
         -- Adjusts spacing to ensure icons are aligned
         nerd_font_variant = "normal",
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      -- snippets = { preset = 'luasnip' },
      sources = {
         default = {
            "lsp",
            "path",
            "snippets",
            "buffer",
            -- "html-css",
            -- "avante",
         },
         providers = {
            -- ["html-css"] = {
            --    name = "html-css",
            --    module = "blink.compat.source"
            -- },
            -- avante = {
            --    module = 'blink-cmp-avante',
            --    name = 'Avante',
            --    opts = {
            --       -- options for blink-cmp-avante
            --    }
            -- },
            snippets = {
               opts = {
                  friendly_snippets = true, -- default
                  extended_filetypes = {
                     razor = { 'html' },
                  }
               }
            }
         }
      },
		})
	end,

})

