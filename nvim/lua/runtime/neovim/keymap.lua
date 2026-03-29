local map = vim.keymap.set

----------------------------------
-- リーダー
----------------------------------
vim.g.mapleader = ','

----------------------------------
-- 不要キーマップを消す
----------------------------------
map('n', '<leader>', '<nop>', { noremap = true })
map('n', 'K',        '<nop>', { noremap = true })
map('n', 'J',        '<nop>', { noremap = true })
map('n', 'x',        '"_x',   { noremap = true })
map('n', 's',        '"_s',   { noremap = true })

--------------------------------
-- 移動系
--------------------------------
map('n', 'j',     'gj',    { noremap = true })
map('n', 'k',     'gk',    { noremap = true })
map('v', 'j',     'gj',    { noremap = true })
map('v', 'k',     'gk',    { noremap = true })
map('n', '<C-k>', '<C-u>', { noremap = true })
map('n', '<C-j>', '<C-d>', { noremap = true })
map('v', '<C-k>', '<C-u>', { noremap = true })
map('v', '<C-j>', '<C-d>', { noremap = true })

----------------------------------
-- 挿入系
----------------------------------
-- vv で行末まで選択
map('v', 'v', '^$h', { noremap = true })

-- 選択範囲のインデントを連続して変更
map('v', '<', '<gv', { noremap = true })
map('v', '>', '>gv', { noremap = true })

--------------------------------
-- バッファ系
--------------------------------
map('n', '<C-h>', ':bprev<CR>',   { noremap = true, silent = true })
map('n', '<C-l>', ':bnext<CR>',   { noremap = true, silent = true })
map('n', '<C-d>', ':bdelete<CR>', { noremap = true, silent = true })

--------------------------------
-- ウィンドウ系
--------------------------------
map('n', '<C-n>', '<C-w>w', { noremap = true, silent = true })
map('n', '<C-p>', '<C-w>W', { noremap = true, silent = true })

--------------------------------
-- 検索系
--------------------------------
-- カーソル下の単語検索
map('n', '*',         [["/" . expand('<cword>') . "<CR>N"]], { noremap = true, silent = true, expr = true})
map('n', '<leader>,', [["/" . expand('<cword>') . "<CR>N"]], { noremap = true, silent = true, expr = true})

-- 検索結果のハイライトを削除
map('n', '<leader><space>', ':nohlsearch<CR>', { noremap = true, silent = true })

-- カーソル下の単語置換
map('n', '<leader>g', ':%s/<C-r><C-w>//g<Left><Left>', { noremap = true })

--------------------------------
-- LSP系
--------------------------------
map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', , { noremap = true, silent = true })
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', , { noremap = true, silent = true })
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', , { noremap = true, silent = true })

-- lsp
vim.api.nvim_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true }s)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
map('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true })
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
map('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
map('n', 'gh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', { noremap = true, silent = true })
