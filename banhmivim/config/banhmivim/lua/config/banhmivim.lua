return {
  editor = {
    -- "absolute" | "relative" | "none"
    number = "relative",
  },

  languages = {
    "lua"
  },

  treesister = {
    "lua",
    "html",
    "css",
    "javascript",
  },


  autocmd = {
     remove_trailing_whitespace_on_save = true,

     more = function ()
     end
  },

  extras = {
    -- WEB-ESSENTIAL
    -- html, css, js stack
    web_essential = {
      enable = false,
    },

    -- FLUTTER
    -- mobile development
    flutter = {
      enable = false
    },

    dotnet = {
      enable = false
    }
  },

  debug = {
  }
}
