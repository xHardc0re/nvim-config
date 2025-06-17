local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local cmp = require("cmp")

-- Toggle nvim-tree
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- LSP format
map("n", "<leader>f", vim.lsp.buf.format, opts)

-- fzf-lua mappings
map("n", "<C-p>", "<cmd>lua require('fzf-lua').files()<CR>", opts)
map("n", "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<CR>", opts)

-- Buffer switching
map("n", "<Tab>", ":bnext<CR>", opts)       -- Next buffer
map("n", "<S-Tab>", ":bprevious<CR>", opts) -- Previous buffer

-- Diagnostic
vim.keymap.set("n", "<leader>t", vim.diagnostic.open_float)

-- Autocomplete
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<C-e>"] = cmp.mapping.abort(),
    }),
})
