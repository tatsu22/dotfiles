--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- wrap = bad
vim.o.wrap = false

-- better "/" searching
vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.termguicolors = true

-- keep those lines short
vim.o.colorcolumn = '120'

vim.keymap.set('i', '<M-BS>', '<C-w>', { desc = 'Option backspace while typing' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Keep centered when jumping down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Keep centered when jumping up' })
vim.keymap.set('n', '<Enter>', 'o<Esc>', { desc = 'insert line below' })
vim.keymap.set('n', '<S-Enter>', 'O<Esc>', { desc = 'insert line above' })
vim.keymap.set('n', '<leader>x', '<cmd>BufferClose<CR>', { desc = 'Close[x] the current buffer' })
vim.keymap.set('n', '<leader>X', '<cmd>BufferClose!<CR>', { desc = 'Super Close[X] the current buffer' })

-- vim.cmd 'NvimTreeToggle'
vim.keymap.set('n', 's', '<nop>', { desc = 'unmap "s" for easier surround usage' })

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic Message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic Message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>x', '<cmd>bdelete<CR>', { desc = 'Close[x] the current buffer' })
vim.keymap.set('n', '<leader>X', '<cmd>bdelete!<CR>', { desc = 'Really close[X] the current buffer' })
vim.keymap.set('n', '<leader>e', '<cmd>e .<CR>', { desc = 'Show diagnostic [e]rror messages' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.lsp.enable {
  'lua_ls',
  'gopls',
  'ts_ls',
}

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

-- restore cursor position when reopening file
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    local saved_cursor = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_win_set_cursor(0, saved_cursor)
  end,
})

require('vim._core.ui2').enable {}

require 'tyler'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
