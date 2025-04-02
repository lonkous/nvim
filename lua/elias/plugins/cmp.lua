return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "*",
		},
	},
	version = "*",
	opts = {

		keymap = { preset = "enter" },
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		completion = { documentation = { auto_show = true } },
		snippets = { preset = "luasnip" },
		sources = {
			default = { "snippets", "lsp", "path", "buffer" },
		},
		fuzzy = { implementation = "lua" },
	},
	opts_extend = { "sources.default" },
}
