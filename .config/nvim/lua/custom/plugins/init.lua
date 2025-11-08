-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

  {
    'nvim-tree/nvim-web-devicons',
    opts = {
      lazy = false,
    },
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local clients_lsp = function()
        local bufnr = vim.api.nvim_get_current_buf()

        local clients = vim.lsp.get_active_clients { bufnr = bufnr }
        if next(clients) == nil then
          return ''
        end

        local c = {}
        for _, client in pairs(clients) do
          table.insert(c, client.name)
        end
        return '\u{f085} ' .. table.concat(c, '|')
      end
      require('lualine').setup {
        options = {
          theme = 'tokyonight',
        },
        sections = {
          lualine_x = { clients_lsp, 'filetype' },
        },
        extensions = {
          'nvim-tree',
        },
      }
    end,
  },

  -- Flash
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },

  -- Smart commenting
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()

      vim.keymap.set('n', '<C-c>', function()
        require('Comment.api').toggle.linewise.current()
      end, { desc = 'comment current line', noremap = true })
      vim.keymap.set(
        'v',
        '<C-c>',
        "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
        { desc = 'comment visual block', noremap = true }
      )
    end,
  },

  -- File Tree
  {
    'nvim-tree/nvim-tree.lua',
    opts = {
      git = {
        enable = true,
        timeout = 2000,
      },
      view = {
        width = 40,
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = {
          '^.git$',
          '.*.uid$',
        },
      },
    },
    lazy = false,
  },

  -- LazyGit, tui for git
  {
    'kdheepak/lazygit.nvim',
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    lazy = false,
    config = function()
      vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'Open LazyGit TUI' })
    end,
  },

  -- cmdline in popup window
  {
    'VonHeikemen/fine-cmdline.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    lazy = false,
    config = function()
      require('fine-cmdline').setup {
        cmdline = {
          enable_keymaps = true,
          smart_history = true,
          prompt = ': ',
        },
        popup = {
          position = {
            row = '25%',
            col = '50%',
          },
          size = {
            width = '60%',
          },
          border = {
            style = 'rounded',
          },
          win_options = {
            winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
          },
        },
        -- hooks = {
        --   before_mount = function(input)
        --     -- code
        --   end,
        --   after_mount = function(input)
        --     -- code
        --   end,
        --   set_keymaps = function(imap, feedkeys)
        --     -- code
        --   end
        -- }
      }
      vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', { noremap = true })
    end,
  },

  -- Obsidian
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- TODO: Add workspaces
  },

  -- Markdown Previewer
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    config = function()
      vim.keymap.set('n', '<leader>mm', '<cmd>MarkdownPreviewToggle<CR>', { desc = 'Preview [M]arkdown file' })
    end,
  },

  -- Format on save
  {
    'stevearc/conform.nvim',
    lazy = false,
    opts = {},
    config = function()
      require('conform').setup {
        formatters_by_ft = {
          lua = { 'stylua' },
          go = { 'gopls', 'gofumpt', 'goimports-reviser', 'golines' },
          markdown = { 'markdownlint', 'marksman' },
          json = { 'jq' },
        },
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 1000, lsp_format = 'fallback' }
        end,
      }

      vim.api.nvim_create_user_command('FormatToggle', function()
        if vim.g.disable_autoformat == true then
          vim.g.disable_autoformat = false
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = 'Toggle formatting in this buffer',
      })
    end,
  },
  -- Status Bar
  {
    'romgrk/barbar.nvim',
    event = 'VimEnter',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
      vim.keymap.set('n', '<leader>x', '<cmd>BufferClose<CR>', { desc = 'Close[x] the current buffer' })
      vim.keymap.set('n', '<leader>X', '<cmd>BufferCloseAllButCurrent<CR>', { desc = 'Close[X] other buffers' })
      vim.keymap.set('n', '<Tab>', '<cmd>BufferNext<CR>', { desc = 'Next buffer' })
      vim.keymap.set('n', '<S-Tab>', '<cmd>BufferPrevious<CR>', { desc = 'Prev buffer' })
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    -- config = function()
    --   vim.keymap.set('n', '<leader>x', '<cmd>BufferClose<CR>', { desc = 'Close[x] the current buffer' })
    --   vim.keymap.set('n', '<leader>x', '<cmd>BufferCloseAllButCurrent<CR>', { desc = 'Close[X] other buffers' })
    --   vim.keymap.set('n', '<Tab>', '<cmd>BufferNext<CR>', { desc = 'Next buffer' })
    --   vim.keymap.set('n', '<S-Tab>', '<cmd>BufferPrevious<CR>', { desc = 'Prev buffer' })
    -- end,
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },

  -- Code Screenshots
  {
    'mistricky/codesnap.nvim',
    build = 'make',
    config = function()
      require('codesnap').setup {
        has_breadcrumbs = true,
        bg_theme = 'grape',
        watermark = '',
      }
    end,
  },

  -- {
  --   'bakudankun/pico-8.vim',
  -- },

  -- Emojis(very important for Zoomers)
  {
    'xiyaowong/telescope-emoji.nvim',
    config = function()
      require('telescope').load_extension 'emoji'
      vim.keymap.set('n', '<leader>se', '<cmd>Telescope emoji<CR>', { desc = '[S]earch for [E]mojis' })
    end,
  },
}
