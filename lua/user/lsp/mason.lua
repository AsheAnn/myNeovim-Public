local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

local l_status_ok, neodev = pcall(require, "neodev")
if not l_status_ok then
  return
end

local servers = {
  "cssls",
  "cssmodules_ls",
  "emmet_ls",
  "html",
  "jsonls",
  "solc",
  "solidity",
  "solang",
  "lua_ls",
  "tailwindcss",
  "tsserver",
  "vuels",
  "pyright",
  "yamlls",
  "zk",
  "astro",
  "elixirls",
  "prismals",
  "rust_analyzer"
}

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server == "jsonls" then
    local jsonls_opts = require "user.lsp.settings.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "lua_ls" then
    -- local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    -- opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    -- opts = vim.tbl_deep_extend("force", require("lua-dev").setup(), opts)
    local luadev = neodev.setup {
      lspconfig = {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        --   -- settings = opts.settings,
      },
    }
    lspconfig.lua_ls.setup(luadev)
    goto continue
	 	-- local sumneko_opts = require("user.lsp.settings.sumneko_lua")
	 	-- opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "tsserver" then
    local tsserver_opts = require "user.lsp.settings.tsserver"
    opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
  end

  if server == "tailwindcss" then
    local tailwindcss_opts = require "user.lsp.settings.tailwindcss"
    opts = vim.tbl_deep_extend("force", tailwindcss_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "solc" then
    local solc_opts = require "user.lsp.settings.solc"
    opts = vim.tbl_deep_extend("force", solc_opts, opts)
  end

  if server == "emmet_ls" then
    local emmet_ls_opts = require "user.lsp.settings.emmet_ls"
    opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  end

  if server == "cssls" then
    local cssls_opts = require "user.lsp.settings.cssls"
    opts = vim.tbl_deep_extend("force", cssls_opts, opts)
  end


  if server == "astro" then
    local astro_opts = require "user.lsp.settings.astro"
    opts = vim.tbl_deep_extend("force", astro_opts, opts)
  end


 if server == "rust_analyzer" then
    local rust_opts = require "user.lsp.settings.rust"
    -- opts = vim.tbl_deep_extend("force", rust_opts, opts)
    local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
    if not rust_tools_status_ok then
      return
    end

    rust_tools.setup(rust_opts)
    goto continue
  end





  lspconfig[server].setup(opts)
  ::continue::
end

-- TODO: add something to installer later
-- require("lspconfig").motoko.setup {}
