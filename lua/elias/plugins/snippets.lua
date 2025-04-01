return {
	"SirVer/ultisnips",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local ls = require("luasnip")
		ls.add_snippets("java", {

			ls.parser.parse_snippet("lo", "log.info(${1})"),
		})
		ls.add_snippets("javascript", {

			ls.parser.parse_snippet("cc", "console.log(${1})"),
		})
		ls.add_snippets("python", {
			ls.parser.parse_snippet("lo", "_logger.info(${1})"),
		})
		ls.filetype_extend("typescriptreact", { "javascriptreact" })
		ls.filetype_extend("typescript", { "javascript" })
		ls.filetype_extend("javascript", { "html" })
		ls.filetype_extend("htmlangular", { "html" })
		ls.filetype_extend("xml", { "html" })
		ls.filetype_extend("typescriptreact", { "javascript" })
	end,
}
