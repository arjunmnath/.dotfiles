local opt = vim.opt 

vim.g.mapleader = " "

opt.nu = true
opt.relativenumber = true 
opt.number = true 


opt.tabstop = 4 
opt.shiftwidth = 4 
opt.expandtab = true
opt.autoindent = true
opt.softtabstop = 4
opt.smartindent = true

opt.wrap = false 

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true -- highlight the current cursor line


opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true 
opt.splitbelow = true
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true


opt.hlsearch = false
opt.incsearch = true

-- opt.scrolloff = 8
-- opt.signcolumn = "yes"
-- opt.isfname:append("@-@")
-- opt.updatetime = 50
-- opt.colorcolumn = "80"
-- vim.g.mapleader = " "





