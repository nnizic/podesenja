return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    -- lakša čitljivost
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions

    null_ls.setup({
      sources = {
        -- 🔧 Formatters
        formatting.prettier.with({
          extra_filetypes = { "svelte", "astro" },
        }),
        formatting.stylua,
        formatting.isort,
        formatting.black,
        formatting.clang_format,

        -- 🩺 Diagnostics (iz none-ls-extras)
        require("none-ls.diagnostics.cpplint"),

        -- 🧩 Ostalo
        require("none-ls.formatting.jq"),
        require("none-ls.code_actions.eslint_d"),
      },

      -- 🔁 automatsko formatiranje pri spremanju (opcionalno, ali vrlo korisno)
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
    -- kreiraj (ili koristi postojeću) grupu prije brisanja
            local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
    })
  end,
}

