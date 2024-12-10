local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "arjunmnath.plugins" }, { import = "arjunmnath.plugins.lsp" } }, {
	change_detection = {
		notify = false,
	},
	checker = {
		enable = true,
		notify = false,
	},
})
