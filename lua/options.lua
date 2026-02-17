-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- See `:help vim.o`
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse support (a = all modes)
vim.o.mouse = 'a'

-- Sync clipboard with system clipboard
-- vim.o.clipboard = 'unnamedplus'

--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`

-- If nvim running in a window under the same user under which tmux is running, then the TMUX environment variable is available and contains path to tmux socket, then it's enough simply enable it this way; neovim will automatically put the data into OS clipboard through tmux.
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

--[[ 
-- Doesn't work reliably. If mutiple tmaxes running, it tries to connect wrong socket, or something like that.

local function get_tmux_socket()

  if vim.env.TMUX then
    return vim.split(vim.env.TMUX, ',')[1]
  end

  local handle = io.popen("tmux display-message -p '#{socket_path}' 2>/dev/null")

  if handle then
    local result = handle:read("*a"):gsub("%s+", "")
    handle:close()
    if result ~= "" then
      return result
    end
  end

  return nil
end

local active_socket = get_tmux_socket()

if active_socket then
  vim.g.clipboard = {
    name = 'tmux',
    copy = {
      ['+'] = {'tmux', '-S', active_socket, 'load-buffer', '-w', '-'},
      ['*'] = {'tmux', '-S', active_socket, 'load-buffer', '-w', '-'},
    },
    paste = {
      ['+'] = {'tmux', '-S', active_socket, 'save-buffer', '-'},
      ['*'] = {'tmux', '-S', active_socket, 'save-buffer', '-'},
    },
    cache_enabled = true,
  }
end
]]

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

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
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
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
-- vim.o.confirm = true


vim.opt.tabstop = 4      -- A TAB character looks like 4 spaces
vim.opt.shiftwidth = 4   -- Number of spaces inserted when indenting
vim.opt.softtabstop = 4  -- Number of spaces inserted instead of a TAB
vim.opt.expandtab = true -- Pressing the TAB key inserts spaces
