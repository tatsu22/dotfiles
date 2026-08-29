return { -- zk for note taking
  'zk-org/zk-nvim',
  config = function()
    local zk = require 'zk'
    zk.setup {
      picker = 'telescope',
      lsp = {
        config = {
          name = 'zk',
          cmd = { 'zk', 'lsp' },
          filetypes = { 'markdown' },
        },

        auto_attach = {
          enabled = true,
        },
      },
    }

    require('zk.commands').add('ZkDaily', function()
      zk.new {
        title = os.date '%Y-%m-%d',
        dir = 'journal/daily',
        open = true,
      }
    end, { desc = 'Create a new daily note' })

    vim.keymap.set('n', '<leader>nn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", { desc = '[N]ote [N]ew' })
    vim.keymap.set('n', '<leader>nf', '<Cmd>ZkNotes<CR>', { desc = '[N]ote [F]ind' })
    vim.keymap.set('n', '<leader>nt', '<Cmd>ZkTags<CR>', { desc = '[N]ote [T]ags' })
  end,
}
