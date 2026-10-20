
return { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    -- By default, Telescope is included and acts as your picker for everything.

    -- If you would like to switch to a different picker (like snacks, or fzf-lua)
    -- you can disable the Telescope plugin by setting enabled to false and enable
    -- your replacement picker by requiring it explicitly (e.g. 'custom.plugins.snacks')

    -- Note: If you customize your config for yourself,
    -- it’s best to remove the Telescope plugin config entirely
    -- instead of just disabling it here, to keep your config clean.
    enabled = true,
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function() return vim.fn.executable 'make' == 1 end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
           mappings = {
             i = {
               ["<C-j>"] = "move_selection_next",
               ["<C-k>"] = "move_selection_previous",
             },
           },
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown() },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'

      -- Core Locators & Pickers
      vim.keymap.set('n', '<leader>f<CR>', builtin.resume, { desc = '[F]ind [R]esume search' })
      vim.keymap.set('n', "<leader>f'", builtin.marks, { desc = "[F]ind [']arks" })
      vim.keymap.set('n', '<leader>f"', builtin.registers, { desc = '[F]ind ["]egisters' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind Open [B]uffers' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fF', function()builtin.find_files({ hidden = true, no_ignore = true }) end, { desc = '[F]ind [F]iles (All/Hidden)' })
      vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[F]ind [G]it Tracked Files' })

      -- Recent Files ("Old Files")
      vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = '[F]ind [O]ld Files' })
      vim.keymap.set('n', '<leader>fO', function() builtin.oldfiles({ only_cwd = true }) end, { desc = '[F]ind [O]ld Files (Current Dir)' })

      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

      -- Text & Line Grepping
      vim.keymap.set('n', '<leader>fc', builtin.grep_string, { desc = '[F]ind Word at [C]ursor' })
      vim.keymap.set('n', '<leader>fl', builtin.current_buffer_fuzzy_find, { desc = '[F]ind [L]ines in Current Buffer' })
      vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = '[F]ind Live [W]ord (Grep)' })
      vim.keymap.set('n', '<leader>fW', function()
        builtin.live_grep({ additional_args = function() return { "--hidden", "--no-ignore" } end })
      vim.keymap.set( 'n', '<leader>f/',
        function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end,
        { desc = '[S]earch [/] in Open Files' }
      )     end, { desc = '[F]ind Live [W]ord (Grep All/Hidden)' })

      -- Vim Environment & Metadata Pickers
      vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]mart' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>fC', builtin.commands, { desc = '[F]ind [C]ommands' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
      vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = '[F]ind [M]an Pages' })
      vim.keymap.set('n', '<leader>ft', builtin.colorscheme, { desc = '[F]ind [T]hemes / Colorschemes' })
      vim.keymap.set('n', '<leader>fa', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[F]ind [A]stronvim files (legacy)' })

      -- Third-Party Extension Intercepts (Fallback to extensions api via telescope)
      vim.keymap.set('n', '<leader>fn', function() require('telescope').extensions.notify.notify() end, { desc = '[F]ind [N]otifications' })
      vim.keymap.set('n', '<leader>fp', function() require('telescope').extensions.projects.projects() end, { desc = '[F]ind [P]rojects' })
      vim.keymap.set('n', '<leader>fs', function() require('telescope').extensions.smart_open.smart_open() end, { desc = '[F]ind [S]mart Open' })
      vim.keymap.set('n', '<leader>fu', function() require('telescope').extensions.undo.undo() end, { desc = '[F]ind [U]ndo History' })

      --  The <leader>g (GIT) GROUP
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = '[G]it [B]ranches' })
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = '[G]it [C]ommits (Repo)' })
      vim.keymap.set('n', '<leader>gC', builtin.git_bcommits, { desc = '[G]it [C]ommits (Current File)' })
      vim.keymap.set('n', '<leader>gt', builtin.git_status, { desc = '[G]it [T]racked Status' })
      vim.keymap.set('n', '<leader>gT', builtin.git_stash, { desc = '[G]it S[T]ash' })

      -- Git Browse (Typically relies on external gitsigns config rather than builtin telescope modules)
      vim.keymap.set('n', '<leader>go', '<Cmd>Gitsigns toggle_current_line_blame<CR>', { desc = '[G]it Br[O]wse / Blame' })


      -- it is better explained there). This allows easily switching between pickers if you prefer using something else!
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
        callback = function(event)
          local buf = event.buf

          -- Find references for the word under your cursor.
          vim.keymap.set('n', 'grr', function() require('telescope.builtin').lsp_references() end, { buffer = buf, desc = 'LSP: Go to references' })
          vim.keymap.set('n', '<leader>lR', function() require('telescope.builtin').lsp_references() end, { buffer = buf, desc = 'LSP: Go to references' })
          -- Fuzzy find all the symbols in your current document.
          vim.keymap.set('n', 'gO', function() require('telescope.builtin').lsp_document_symbols() end, { buffer = buf, desc = 'LSP: Document symbols (List)' })
          vim.keymap.set('n', '<leader>ls', function() require('telescope.builtin').lsp_document_symbols() end, { buffer = buf, desc = 'LSP: Document symbols' })
          -- Fuzzy find all the symbols in your current workspace.
          vim.keymap.set('n', '<leader>lG', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, { buffer = buf, desc = 'LSP: Workspace symbols' })
          vim.keymap.set('n', '<leader>lD', function() require('telescope.builtin').lsp_workspace_diagnostics() end, { buffer = buf, desc = 'LSP: All workspace diagnostics' })



        end,
      })


    end,
  }

