return {

  -- ***********
  -- * SETTING *
  -- ***********
  editor = {

    -- 
    -- value: "absolute" | "relative" | "none"
    number = "relative",


  },


  -- ****************************
  -- *  LANGUAGE_SERVER_ENABLED *
  -- ****************************
  -- This only enable the lsp, not install them,
  -- please check the `:Mason` to install them
  language_server_enabled = {
     "lua_ls",
     "html",
     "cssls",
     "ts_ls",
     -- "pyright",
     -- "marksman",
     -- "gopls",
     -- "volar",
     -- "tailwindcss",
     -- "zls",
     -- "svelte",
     -- "csharp_ls",
     -- "bashls",
     -- "tinymist",
     -- "rnix",
     -- "sqls",
     -- "postgres_lsp",
     -- "eslint",
     --	"phpactor",
     -- "pylsp",
     -- "basedpyright",
     -- "rust_analyzer",
     -- "jdtls",
     -- "ltex",
     -- "typst_lsp",
     -- "dartls"
  },

  treesister = {
    "lua",
    "html",
    "css",
    "javascript",
  },


  autocmd = {
      remove_trailing_whitespace_on_save = true,
      highlight_yank = true,
      no_auto_comment_on_new_line = false,
      restore_position_in_last_time_edit = true,
      show_cursorline_only_in_active_window = true,
      syntax_highlight_for_dotenv_file = true,
      virtualtext_for_heading = true,
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
