return {
	"karb94/neoscroll.nvim",
	opts = {},
	config = function()
		neoscroll = require("neoscroll")
		local keymap = {
			-- Use the "sine" easing function
			["<C-u>"] = function()
				neoscroll.ctrl_u({ duration = 250, easing = "circular" })
			end,
			["<C-d>"] = function()
				neoscroll.ctrl_d({ duration = 250, easing = "circular" })
			end,
			-- Use the "circular" easing function
			["<C-b>"] = function()
				neoscroll.ctrl_b({ duration = 450, easing = "circular" })
			end,
			["<C-f>"] = function()
				neoscroll.ctrl_f({ duration = 450, easing = "circular" })
			end,
			-- When no value is passed the `easing` option supplied in `setup()` is used
			["<C-y>"] = function()
				neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
			end,
			["<C-e>"] = function()
				neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
			end,

			["zt"] = function()
				neoscroll.zt({ half_win_duration = 250 })
			end,
			["zz"] = function()
				neoscroll.zz({ half_win_duration = 250 })
			end,
			["zb"] = function()
				neoscroll.zb({ half_win_duration = 250 })
			end,
		}
		for key, func in pairs(keymap) do
			vim.keymap.set({ "n", "v", "x" }, key, func)
		end
	end,
}
