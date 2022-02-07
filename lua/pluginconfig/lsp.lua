-- Run LSP setup + config
require("pluginconfig.lsp-setup").setup()

-- SETUP LSP SERVERS
require'lspconfig'.pyright.setup{}
-- SETUP LUA SERVER
USER = vim.fn.expand('$USER')

local sumneko_root_path = ""
local sumneko_binary = ""

-- expects to find the language server binary in the language-servers subdirectory of the home folder.
if vim.fn.has("mac") == 1 then
    sumneko_root_path = "/Users/" .. USER .. "/lua-language-server"
    sumneko_binary = "/Users/" .. USER .. "lua-language-server/bin/macOS/lua-language-server"
elseif vim.fn.has("unix") == 1 then
    sumneko_root_path = "/home/" .. USER .. "/language-servers/lua-language-server"
    sumneko_binary = "/home/" .. USER .. "language-servers/lua-language-server/bin/lua-language-server"
elseif vim.fn.has("windows") == 1 then
    sumneko_root_path = os.getenv("USERPROFILE") .. "\\language-servers\\lua\\"
    sumneko_binary = os.getenv("USERPROFILE") .. "\\language-servers\\lua\\bin\\lua-language-server.exe"
else
    print("Unsupported system for sumneko")
end

local function generate_runtime_path()
    -- This function generates the runtime path for Unix or Windows
    local library
   if vim.fn.has("unix") or vim.fn.has("mac") then
      library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
      }
    elseif vim.fn.has("windows") then
      library = {
          [vim.fn.expand('$VIMRUNTIME\\lua')] = true,
          [vim.fn.stdpath "config" .. "\\lua"] = true,
      }
   end
   return library
end

require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = generate_runtime_path()
            }
        }
    }
}

require'lspconfig'.rls.setup{}
require'lspconfig'.angularls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.cssmodules_ls.setup{}
require'lspconfig'.cssls.setup{}



