--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')


-- Toggle line wrapping on the fly
vim.keymap.set('n', '<leader>w', function()
  vim.opt.wrap = not vim.opt.wrap:get()
  -- Optional: Prints a quick status message at the bottom of the screen
  print("Line wrap: " .. (vim.opt.wrap:get() and "ON" or "OFF"))
end, { desc = 'Toggle line [W]rap' })

-- Diagnostic Config & Keymaps ==================
-- See :help vim.diagnostic.Opts

vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Teest shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = { float = true },
}

vim.keymap.set('n', '<leader>xq', vim.diagnostic.setqflist, { desc = 'Open diagnostic quickfix list' })
-- vim.keymap.set('n', ']q', ':cnext<CR>zz', { desc = "Next quickfix item" })
-- vim.keymap.set('n', '[q', ':cprev<CR>zz', { desc = "Previous quickfix item" })
vim.keymap.set('n', ']q', function() vim.diagnostic.goto_next({ float = true }) end, { desc = 'Next diagnostic' })
vim.keymap.set('n', '[q', function() vim.diagnostic.goto_prev({ float = true }) end, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']Q', ':clast<CR>zz', { desc = "Last quickfix item" })
vim.keymap.set('n', '[Q', ':cfirst<CR>zz', { desc = "First quickfix item" })

vim.keymap.set('n', '<leader>xl', vim.diagnostic.setloclist, { desc = 'Open diagnostic location list' })
vim.keymap.set('n', ']l', function() vim.diagnostic.goto_next({ float = true }) end, { desc = 'Next diagnostic' })
vim.keymap.set('n', '[l', function() vim.diagnostic.goto_prev({ float = true }) end, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']L', function() vim.diagnostic.jump({ count = #vim.diagnostic.get(0), float = true }) end, { desc = 'Last diagnostic' })
vim.keymap.set('n', '[L', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = 'First diagnostic' })

vim.keymap.set('n', ']e', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { desc = 'Go to next diagnostic [E]rror' })
vim.keymap.set('n', '[e', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { desc = 'Go to previous diagnostic [E]rror' })
vim.keymap.set('n', ']w', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end, { desc = 'Go to next diagnostic [W]arning' })
vim.keymap.set('n', '[w', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end, { desc = 'Go to previous diagnostic [W]arning' })


-- Terminal ============================

vim.keymap.set('n', '<leader>th', '<Cmd>split | term | resize 15<CR>', { desc = 'Terminal: Horizontal split' })
vim.keymap.set('n', '<leader>tv', '<Cmd>vsplit | term<CR>', { desc = 'Terminal: Vertical split' })
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Windows ==========================

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })


-- Tabs ==============================

vim.keymap.set('n', ']t', '<Cmd>tabnext<CR>', { desc = 'Next Vim tab page' })
vim.keymap.set('n', '[t', '<Cmd>tabprevious<CR>', { desc = 'Previous Vim tab page' })

