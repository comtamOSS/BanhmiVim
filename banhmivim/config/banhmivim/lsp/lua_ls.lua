return {
   cmd = { 'lua-language-server' },
   filetypes = { 'lua' },
   root_markers = {
      '.luarc.json',
      '.luarc.jsonc',
      '.luacheckrc',
      '.stylua.toml',
      'stylua.toml',
      'selene.toml',
      'selene.yml',
      '.git',
   },
   settings = {
      Lua = {
         runtime = {
            version = "LuaJIT",
         },
         diagnostics = {
            globals = { "vim" },
         },
         workspace = {
            library = {
               vim.env.VIMRUNTIME,
            },
         },
      },
   },
   on_attach = function(client, bufnr)
      vim.lsp.completion.enable(true, client.id, bufnr, {
         autotrigger = true,
         convert = function(item)
            return { abbr = item.label:gsub('%b()', '') }
         end,

      })
   end,
}
