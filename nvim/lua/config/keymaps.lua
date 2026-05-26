local functions = require("config.functions")

local telescope = require("telescope")
local live_grep = require("telescope.builtin").live_grep
local find_files = require("telescope.builtin").find_files

vim.keymap.set("n", "<leader>e", telescope.extensions.file_browser.file_browser, { desc = "Browse files." })
vim.keymap.set("n", "<leader>ff", find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", live_grep, { desc = "Live grep in current directory" })
vim.keymap.set("n", "<leader>ff", find_files, { desc = "Find filenames in current directory" })
vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

vim.keymap.set("n", "K", functions.hover_window, { desc = "Hover info from LSP" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (workspace)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Diagnostics (buffer)" })
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols" })
vim.keymap.set(
	"n",
	"<leader>cl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP refs/defs/etc" }
)
