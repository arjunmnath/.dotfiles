return {
	"j-hui/fidget.nvim",
	opts = {
		-- options
	},
	config = function()
		require("telescope").load_extension("fidget")
		local fidget = require("fidget")
		fidget.setup({})
	end,
}
