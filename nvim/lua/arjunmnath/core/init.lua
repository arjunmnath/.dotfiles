require("arjunmnath.core.colors")

local conda_prefix = os.getenv("CONDA_PREFIX")
vim.g.python3_host_prog = conda_prefix and (conda_prefix .. "/bin/python") or vim.fn.exepath("python3")

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.rs",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})
