return {
	"kevinhwang91/nvim-ufo",
	dependencies = "kevinhwang91/promise-async",
	config = function()
		vim.o.foldcolumn = "1" -- '0' is not bad
		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		vim.opt.foldcolumn = "1" -- Shows 1 column for folds
		vim.opt.fillchars = {
			fold = " ", -- Remove ugly default chars
			foldopen = "▾", -- or '▼', '', etc.
			foldclose = "▸", -- or '▶', '', etc.
			foldsep = " ", -- No vertical separators
		}

		vim.keymap.set("n", "zR", require("ufo").openAllFolds)
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

		require("ufo").setup({

			fold_open_icon = "▾ ", -- icon with trailing space
			fold_closed_icon = "▸ ", -- icon with trailing space
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		})
		require("ufo").setup({
			open_fold_hl_timeout = 0,
			close_fold_kinds = { "imports", "comment" }, -- optional
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				-- Make folded line show the original header (1st line)
				local newVirtText = {}
				local suffix = ("  %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
						curWidth = curWidth + chunkWidth
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						table.insert(newVirtText, { chunkText, chunk[2] })
						break
					end
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end,
		})
	end,
}
