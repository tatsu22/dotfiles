return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  config = function()
    require('conform').setup {
      formatters = {
        golines = {
          command = 'golines',
          args = { '-m', '120' },
          stdin = true,
        },
        prettier = {
          command = 'prettier',
          args = { '--stdin-filepath', '$FILENAME', '--print-width', '120', '--prose-wrap', 'always' },
          stdin = true,
        },
      },
      notify_on_error = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'gopls', 'gofumpt', 'golines', 'goimports-reviser' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 1000,
            lsp_format = 'fallback',
          }
        end
      end,
    }
  end,
}
