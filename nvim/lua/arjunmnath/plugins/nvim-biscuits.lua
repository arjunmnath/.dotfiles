return {
	"code-biscuits/nvim-biscuits",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("nvim-biscuits").setup({})
	end,
}
