  return {
    'neanias/everforest-nvim',
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
  -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("everforest").setup({
          -- Controls the "hardness" of the background. Options are "soft", "medium"(default) or "hard"
        background = "medium",
        -- How much of the background should be transparent. Options are 0 (default), 1 or 2
        transparent_background_level = 0,
        vim.cmd.colorscheme 'everforest'
      })
    end,
  }
