require("config.lazy")

vim.g.mapleader = " "  -- sets leader to space

-- ============================================================================
-- Autocommands & plugin-dependent setup (use VeryLazy event)
-- ============================================================================
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- Filetype fix for .vue files
    vim.cmd [[
      autocmd BufRead,BufNewFile *.vue set filetype=vue
    ]]

    -- Colorscheme and transparency (plugin-dependent)
    vim.cmd.colorscheme("unokai")
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "#191a1c" })
    -- vim.api.nvim_set_hl(0, "NormalNC", { bg = "#191a1c" })
    -- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#191a1c" })
    vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#000000" })
    vim.api.nvim_set_hl(0, "NonText", { fg = "#444444" })
    vim.api.nvim_set_hl(0, "WhiteSpace", { fg = "#444444" })
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#444444" })

  end,
})

-- ============================================================================
-- Core settings and keymaps (safe to load early)
-- ============================================================================

vim.o.complete = ". ,w,b,u,t"
vim.o.completeopt = "menuone,noinsert,noselect"
-- vim.api.nvim_set_keymap('i', '<Tab>', '<C-n>', { noremap = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "silent! %s/\\s\\+$//e",
})

-- Hidden Symbols
vim.opt.listchars = {
  space = '·',
  tab = '→ ',
  trail = '•',
  extends = '⟩',
  precedes = '⟨',
  eol = '¬',
}
vim.opt.list = true

-- Basic UI Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.cmdheight = 1
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = true
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 3000

-- File handling
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0
vim.opt.autoread = true
vim.opt.autowrite = false

-- Behavior
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection = "exclusive"
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.modifiable = true
vim.opt.encoding = "UTF-8"

-- Cursor
vim.opt.guicursor =
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- ============================================================================
-- Key Mappings
-- ============================================================================

vim.keymap.set("i", "<End>", "<C-o>$")
vim.keymap.set("i", "<C-v>", '<C-r>+', { noremap = true, silent = true })

-- Use black hole register by default
vim.keymap.set("n", "d", '"_d', { noremap = true })
vim.keymap.set("n", "x", '"_x', { noremap = true })
vim.keymap.set("n", "X", '"_X', { noremap = true })
vim.keymap.set("v", "d", '"_d', { noremap = true })
vim.keymap.set("v", "x", '"_x', { noremap = true })

-- Leader-prefixed versions use default behavior
vim.keymap.set("n", "<leader>d", "d", { noremap = true })
vim.keymap.set("n", "<leader>x", "x", { noremap = true })
vim.keymap.set("n", "<leader>X", "X", { noremap = true })
vim.keymap.set("v", "<leader>d", "d", { noremap = true })
vim.keymap.set("v", "<leader>x", "x", { noremap = true })

-- Search highlight clear
vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>")

-- Center search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")
vim.keymap.set("n", "<C-PageUp>", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-PageDown>", ":bnext<CR>", { noremap = true, silent = true })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Splitting & Resizing
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>")
vim.keymap.set("n", "<leader>sh", ":split<CR>")
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Move lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Indent in visual
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- File explorer / finder
vim.keymap.set("n", "<leader>e", ":Explore<CR>")
vim.keymap.set("n", "<leader>ff", ":find ")

-- Join lines smartly
vim.keymap.set("n", "J", "mzJ`z")

-- Config shortcut
vim.keymap.set("n", "<leader>rc", ":e ~/.config/nvim/init.lua<CR>")

-- Copy full file path
vim.keymap.set("n", "<leader>pa", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("file:", path)
end)

-- Highlight on yank
local augroup = vim.api.nvim_create_augroup("UserConfig", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})


vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.tex",
  command = "set filetype=tex",
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "tex",
--   command = "setlocal makeprg=pdflatex -interaction nonstopmode -synctex=-1 -cnf-line=half_error_line=238 -cnf-line=error_line=254 -cnf-line=max_print_line=1000000'\\ %",
-- })
--
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "tex",
--   command = "setlocal errorformat=%f:%l:%c:\\ %m",
-- })
