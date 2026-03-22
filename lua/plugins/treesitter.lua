return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master', -- older version, nvim 0.10 compartible
  build = ':TSUpdate', -- runs after update the plugin (via :Lazy update), updates installed parsers
  config = function()
    local configs = require('nvim-treesitter.configs')
    configs.setup({
      ensure_installed = {
        'c',
        'lua',
        'vim',
        'vimdoc',
        'query',
        'python',
        'javascript',
        'typescript',
        'html',
        'css',
        'vue',
      },
      sync_install = false,
      auto_install = true, -- when open a file of a new language, installs a parser don't have yet
      highlight = { enable = true },
    })
  end,
}
