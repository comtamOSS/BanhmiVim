vim.pack.add({
   { src = "https://github.com/nvim-lualine/lualine.nvim" }
})


-- local colors, _ = require("monoglow.colors").setup({})
local colors = require("everforest.colours").generate_palette({
      colours_override = function(_) end,
   }, "dark")


local mode_color = {
   n = colors.blue,
   i = colors.green,
   v = colors.magenta or colors.orange,
   [''] = colors.magenta or colors.orange,
   V = colors.magenta or colors.orange,
   c = colors.cyan or colors.aqua,
   no = colors.red,
   s = colors.orange,
   S = colors.orange,
   [''] = colors.orange,
   ic = colors.yellow,
   R = colors.violet,
   Rv = colors.violet,
   cv = colors.red,
   ce = colors.red,
   r = colors.cyan,
   rm = colors.cyan,
   ['r?'] = colors.cyan,
   ['!'] = colors.red,
   t = colors.red,
}

local icons = {
   n = "󰄛 ",
   i = "󰏫 ",
   v = "󰒉 ",
   [''] = "󰒉 ",
   V = "󰒉 ",
   c = " ",
   no = "",
   s = "",
   S = "",
   [''] = "",
   ic = "",
   R = "",
   Rv = "",
   cv = "",
   ce = "",
   r = "",
   rm = "",
   ['r?'] = "",
   ['!'] = "",
   t = " ",
}

local function codeium_status()
   return vim.api.nvim_call_function("codeium#GetStatusString", {})
end

local function get_word_count()
   return tostring(vim.fn.wordcount().words) .. "w"
end

local function is_markdown()
   return vim.bo.filetype == "markdown"
end

require("lualine").setup({
   options = {
      theme = "auto",
      -- component_separators = "|",
      component_separators = "",
      -- section_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
   },
   sections = {
      lualine_a = {
         -- {
         --          "mode",
         --          -- separator = { left = "" },
         --          separator = { left = "" },
         --          right_padding = 2,
         --       },
         {
            "mode",
            color = function()
               return { fg = colors.bg0, bg = mode_color[vim.fn.mode()] }
            end,
            padding = { left = 1 },    -- We don't need space before this

         },
      },
      lualine_b = {
         {
            function()
               return icons[vim.fn.mode()]
            end,
            color = function()
               return { fg = colors.bg0, bg = mode_color[vim.fn.mode()] }
            end,
         },
         {
            "branch",
            color = function()
               return { fg = mode_color[vim.fn.mode()], bg = "" }
            end,
         },
         {
            "diagnostics",
            color = function()
               return { fg = mode_color[vim.fn.mode()], bg = "" }
            end,
            symbols = {
               error = " ",
               warn = " ",
               info = " ",
               hint = "󰌵 ",
            },
         },
      },
      lualine_y = {
         {
            "progress",
            color = function()
               return { fg = mode_color[vim.fn.mode()], bg = "" }
            end,
         }
      },
      lualine_z = {
         {
            "location",
            color = function()
               return { fg = mode_color[vim.fn.mode()], bg = "" }
            end,
         },
         {
            get_word_count,
            cond = is_markdown,
         },
         {
            codeium_status,
            icons_enabled = true,
            icon = "󱚤",
            separator = {
               left = "",
               right = "",
            },
            color = function()
               return { fg = mode_color[vim.fn.mode()], bg = "" }
            end,
         },
      },
   },
   extensions = {
      -- "nvim-tree",
      "neo-tree"
   },
})
