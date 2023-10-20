return {

  {
    -- 侧边栏-文件浏览器
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>fE",
        function()
          local Util = require("lazyvim.util")
          require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (cwd)", remap = true },
    },
    opts = {
      -- 取消默认快捷键配置
      use_default_mappings = false,
      -- 文件操作快捷键
      window = {
        mappings = {
          ["o"] = "open",
          -- ["<space>"] = {
          --   "toggle_node",
          --   nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
          -- },
          ["<2-LeftMouse>"] = "open",
          ["<esc>"] = "cancel", -- close preview or floating neo-tree window
          ["P"] = { "toggle_preview", config = { use_float = true } },
          ["l"] = "focus_preview",
          ["W"] = "open_split",
          ["w"] = "open_vsplit",
          -- ["t"] = "open_tabnew",
          -- ["w"] = "open_with_window_picker",
          ["z"] = "close_node",
          ["Z"] = "close_all_nodes",
          ["a"] = {
            "add",
            -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
            -- some commands may take optional config options, see `:h neo-tree-mappings` for details
            config = {
              show_path = "none", -- "none", "relative", "absolute"
            },
          },
          ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
          -- ["c"] = {
          --  "copy",
          --  config = {
          --    show_path = "none" -- "none", "relative", "absolute"
          --  }
          --}
          ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
          ["i"] = "show_file_details",
        },
      },
      -- 文件组织显隐以及快捷键
      filesystem = {
        window = {
          mappings = {
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["/"] = "fuzzy_finder",
            ["D"] = "fuzzy_finder_directory",
            ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
            -- ["D"] = "fuzzy_sorter_directory",
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
            ["gk"] = "prev_git_modified",
            ["gj"] = "next_git_modified",
            ["s"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "s" } },
            ["sc"] = { "order_by_created", nowait = false },
            ["sd"] = { "order_by_diagnostics", nowait = false },
            ["sg"] = { "order_by_git_status", nowait = false },
            ["sm"] = { "order_by_modified", nowait = false },
            ["sn"] = { "order_by_name", nowait = false },
            ["ss"] = { "order_by_size", nowait = false },
            ["st"] = { "order_by_type", nowait = false },
          },
          fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
            ["<down>"] = "move_cursor_down",
            ["<C-n>"] = "move_cursor_down",
            ["<up>"] = "move_cursor_up",
            ["<C-p>"] = "move_cursor_up",
          },
        },
      },
      -- buffer 浏览器
      buffers = {
        window = {
          mappings = {
            ["bd"] = "buffer_delete",
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["s"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
            ["sc"] = { "order_by_created", nowait = false },
            ["sd"] = { "order_by_diagnostics", nowait = false },
            ["sm"] = { "order_by_modified", nowait = false },
            ["sn"] = { "order_by_name", nowait = false },
            ["ss"] = { "order_by_size", nowait = false },
            ["st"] = { "order_by_type", nowait = false },
          },
        },
      },
      -- git 状态浏览器
      git_status = {
        window = {
          position = "float",
          mappings = {
            ["A"] = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["ga"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["gc"] = "git_commit",
            ["gp"] = "git_push",
            ["gg"] = "git_commit_and_push",
            ["s"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
            ["sc"] = { "order_by_created", nowait = false },
            ["sd"] = { "order_by_diagnostics", nowait = false },
            ["sm"] = { "order_by_modified", nowait = false },
            ["sn"] = { "order_by_name", nowait = false },
            ["ss"] = { "order_by_size", nowait = false },
            ["st"] = { "order_by_type", nowait = false },
          },
        },
      },
    },
  },
  {
    -- 右上消息通知
    "rcarriga/nvim-notify",
    opts = {
      -- 显示时间延迟
      timeout = 5000,
    },
  },
}
