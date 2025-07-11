local keymap = vim.keymap

-- Nvim Tree
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

-- Undo Tree
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Open Undo Tree" })

-- telescope

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

vim.keymap.set("n", "<leader>ff", function()
	builtin.find_files({ hidden = true })
end, { desc = "Fuzzy find files in cwd" })

-- jk escape
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })

-- auto session
vim.keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
vim.keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory

-- clear search highlights
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x')

-- increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
for i = 1, 9 do
	vim.api.nvim_set_keymap("n", "<leader>t" .. i, ":tabn " .. i .. "<CR>", { noremap = true, silent = true })
end

-- harpoon
local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>ga", function()
	harpoon:list():add()
end, { desc = "Add file to harpoon list" })
vim.keymap.set("n", "<leader>gq", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "open harpoon quick menu" })
vim.keymap.set("n", "<leader>gh", function()
	harpoon:list():select(1)
end, { desc = "Go to 1st harpoon file" })
vim.keymap.set("n", "<leader>gj", function()
	harpoon:list():select(2)
end, { desc = "Go to 2nd harpoon file" })
vim.keymap.set("n", "<leader>gk", function()
	harpoon:list():select(3)
end, { desc = "Go to 3rd harpoon file" })
vim.keymap.set("n", "<leader>gl", function()
	harpoon:list():select(4)
end, { desc = "Go to 4th harpoon file" })
vim.keymap.set("n", "<leader>gp", function()
	harpoon:list():prev()
end, { desc = "Go to previous harpoon file" })
vim.keymap.set("n", "<leader>gn", function()
	harpoon:list():next()
end, { desc = "Go to next harpoon file" })

vim.keymap.set("n", "<leader>gr", function()
	harpoon:list():remove()
end, { desc = "Remove file from Harpoon list" })

-- select entire file
vim.keymap.set("n", "<leader>a", "gg^vG$", { noremap = true, silent = true })

--- copy & paste into named buffers
vim.keymap.set("n", "<leader>ya", '"ayy', { desc = "Yank current line into buffer a" })
vim.keymap.set("v", "<leader>ya", '"ay', { desc = "Yank visually selected text into buffer a" })
vim.keymap.set("n", "<leader>yb", '"byy', { desc = "Yank current line into buffer b" })
vim.keymap.set("v", "<leader>yb", '"by', { desc = "Yank visually selected text into buffer b" })
vim.keymap.set("n", "<leader>pa", '"ap', { desc = "Paste from buffer a" })
vim.keymap.set("v", "<leader>pa", '"ap', { desc = "Paste from buffer a (visual)" })
vim.keymap.set("n", "<leader>pb", '"bp', { desc = "Paste from buffer " })
vim.keymap.set("v", "<leader>pb", '"bp', { desc = "Paste from buffer b (visual)" })

-- removed default mapping to avoid conflict
vim.api.nvim_set_keymap("n", "<C-]>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-[>", "<Nop>", { noremap = true, silent = true })
-- custom enable disable logic for smear cursor
vim.keymap.set("n", "<leader>scd", function()
	require("smear_cursor").enabled = false
end, { desc = "Disable Smear Cursor" })

vim.keymap.set("n", "<leader>sce", function()
	require("smear_cursor").enable = true
end, { desc = "Enable Smear Cursor" })
