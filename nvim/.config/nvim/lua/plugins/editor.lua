return {
  -- nvim - neo - tree
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      mappings = {
        ["o"] = "open",
        ["-"] = "open_split",
        ["|"] = "open_vsplit",
      },
    },
  },
}
