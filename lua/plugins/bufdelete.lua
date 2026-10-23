return {
  'famiu/bufdelete.nvim',
  config = function()
    vim.keymap.set('n', '<leader>bx', '<Cmd>Bdelete<CR>', { desc = 'Delete buffer cleanly' })
    vim.keymap.set('n', '<leader>c', '<Cmd>Bdelete<CR>', { desc = 'Delete buffer cleanly' })
  end
}
