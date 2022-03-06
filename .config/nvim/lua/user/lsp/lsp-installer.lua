local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

-- Include the servers you want to have installed by default below
local servers = {
  "cssls",
  "tsserver",
  "gopls",
  "html",
  "pyright",
  "yamlls",
  "sumneko_lua",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
    }

    if server.name == "gopls" then
        local gopls_opts = require("user.lsp.settings.gopls")
        opts = vim.tbl_deep_extend("force", gopls_opts, opts)
    end

    server:setup(opts)
end)
