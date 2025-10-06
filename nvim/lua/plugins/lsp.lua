local servers = {}
local isRoslyn = false
table.insert(servers, "lua_ls")
table.insert(servers, "pyright")

if vim.fn.executable("dotnet") == 1 then
    table.insert(servers, isRoslyn and "roslyn" or "omnisharp")
end

if vim.fn.executable("node") == 1 then
    table.insert(servers, "ts_ls")
end

return {
  -- LSP Configuration:with
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- LSP on_attach function
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end

      -- Setup OmniSharp for C#
      lspconfig.omnisharp.setup({
        cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
        on_attach = on_attach,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        root_dir = function(fname)
          return lspconfig.util.root_pattern("*.sln", "*.csproj", ".git")(fname)
        end,
        settings = {
          FormattingOptions = {
            EnableEditorConfigSupport = true,
            OrganizeImports = true,
          },
          MsBuild = {
            LoadProjectsOnDemand = false,
          },
          RoslynExtensionsOptions = {
            EnableAnalyzersSupport = true,
            EnableImportCompletion = true,
            AnalyzeOpenDocumentsOnly = false,
          },
          Sdk = {
            IncludePrereleases = true,
          },
        },
        init_options = {
          AutomaticWorkspaceInit = true,
        },
        handlers = {
          ["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
              -- Filter out specific diagnostic codes
              filter = function(diagnostic)
                -- Handle both string and table formats for diagnostic codes
                local code = diagnostic.code
                if type(code) == "table" and code.value then
                  code = code.value
                end

                -- Convert to string if it's a number
                if type(code) == "number" then
                  code = tostring(code)
                end

                -- Filter out specific unwanted hints
                local unwanted_codes = {
                  "IDE0062", -- Make method static
                  "IDE0200", -- Remove unnecessary lambda expression
                  "IDE0063", -- Use simple 'using' statement
                  "IDE0090", -- Use 'new(...)'
                  "IDE0270", -- Use coalesce expression
                  "IDE0300", -- Use collection expression for array
                  "IDE0301", -- Use collection expression for empty
                  "IDE0302", -- Use collection expression for stackalloc
                  "IDE0059", -- Unnecessary assignment of a value to a variable
                  "IDE0007", -- Use implicit type (var)
                  "IDE0008", -- Use explicit type instead of var
                }

                for _, unwanted_code in ipairs(unwanted_codes) do
                  if code == unwanted_code then
                    return false
                  end
                end

                -- Also filter by message content as fallback
                if diagnostic.message then
                  local msg = diagnostic.message:lower()
                  if msg:match("use.*var") or
                     msg:match("explicit.*type") or
                     msg:match("implicit.*type") then
                    return false
                  end
                end

                return true
              end
            }
          )
        },
      })
    end,
  },

  -- Mason plugin for managing LSP servers, DAP servers, linters, and formatters
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason integration with lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })
    end,
  },
}
