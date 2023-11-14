-- return {
--   "navarasu/onedark.nvim",
--   name = "onedark",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("onedark").setup({})
--     vim.cmd.colorscheme("onedark")
--   end,
-- }
return {
  "rebelot/kanagawa.nvim",
  name = "kanagawa",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      theme = "wave",
    })
    vim.cmd.colorscheme("kanagawa")
  end,
}
