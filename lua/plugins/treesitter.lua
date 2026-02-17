return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master', -- older version, nvim 0.10 compartible
  build = ':TSUpdate',
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
      auto_install = true,
      highlight = { enable = true },
    })
  end,
}
