return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Lista parsera koje želimo. Vue ovisi o drugima.
        ensure_installed = {
          "vue",
          "javascript",
          "typescript",
          "html",
          "css",
          "scss",
          "json",
          "lua", -- za konfiguraciju Nvim-a
          "bash",
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
}
