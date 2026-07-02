return {
  -- 1. Enable theme-specific transparency (example using tokyonight)
  {
    "olimorris/onedarkpro.nvim",
    opts = {
      options = {
        transparency = true, -- Enable base transparent background
      },
      highlights = {
        -- Force absolute and relative line numbers to have a transparent background
        LineNr = { bg = "NONE" },
        -- Force the active line number to have a transparent background
        CursorLineNr = { bg = "NONE" },
        -- Clear the vertical column where git symbols and linting flags sit
        SignColumn = { bg = "NONE" },
        -- Prevents a colored bar tracking across the background behind your cursor line
        CursorLine = { bg = "NONE" },
        StatusLine = { bg = "NONE" }, -- Clear standard Neovim status line
        StatusLineNC = { bg = "NONE" }, -- Clear inactive status line
        MsgArea = { bg = "NONE" },
      },
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- 2. Ensure transparency is preserved when switching buffers/reloading
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          -- Force background to NONE for core UI elements
          local highlights = {
            "Normal",
            "NormalNC",
            "SignColumn",
            "StatusLine",
            "StatusLineNC",
            "Pmenu",
            "PmenuSel",
            "NeoTreeNormal",
            "NeoTreeNormalNC",
          }
          for _, hl in ipairs(highlights) do
            vim.cmd("highlight " .. hl .. " guibg=NONE ctermbg=NONE")
          end
        end,
      })
    end,
  },
}
