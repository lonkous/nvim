-- default components
local timeline        = require('ide.components.timeline')
local changes         = require('ide.components.changes')
local commits         = require('ide.components.commits')
local branches        = require('ide.components.branches')

require('ide').setup({
    -- values: "nerd", "codicon", "default"
    icon_set = "nerd",
    log_level = "info",
        -- default panel groups to display on left and right.
    panels = {
        right = "git"
    },
    -- panels defined by groups of components, user is free to redefine the defaults
    -- and/or add additional.
    panel_groups = {
        git = { changes.Name, commits.Name, timeline.Name, branches.Name }
    },
    workspaces = {
        -- which panels to open by default, one of: 'left', 'right', 'both', 'none'
        auto_open = 'none',
    },
    panel_sizes = {
        left = 0,
        right = 40,
    }
})

vim.keymap.set("n","<leader>g","<CMD>Workspace RightPanelToggle<CR>")
