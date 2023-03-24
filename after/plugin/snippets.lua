local ls = require("luasnip")
ls.add_snippets("javascript", {
  
  ls.parser.parse_snippet(
    "ccc",
    "console.log(${1:variable})"
  ),
})

ls.add_snippets("typescriptreact", {
   ls.parser.parse_snippet(
  "tfcd",
      "import React from 'react';\n type ${TM_FILENAME_BASE}Props = {\n\t${1}\n};\n const ${TM_FILENAME_BASE}:React.FC<${TM_FILENAME_BASE}Props> = (${2}) => {\n\t\treturn <div>${3:Have a good coding}</div>\n}\nexport default $TM_FILENAME_BASE;}"
  )
})

ls.filetype_extend("typescriptreact", { "javascriptreact" })
ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("javascript", { "html" })
ls.filetype_extend("typescriptreact", { "javascript" })
