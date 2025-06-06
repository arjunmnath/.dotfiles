return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local colors = {
			blue = "#65D1FF",
			green = "#3EFFDC",
			violet = "#FF61EF",
			yellow = "#FFDA7B",
			red = "#FF4A4A",
			fg = "#c3ccdc",
			bg = "#112638",
			inactive_bg = "#2c3043",
		}

		local my_lualine_theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
				b = { bg = colors.inactive_bg, fg = colors.semilightgray },
				c = { bg = colors.inactive_bg, fg = colors.semilightgray },
			},
		}

		local fidget = require("fidget.progress")

		local function lsp_progress()
			local messages = fidget.get_progress_messages()
			if #messages == 0 then
				return ""
			end

			local msg = messages[1] -- only show the first
			local title = msg.title or ""
			local msg_text = msg.message or ""
			local percentage = msg.percentage and (msg.percentage .. "%%") or ""

			return string.format("LSP: %s %s %s", title, msg_text, percentage)
		end
		-- configure lualine with modified theme
		lualine.setup({
			-- options = {
			--   theme = my_lualine_theme,
			-- },
			options = {
				theme = "auto", -- Use your current theme
				icons_enabled = true, -- Enable icons
				-- section_separators = { left = '', right = '' }, -- Optional
				-- component_separators = { left = '', right = '' }, -- Optional
			},
			sections = {
				lualine_c = {
					lsp_progress,
					{
						function()
							local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
							local clients = vim.lsp.get_active_clients()
							for _, client in pairs(clients) do
								if
									client.attached_buffers and client.attached_buffers[vim.api.nvim_get_current_buf()]
								then
									return client.name
								end
							end
							return ""
						end,
						icon = " LSP:",
					},
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
