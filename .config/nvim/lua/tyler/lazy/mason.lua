return {
  'mason-org/mason.nvim',
  dependencies = {
    { 'j-hui/fidget.nvim', opts = {} },
    { 'WhoIsSethDaniel/mason-tool-installer' },
  },
  config = function()
    local ensure_installed = {
      -- golang
      'gopls',

      -- lua
      'lua-language-server',
      'stylua',

      -- web dev
      'css-lsp',
      'html-lsp',
      'typescript-language-server',
      'prettier',

      -- Markdown
      'markdownlint',
      'marksman',
    }

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason').setup {
      ui = {
        border = 'rounded',
      },
    }
  end,
}
