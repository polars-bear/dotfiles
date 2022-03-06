local M = {}

M.setup = function()
    local config = {
        virtual_text = false,
        update_in_insert = true,
        severitiy_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            -- border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)
end

local function lsp_highlight_document(client)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END 
            ]],
            false
        )
    end
end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", ":lua vim.lsp.buf.declaration()<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", ":lua vim.lsp.buf.definition()<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":lua vim.lsp.buf.implementation()<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", ":lua vim.lsp.buf.hover()<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gk", ":lua vim.lsp.buf.signature_help()<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", ":lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gf", ":lua vim.lsp.buf.formatting()<cr>", opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

M.on_attach = function(client, bufnr)
    if client.name == "tsserver" then
        client.resolved_capabilites.document_formatting = false
    end
    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
    M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

return M
