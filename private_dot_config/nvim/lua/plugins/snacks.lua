return {
  "folke/snacks.nvim",
  opts = {
    notifier = {
      enabled = true,
    },

    picker = {
      hidden = true,
      ignored = true,
      sources = {
        files = {
          hidden = false,
          ignored = false,
          exclude = {
            "**/.git/*",
          },
        },
      },
    },
  },
}
