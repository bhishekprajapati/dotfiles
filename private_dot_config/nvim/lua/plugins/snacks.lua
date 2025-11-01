return {
  "folke/snacks.nvim",
  opts = {
    notifier = {
      enabled = false,
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
