return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    
    -- Prečice su iste kao i prije
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Traži Datoteke" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Traži Tekst (Grep)" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Traži Buffere" },
      { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Traži Git Datoteke" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Traži Pomoć (Help)" },
    },

    -- ✅ ISPRAVAK: Prebačeno s 'opts' na 'config'
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          -- Ovdje ide sva konfiguracija koja je prije bila u 'opts'
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "bottom",
              preview_width = 0.55,
              results_height = 0.4,
            },
          },
          mappings = {
            i = {
              -- Sada je 'actions.close' siguran za korištenje
              ["<esc>"] = actions.close,
            },
          },
        },
      })

      -- ✅ Ključni dio: Učitaj fzf-native ekstenziju
      -- Ovo je potrebno da bi se 'build = "make"' iskoristio
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
