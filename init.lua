-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- local builtin = require("telescope.builtin")
-- vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
-- vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
-- vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
-- vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

vim.cmd([[
set relativenumber
set wrap
map <C-J> :bnext<CR>
map <C-K> :bprev<CR>
nnoremap <leader>q :bd<bar>bn<CR>
]])
