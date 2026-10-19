return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('bufferline').setup({
      options = {
        mode = "buffers",
        numbers = "ordinal",
        always_show_bufferline = true,
      }
    })

    vim.keymap.set('n', '[b', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
    vim.keymap.set('n', ']b', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })

    vim.keymap.set('n', '<leader>bb', '<Cmd>BufferLinePick<CR>', { desc = 'Bufferline interactive picker' })

    vim.keymap.set('n', '<leader>bd', '<Cmd>BufferLinePickClose<CR>', { desc = 'Interactive buffer closer' })
    vim.keymap.set('n', '<leader>bD', '<Cmd>BufferLineCloseOthers<CR>', { desc = 'Close all other buffers' })

    vim.keymap.set('n', '<b', '<Cmd>BufferLineMovePrev<CR>', { desc = 'Move active tab left' })
    vim.keymap.set('n', '>b', '<Cmd>BufferLineMoveNext<CR>', { desc = 'Move active tab right' })

    vim.keymap.set('n', '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', { desc = 'Toggle pin active buffer' })

    vim.keymap.set('n', '<leader>bs', '<Cmd>BufferLineSortByDirectory<CR>', { desc = 'Sort buffers by directory path' })

    for i = 1, 9 do
      vim.keymap.set(
        'n',
        '<leader>b' .. i,
        '<Cmd>BufferLineGoToBuffer ' .. i .. '<CR>',
        { desc = 'Go to buffer tab ' .. i }
      )
      vim.keymap.set(
        'n',
        '<leader>' .. i,
        '<Cmd>BufferLineGoToBuffer ' .. i .. '<CR>',
        { desc = 'Go to buffer tab ' .. i }
      )
    end
  end,
}
