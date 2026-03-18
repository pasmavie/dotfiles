local map = vim.keymap.set

-- Ported from ~/dotfiles/vim/vimrc

-- Line start/end (B/E)
map("n", "B", "^", { desc = "Start of line" })
map("n", "E", "$", { desc = "End of line" })

-- jj to escape
map("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Buffer cycling
map("n", "<C-n>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<C-p>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Black-hole delete (don't yank on delete)
map("n", "d", '"_d', { desc = "Delete without yank" })
map("v", "d", '"_d', { desc = "Delete without yank" })

-- Paste without yanking replaced text
map("v", "<leader>p", '"_dP', { desc = "Paste without yank" })

-- System clipboard yank
map("v", "<C-y>", '"*y', { desc = "Yank to system clipboard" })

-- Close buffer without closing window
map("n", "<C-q>", "<cmd>bp|bd #<CR>", { desc = "Close buffer, keep window" })
