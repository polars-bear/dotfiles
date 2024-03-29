local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
	'rust_analyzer',
	'gopls',
    'lua_ls',
    'pylsp',
    'clangd',
})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
end)

lsp.setup()
