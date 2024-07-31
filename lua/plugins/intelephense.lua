return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- @type lspconfig.options
      servers = {
        intelephense = {
          filetypes = { "php", "phtml", "twig", "tpl", "blade" },
          settings = {
            intelephense = {
              filetypes = { "php", "phtml", "twig", "tpl", "blade" },
              files = {
                associations = { "*.php", "*.phtml", "*.twig", "*.tpl", "*.blade.php" },
                maxSize = 5500000,
              },
            },
          },
        },
      },
    },
  },
}
