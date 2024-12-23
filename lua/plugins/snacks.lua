return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            dashboard = {
                preset = {
                    keys = {
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    },
                },
                sections = {
                    {
                        section = "keys",
                        gap = 1,
                        padding = 1
                    },
                },
            },
            notifier = {
                enabled = false,
            },
        },
    },
}
