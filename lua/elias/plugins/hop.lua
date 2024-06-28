return {
    'smoka7/hop.nvim',
    version = '*', -- optional but strongly recommended
    config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require 'hop'.setup { vim.keymap.set("n", "hc", ":HopChar1<CR>"),
            vim.keymap.set("n", "hw", ":HopWord<CR>"),
            vim.keymap.set("n", "hp", ":HopPattern<CR>"),
            vim.keymap.set("n", "hl", ":HopLine<CR>"),
        }
        local hop = require('hop')
        local directions = require('hop.hint').HintDirection
        vim.keymap.set('', 'f', function()
            hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
        end, { remap = true })
        vim.keymap.set('', 'F', function()
            hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
        end, { remap = true })
        vim.keymap.set('', 't', function()
            hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
        end, { remap = true })
        vim.keymap.set('', 'T', function()
            hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
        end, { remap = true })
    end
}
