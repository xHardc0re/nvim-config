local function get_intelephense_license()
  local license_path = os.getenv("HOME") .. "/intelephense/license.txt"
  local f = io.open(license_path, "r")
  if f then
    local key = f:read("*a")
    f:close()
    return key:gsub("%s+", "")
  else
    return nil
  end
end

require("lazy").setup({
  -- Gruvbox theme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      require("gruvbox").setup({
        contrast = "hard",
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },

  -- nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        view = {
          side = "right",
        }
      })
    end,
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",
        },
      })
    end,
  },

  -- fzf-lua
  {
    "ibhagwan/fzf-lua",
    config = function()
      require("fzf-lua").setup({})
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "twig", "html", "php", "javascript", "typescript", "lua", "css", "sql" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Vim Matchup
  {
    "andymass/vim-matchup",
    event = "BufReadPre",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason LSP config
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "intelephense", "html", "emmet_ls" },
      })
    end,
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- intelephense
      lspconfig.intelephense.setup({
        init_options = {
          licenseKey = get_intelephense_license(),
        },
      })

      -- typescript
      lspconfig.ts_ls.setup({
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
      })

      -- html
      lspconfig.html.setup({})
    end,
  },

  -- Emmet LSP
  {
    "aca/emmet-ls",
    config = function()
      require("lspconfig").emmet_ls.setup({
        filetypes = { "html", "css", "scss", "blade", "twig", "php" },
      })
    end,
  },

  -- nvim-dap
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" }
      }
      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug",
          port = 9003,
          pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}",
          },
        },
      }
    end,
  },

  -- PHPUnit Test Runner
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-phpunit",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-phpunit")({
            phpunit_cmd = function()
              return "vendor/bin/phpunit"
            end,
          }),
        },
      })
    end,
  },

  -- Null ls
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
          require("none-ls.diagnostics.eslint_d"),
          null_ls.builtins.formatting.phpcsfixer,
          null_ls.builtins.diagnostics.phpstan.with({
            extra_args = { "--level=7" },
          }),
        },
      })
    end,
  },
})
