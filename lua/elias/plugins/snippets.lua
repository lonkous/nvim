return {
	"SirVer/ultisnips",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node

		-- ── existing ────────────────────────────────────────────────────────
		ls.add_snippets("java", {
			ls.parser.parse_snippet("lo", "log.info(${1})"),
		})
		ls.add_snippets("javascript", {
			ls.parser.parse_snippet("cc", "console.log(${1})"),
		})
		ls.add_snippets("python", {
			ls.parser.parse_snippet("lo", "_logger.info(${1})"),
		})

		-- ── Odoo XML ─────────────────────────────────────────────────────────
		ls.add_snippets("xml", {

			-- <odoo> root wrapper
			ls.parser.parse_snippet("odoo", "<odoo>\n    ${1}\n</odoo>"),

			-- <data> block (noupdate)
			ls.parser.parse_snippet("data", '<data>\n    ${2}\n</data>'),

			-- ── Views ─────────────────────────────────────────────────────

			-- Form view
			ls.parser.parse_snippet(
				"form",
				[[
				<record id="${1:model_name}_form_view" model="ir.ui.view">
				<field name="name">${1}.form</field>
				<field name="model">${1}</field>
				<field name="arch" type="xml">
				<form string="${2:Title}">
				<sheet>
				<group>
				<field name="${3:name}"/>
				</group>
				</sheet>
				</form>
				</field>
				</record>]]
			),

			-- Tree / list view
			ls.parser.parse_snippet(
				"tree",
				[[
				<record id="${1:model_name}_tree_view" model="ir.ui.view">
				<field name="name">${1}.tree</field>
				<field name="model">${1}</field>
				<field name="arch" type="xml">
				<tree string="${2:Title}">
				<field name="${3:name}"/>
				</tree>
				</field>
				</record>]]
			),

			-- Kanban view
			ls.parser.parse_snippet(
				"kanban",
				[[
				<record id="${1:model_name}_kanban_view" model="ir.ui.view">
				<field name="name">${1}.kanban</field>
				<field name="model">${1}</field>
				<field name="arch" type="xml">
				<kanban>
				<field name="${2:name}"/>
				<templates>
				<t t-name="kanban-box">
				<div class="oe_kanban_card">
				<field name="${2:name}"/>
				</div>
				</t>
				</templates>
				</kanban>
				</field>
				</record>]]
			),

			-- Search view
			ls.parser.parse_snippet(
				"search",
				[[
				<record id="${1:model_name}_search_view" model="ir.ui.view">
				<field name="name">${1}.search</field>
				<field name="model">${1}</field>
				<field name="arch" type="xml">
				<search string="${2:Search}">
				<field name="${3:name}"/>
				<filter name="${4:filter_name}" string="${5:Label}" domain="${6:[]}"/>
				<group expand="0" string="Group By">
				<filter name="group_by_${7:field}" string="${8:Field}" context="{'group_by': '${7:field}'}"/>
				</group>
				</search>
				</field>
				</record>]]
			),

			-- Pivot view
			ls.parser.parse_snippet(
				"pivot",
				[[
				<record id="${1:model_name}_pivot_view" model="ir.ui.view">
				<field name="name">${1}.pivot</field>
				<field name="model">${1}</field>
				<field name="arch" type="xml">
				<pivot string="${2:Title}">
				<field name="${3:field}" type="${4:row}"/>
				</pivot>
				</field>
				</record>]]
			),

			-- Graph view
			ls.parser.parse_snippet(
				"graph",
				[[
				<record id="${1:model_name}_graph_view" model="ir.ui.view">
				<field name="name">${1}.graph</field>
				<field name="model">${1}</field>
				<field name="arch" type="xml">
				<graph string="${2:Title}" type="${3:bar}">
				<field name="${4:field}" type="${5:row}"/>
				</graph>
				</field>
				</record>]]
			),

			-- xpath snippet on its own
			ls.parser.parse_snippet(
				"xpath",
				'<xpath expr="${1://field[@name=\'${2:field_name}\']}" position="${3:after}">\n    ${4}\n</xpath>'
			),

			-- ── Actions ───────────────────────────────────────────────────

			-- Window action
			ls.parser.parse_snippet(
				"action",
				[[
				<record id="${1:model_name}_action" model="ir.actions.act_window">
				<field name="name">${2:Action Name}</field>
				<field name="res_model">${1}</field>
				<field name="view_mode">${3:tree,form}</field>
				<field name="domain">${4:[]}</field>
				<field name="context">${5:{}}</field>
				</record>]]
			),

			-- Server action
			ls.parser.parse_snippet(
				"actionserver",
				[[
				<record id="${1:action_id}" model="ir.actions.server">
				<field name="name">${2:Server Action}</field>
				<field name="model_id" ref="${3:model_ref}"/>
				<field name="binding_model_id" ref="${3}"/>
				<field name="state">code</field>
				<field name="code">
				${4:action = records.action_name()}
				</field>
				</record>]]
			),

			-- ── Menus ─────────────────────────────────────────────────────

			-- Top-level menu
			ls.parser.parse_snippet(
				"menu",
				[[
				<menuitem id="${1:menu_id}"
				name="${2:Menu Name}"
				action="${3:action_id}"
				sequence="${4:10}"/>]]
			),

			-- Menu with parent
			ls.parser.parse_snippet(
				"menuchild",
				[[
				<menuitem id="${1:menu_id}"
				name="${2:Menu Name}"
				parent="${3:parent_menu_id}"
				action="${4:action_id}"
				sequence="${5:10}"/>]]
			),

			-- ── Security ─────────────────────────────────────────────────

			-- ir.model.access record
			ls.parser.parse_snippet(
				"access",
				[[
				<record id="access_${1:model_name}_${2:group}" model="ir.model.access">
				<field name="name">${1}.${2}</field>
				<field name="model_id" ref="model_${3:model_name_underscored}"/>
				<field name="group_id" ref="${4:base.group_user}"/>
				<field name="perm_read"  eval="${5:1}"/>
				<field name="perm_write" eval="${6:1}"/>
				<field name="perm_create" eval="${7:1}"/>
				<field name="perm_unlink" eval="${8:0}"/>
				</record>]]
			),

			-- Record rule
			ls.parser.parse_snippet(
				"rule",
				[[
				<record id="${1:rule_id}" model="ir.rule">
				<field name="name">${2:Rule Name}</field>
				<field name="model_id" ref="model_${3:model_name}"/>
				<field name="domain_force">${4:[('user_id','=',user.id)]}</field>
				<field name="groups" eval="[(4, ref('${5:base.group_user}'))]"/>
				<field name="perm_read"  eval="${6:1}"/>
				<field name="perm_write" eval="${7:1}"/>
				<field name="perm_create" eval="${8:1}"/>
				<field name="perm_unlink" eval="${9:1}"/>
				</record>]]
			),

			-- ── Form UI helpers ───────────────────────────────────────────

			-- <notebook> with one page
			ls.parser.parse_snippet(
				"notebook",
				[[
				<notebook>
				<page string="${1:Page}" name="${2:page}">
				${3}
				</page>
				</notebook>]]
			),

			-- <page> tab
			ls.parser.parse_snippet("page", '<page string="${1:Tab}" name="${2:tab}">\n    ${3}\n</page>'),

			-- <group> with optional string
			ls.parser.parse_snippet("group", '<group string="${1:}" col="${2:2}">\n    ${3}\n</group>'),

			-- <field> tag
			ls.parser.parse_snippet("field", '<field name="${1:field_name}" ${2:widget="${3:}"}/>'),

			-- <button> (object method)
			ls.parser.parse_snippet(
				"button",
				'<button name="${1:method_name}" type="object" string="${2:Label}" class="${3:btn-primary}"/>'
			),

			-- status bar (state field)
			ls.parser.parse_snippet(
				"statusbar",
				[[
				<header>
				<field name="${1:state}" widget="statusbar" statusbar_visible="${2:draft,done}"/>
				<button name="${3:action_confirm}" type="object" string="${4:Confirm}"
				class="btn-primary" attrs="{'invisible': [('${1}','!=','${5:draft}')]}"/>
				</header>]]
			),

			-- smart buttons bar
			ls.parser.parse_snippet(
				"statbutton",
				[[
				<div class="oe_button_box" name="button_box">
				<button class="oe_stat_button" type="object"
				name="${1:action_method}" icon="${2:fa-list}">
				<field name="${3:count_field}" widget="statinfo" string="${4:Label}"/>
				</button>
				</div>]]
			),

			-- ── Data / demo records ───────────────────────────────────────

			-- Generic <record>
			ls.parser.parse_snippet(
				"record",
				[[
				<record id="${1:record_id}" model="${2:model.name}">
				<field name="${3:name}">${4:value}</field>
				</record>]]
			),

			-- <function> call
			ls.parser.parse_snippet(
				"func",
				[[
				<function model="${1:model.name}" name="${2:method_name}">
				<value eval="${3:args}"/>
				</function>]]
			),
		}) -- end add_snippets("xml")

		-- ── filetype extensions ──────────────────────────────────────────────
		ls.filetype_extend("typescriptreact", { "javascriptreact" })
		ls.filetype_extend("typescript", { "javascript" })
		ls.filetype_extend("javascript", { "html" })
		ls.filetype_extend("htmlangular", { "html" })
		ls.filetype_extend("xml", { "html" })
		ls.filetype_extend("typescriptreact", { "javascript" })
	end,
}
