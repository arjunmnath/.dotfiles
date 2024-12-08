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
require("lazy").setup("arjunmnath.plugins")
