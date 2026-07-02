return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              -- Suppress undefined global warnings for Hyprland and Neovim
              globals = { "hl", "vim" },
            },
            workspace = {
              library = {
                "/usr/share/hypr/stubs",
              },
            },
          },
        },
      },
    },
  },
}
