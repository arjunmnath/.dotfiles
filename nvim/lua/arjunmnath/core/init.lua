require("arjunmnath.core.colors")

local conda_prefix = os.getenv("CONDA_PREFIX")
vim.g.python3_host_prog = conda_prefix and (conda_prefix .. "/bin/python") or vim.fn.exepath("python3")


