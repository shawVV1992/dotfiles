local Util = require("lazyvim.util")

return {
  --nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },
      "nvimdev/lspsaga.nvim",
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      if Util.has("neoconf.nvim") then
        local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
        require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
      end

      -- setup autoformat
      Util.format.register(Util.lsp.formatter())

      -- deprectaed options
      if opts.autoformat ~= nil then
        vim.g.autoformat = opts.autoformat
        Util.deprecate("nvim-lspconfig.opts.autoformat", "vim.g.autoformat")
      end

      -- setup keymaps
      Util.lsp.on_attach(function(client, buffer)
        require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      local register_capability = vim.lsp.handlers["client/registerCapability"]

      vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client_id = ctx.client_id
        ---@type lsp.Client
        local client = vim.lsp.get_client_by_id(client_id)
        local buffer = vim.api.nvim_get_current_buf()
        require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)

        return ret
      end

      -- diagnostics
      for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

      if opts.inlay_hints.enabled and inlay_hint then
        Util.lsp.on_attach(function(client, buffer)
          if client.supports_method("textDocument/inlayHint") then
            inlay_hint(buffer, true)
          end
        end)
      end

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
          or function(diagnostic)
            local icons = require("lazyvim.config").icons.diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        --   local border = {
        --     { "🭽", "FloatBorder" },
        --     { "▔", "FloatBorder" },
        --     { "🭾", "FloatBorder" },
        --     { "▕", "FloatBorder" },
        --     { "🭿", "FloatBorder" },
        --     { "▁", "FloatBorder" },
        --     { "🭼", "FloatBorder" },
        --     { "▏", "FloatBorder" },
        --   }
        --
        --   -- LSP settings (for overriding per client)
        --
        --   local handlers = {
        --     ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
        --     ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
        --   }
        --
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
          -- handlers = handlers,
        }, servers[server] or {})
        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end

      if Util.lsp.get_config("denols") and Util.lsp.get_config("tsserver") then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        Util.lsp.disable("tsserver", is_deno)
        Util.lsp.disable("denols", function(root_dir)
          return not is_deno(root_dir)
        end)
      end
    end,
    -- keymap
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[#keys + 1] = { "K", "<cmd>Lspsaga hover_doc<cr>" }
      keys[#keys + 1] = { "<leader>ca", "<cmd>Lspsaga code_action<cr>" }
      -- disable a keymap
      -- keys[#keys + 1] = { "K", false }
      -- -- add a keymap
      -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
    end,
  },

  --lspsage
  {
    "nvimdev/lspsaga.nvim",
    event = "LazyFile",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
    config = function()
      -- local border_bl = {
      --   { "🭽", "FloatBorder" },
      --   { "▔", "FloatBorder" },
      --   { "🭾", "FloatBorder" },
      --   { "▕", "FloatBorder" },
      --   { "🭿", "FloatBorder" },
      --   { "▁", "FloatBorder" },
      --   { "🭼", "FloatBorder" },
      --   { "▏", "FloatBorder" },
      -- }
      local opts = {
        ui = {
          -- border = border_bl,
          border = "rounded",
        },
        symbol_in_winbar = {
          enable = false,
        },
        lightbulb = {
          enable = false,
        },
        code_action = {
          keys = {
            quit = "q",
            quit = "<esc>",
            exec = "<CR>",
          },
        },
      }
      require("lspsaga").setup(opts)
    end,
  },
}
