require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = { "c", "javascript","typescript",'html',"rust","lua", "vim", "query"},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	autopairs = { enable = true },
  autotag = { enable = true },
}
require("telescope").load_extension("file_browser")
require 'nvim-treesitter.install'.compilers = { "clang" }
