return {
  -- 🎨 Tema boja (Iceberg)
  {
    "cocopon/iceberg.vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("iceberg")
    end,
  },

  -- 📑 NOVO: Traka s tabovima/bufferima na vrhu
  {
    "akinsho/bufferline.nvim",
    -- 'BufReadPre' osigurava da se učita odmah
    event = "BufReadPre", 
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        -- Koristi ikone
        show_buffer_icons = true,
        -- Pokaži gumb za zatvaranje
        show_buffer_close_icons = true,
        -- Koristi 'tabstop' koji smo definirali (2 razmaka)
        tab_size = 2,
        -- Malo razmaka između tabova
        separator_style = "padded",
        -- Pokaži dijagnostiku (LSP greške) na tabovima
        diagnostics = "nvim_lsp",
        -- Prečice za miš (npr. klik za promjenu, srednji klik za zatvaranje)
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          return "(" .. count .. ")"
        end,
      },
    },
  },

  -- 💎 Ikone (potrebne za LSP, bufferline i datoteke)
  { "nvim-tree/nvim-web-devicons" },

  -- 📊 Statusna linija (lualine) na dnu
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "iceberg",
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
    },
  },
}
