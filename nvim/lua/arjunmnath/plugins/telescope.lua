return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local open_with_trouble = require("trouble.sources.telescope").open
		-- local add_to_trouble = require("trouble.sources.telescope").add
		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-t>"] = open_with_trouble,
					},
					n = { ["<C-t>"] = open_with_trouble },
				},
				vimgrep_arguments = {
					"rg",
					"--color=never", -- <-- change this
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--no-ignore", -- optional but recommended
				},
			},
		})
		telescope.load_extension("fzf")
	end,
}
