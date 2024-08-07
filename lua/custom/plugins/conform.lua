return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofumpt" },
        javascript = { "prettierd", stop_after_first = true },
        typescript = { "prettierd", stop_after_first = true },
        typescriptreact = { "prettierd", stop_after_first = true },
        css = { "prettierd", stop_after_first = true },
        python = { "black" }
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })
  end,
}
