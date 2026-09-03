return {
  {
    pin = true,
    "neovim/nvim-lspconfig",
    name = "lspconfig",
    lazy = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "tailwindcss", "clangd", "pyright", "cssls", "cssmodules_ls" }
      })

      local lsps = require("mason-lspconfig").get_installed_servers()

      for _, lsp in pairs(lsps) do
        vim.lsp.config(lsp, {
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
          debounce_text_change = 300
        })
        vim.lsp.enable(lsp)
      end

      -- basedpyright for semantics only
      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright= {
            analysis = {
              typeCheckingMode = "strict"
            }
          }
        }
      })

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        severity_sort = true,
      })

      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
      vim.keymap.set("n", "gd", ":Telescope lsp_definitions<CR>")
      vim.keymap.set("n", "gR", ":Telescope lsp_references<CR>")
    end,
  },

  {
    pin = true,
    "hrsh7th/nvim-cmp",
    name = "cmp",
    event = "InsertEnter",
    lazy = true,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["P"] = cmp.mapping.scroll_docs(-4),
          ["N"] = cmp.mapping.scroll_docs(4),
          ["<C-a>"] = cmp.mapping.abort(),
          ["<C-e>"] = cmp.mapping.confirm({ select = true }),
        }),

        sources = cmp.config.sources({
          { name = "buffer" },
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "luasnip" },
          { name = "cmdline" },
        }),
      })
    end,
  },
}
