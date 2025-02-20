return {
  "akinsho/bufferline.nvim",
  requires = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup {
      options = {
        numbers = "ordinal", -- Prikazuje redne brojeve pored buffera (options: "none", "ordinal", "buffer_id", "both")
        close_command = "bdelete! %d", -- Komanda za zatvaranje buffera
        indicator = {
          icon = "▎", -- Indikator trenutnog buffera
          style = "icon", -- Može biti i "underline" ili "none"
        },
        buffer_close_icon = "", -- Ikona za zatvaranje buffera
        modified_icon = "●", -- Ikona za izmjene
        close_icon = "", -- Globalna ikona za zatvaranje
        left_trunc_marker = "", -- Ikona za lijevo skraćivanje
        right_trunc_marker = "", -- Ikona za desno skraćivanje
        max_name_length = 18, -- Maksimalna duljina imena
        max_prefix_length = 15, -- Maksimalna duljina prefiksa
        truncate_names = true, -- Skrati preduga imena
        tab_size = 18, -- Veličina taba
        diagnostics = "nvim_lsp", -- Prikaz LSP dijagnostike (može biti "nvim_lsp", "coc", ili "none")
        diagnostics_update_in_insert = false, -- Ažuriranje dijagnostike u insert modu
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "NvimTree", -- Offset za NvimTree
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
        show_buffer_icons = true, -- Prikaz ikona pored buffera
        show_buffer_close_icons = true, -- Prikaz ikona za zatvaranje buffera
        show_close_icon = false, -- Sakrij globalnu ikonu za zatvaranje
        show_tab_indicators = true, -- Prikaz indikatora za tabove
        persist_buffer_sort = true, -- Zadrži sortiranje buffera
        separator_style = "slant", -- Stil separatora ("slant", "thick", "thin", itd.)
        enforce_regular_tabs = false, -- Koristi različite širine za tabove
        always_show_bufferline = true, -- Uvijek prikazuj bufferline
        hover = {
          enabled = false, -- Isključuje hover efekt
        },
        sort_by = "insert_after_current", -- Sortiranje buffera
      },
    }
  end,
}

