return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = true },
    setup = {
      vim.keymap.set("n", "<leader>h", function()
        local current_setting = vim.lsp.inlay_hint.is_enabled(nil)
        vim.lsp.inlay_hint.enable(not current_setting)
      end, { desc = "Toggle Inlay Hints" }),
    },
  },
}
