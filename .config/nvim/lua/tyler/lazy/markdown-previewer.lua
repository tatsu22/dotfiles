-- Markdown Previewer
return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = function()
    vim.fn['mkdp#util#install']()
  end,
  config = function()
    vim.keymap.set('n', '<leader>mm', '<cmd>MarkdownPreviewToggle<CR>', { desc = 'Preview [M]arkdown file' })
  end,
}
