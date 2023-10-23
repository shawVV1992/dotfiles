return {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    keys = {
      { "<c-right>", desc = "Increment selection" },
      { "<c-left>", desc = "Decrement selection", mode = "x" },
    },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "c_sharp",
        "cmake",
        "csv",
        "diff",
        "git_config",
        "gitcommit",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "ninja",
        "python",
        "query",
        "regex",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-right>",
          node_incremental = "<c-right>",
          scope_incremental = false,
          node_decremental = "<c-left>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        },
      },
    },
  },
  -- nvim-treesitter-context
  {
    "nvim-treesitter/nvim-treesitter-context",
    init = function()
      local api = vim.api
      api.nvim_set_hl(0, "TreesitterContext", { link = "NormalFloat", default = true })
      api.nvim_set_hl(0, "TreesitterContextLineNumber", { italic = true, fg = "White" })
      api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true })
      api.nvim_set_hl(0, "TreesitterContextSeparator", { link = "FloatBorder", default = true })
    end,
  },
}
