-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Create plugins table by combining all plugin modules
local plugins = {}

-- Add themes
vim.list_extend(plugins, {
  -- Colorblind-friendly colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
          telescope = true,
          nvimtree = true,
          which_key = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
        },
      })
      vim.cmd.colorscheme("habamax")
    end,
  },

  -- Nightfox colorscheme
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          compile_path = vim.fn.stdpath("cache") .. "/nightfox",
          compile_file_suffix = "_compiled",
          transparent = false,
          terminal_colors = true,
          dim_inactive = false,
          module_default = true,
          colorblind = {
            enable = false,
            simulate_only = false,
            severity = {
              protan = 0,
              deutan = 0,
              tritan = 0,
            },
          },
          styles = {
            comments = "italic",
            conditionals = "NONE",
            constants = "NONE",
            functions = "NONE",
            keywords = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
          },
          inverse = {
            match_paren = false,
            visual = false,
            search = false,
          },
        },
      })
    end,
  },

  -- Theme picker plugin
  {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      require("themery").setup({
        themes = {
          "catppuccin-latte",
          "catppuccin-frappe",
          "catppuccin-macchiato",
          "catppuccin-mocha",
          "nightfox",
          "dayfox",
          "dawnfox",
          "duskfox",
          "nordfox",
          "terafox",
          "carbonfox",
          "default",
          "blue",
          "darkblue",
          "desert",
          "elflord",
          "evening",
          "habamax",
          "industry",
          "koehler",
          "morning",
          "murphy",
          "pablo",
          "peachpuff",
          "ron",
          "shine",
          "slate",
          "torte",
          "zellner",
        },
        livePreview = true,
      })
    end,
  },
})

-- Add other plugin modules
vim.list_extend(plugins, require("plugins.lsp"))
vim.list_extend(plugins, require("plugins.telescope"))
vim.list_extend(plugins, require("plugins.oil"))
vim.list_extend(plugins, require("plugins.cmp"))

-- Setup lazy with all plugins
require("lazy").setup(plugins)