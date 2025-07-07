return {
	"chomosuke/typst-preview.nvim",
	lazy = false, -- or ft = 'typst'
	version = "1.*",
	config = function()
		require("typst-preview").setup({
			dependencies_bin = {
				["tinymist"] = "tinymist",
			},
			invert_colors = "auto",
		})
		vim.api.nvim_create_user_command("OpenPdf", function()
			local filepath = vim.api.nvim_buf_get_name(0)
			if filepath:match("%.typ$") then
				local pdf_path = filepath:gsub("%.typ$", ".pdf")
				vim.loop.spawn("open", { args = { pdf_path } }, function(code, signal)
					if code ~= 0 then
						print("Failed to open PDF (exit code " .. code .. ")")
					end
				end)
			end
		end, {})
	end,
}
