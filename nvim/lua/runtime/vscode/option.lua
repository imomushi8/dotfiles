--------------------------------
-- 基本設定 
--------------------------------
vim.opt.mouse = ""
vim.opt.hidden = true
vim.opt.showcmd = true
vim.opt.autoread = true
vim.opt.shortmess:remove("F")
vim.opt.shortmess:append("c")
vim.opt.visualbell = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = false
vim.opt.modifiable = true
vim.opt.compatible = false
-- vim.opt.autochdir = true
vim.opt.clipboard:append{'unnamedplus'}

--------------------------------
-- エディタ設定
--------------------------------
vim.opt.showmatch = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.virtualedit = "onemore"

vim.opt.wrapscan = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

--------------------------------
-- 表示設定
--------------------------------
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.laststatus = 2
vim.opt.showtabline = 2
vim.opt.list = true
vim.opt.listchars:append({ tab = "^\\ " })
vim.opt.termguicolors = true

vim.cmd("hi Constant ctermfg=14")
vim.cmd("hi clear CursorLine")

--------------------------------
-- LSP設定
--------------------------------
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }

--------------------------------
-- コマンドライン設定
--------------------------------
vim.opt.wildmode = { "list", "longest" }
vim.opt.wildoptions = "pum"
