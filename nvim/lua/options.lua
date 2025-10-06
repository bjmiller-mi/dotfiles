-- Basic Settings
vim.opt.number = true          -- Show absolute line numbers
vim.opt.relativenumber = false -- Disable relative line numbers
vim.opt.linebreak = true
vim.opt.showbreak = "+++"
vim.opt.textwidth = 80
vim.opt.showmatch = true
vim.opt.visualbell = true

-- Search settings
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- Indentation
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4

-- Other settings
vim.opt.ruler = true
vim.opt.undolevels = 1000
vim.opt.backspace = "indent,eol,start"
vim.opt.re = 0

-- Always show sign column to prevent layout shifts
vim.opt.signcolumn = "yes"

-- Enable syntax highlighting
vim.cmd("syntax on")

-- Fix cursor color bug - set explicit cursor colors
vim.cmd([[
  autocmd ColorScheme * highlight Cursor guifg=NONE guibg=#ff6b6b
  autocmd ColorScheme * highlight iCursor guifg=NONE guibg=#ff6b6b
  autocmd ColorScheme * highlight lCursor guifg=NONE guibg=#ff6b6b
  autocmd ColorScheme * highlight nCursor guifg=NONE guibg=#ff6b6b
  autocmd ColorScheme * highlight vCursor guifg=NONE guibg=#ff6b6b
  autocmd ColorScheme * highlight cCursor guifg=NONE guibg=#ff6b6b
]])

-- Also set guicursor to ensure cursor shape and color
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- File type specific settings
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.yaml", "*.yml"},
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.json", "*.js", "*.ts"},
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})