return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		vim.diagnostic.config({
			float = { border = "rounded" },
		})
		-- Get Conda Python Path
		local conda_prefix = os.getenv("CONDA_PREFIX")
		local python_path = conda_prefix and (conda_prefix .. "/bin/python") or vim.fn.exepath("python3")
		if conda_prefix then
			vim.env.VIRTUAL_ENV = conda_prefix
		end
		-- If Conda is activated, set the pythonPath
		lspconfig.pyright.setup({
			cmd = { python_path, "-m", "pyright", "--stdio" }, -- Ensures using the correct python from Conda
			root_dir = lspconfig.util.root_pattern(".git", "pyproject.toml", "setup.py"),
			settings = {
				python = {
					pythonPath = python_path, -- This ensures the Python path is configured correctly
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "openFilesOnly",
						useLibraryCodeForTypes = true,
					},
				},
			},
		})

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		-- LSP keybinds
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- Set keymaps
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		-- Completion capabilities for all LSP servers
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Diagnostic symbols in the sign column
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		-- Setup mason-lspconfig handlers
		for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
			local opts = {
				capabilities = capabilities,
			}
			if server == "tinymist" then
				opts.single_file_support = true
				opts.filetypes = { "typst" }
				opts.settings = {
					formatterMode = "typstfmt",
					exportPdf = "onSave",
					semanticTokens = "disable",
				}
				opts.on_attach = function(client, bufnr)
					vim.keymap.set("n", "<leader>ltp", function()
						client:exec_cmd({
							title = "pin",
							command = "tinymist.pinMain",
							arguments = { vim.api.nvim_buf_get_name(0) },
						}, { bufnr = bufnr })
					end, { desc = "[T]inymist [P]in", noremap = true })

					vim.keymap.set("n", "<leader>ltu", function()
						client:exec_cmd({
							title = "unpin",
							command = "tinymist.pinMain",
							arguments = { vim.v.null },
						}, { bufnr = bufnr })
					end, { desc = "[T]inymist [U]npin", noremap = true })
				end
			elseif server == "lua_ls" then
				opts.settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						completion = { callSnippet = "Replace" },
					},
				}
			elseif server == "emmet_ls" then
				opts.filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte",
				}
			elseif server == "clangd" then
				opts.filetypes = { "c", "cpp", "objc", "objcpp", "metal" }
			end
			lspconfig[server].setup(opts)
		end
	end,
}
