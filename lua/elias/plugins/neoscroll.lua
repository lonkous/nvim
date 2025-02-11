return {
    "karb94/neoscroll.nvim",
    config = function()
        neoscroll = require("neoscroll")
        local keymap = {
            ["<C-k>"] = function()
                neoscroll.scroll(-50, {
                    move_cursor = true,
                    duration = 150,
                    easing = "easeInOutQuint",
                })
            end,
            ["<C-j>"] = function()
                neoscroll.scroll(50, {
                    move_cursor = true,
                    duration = 150,
                    easing = "easeInOutQuint",
                })
            end,
        }
        local modes = { "n", "v", "x" }
        for key, func in pairs(keymap) do
            vim.keymap.set(modes, key, func)
        end
    end,
}
