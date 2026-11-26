-- General Options

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.hlsearch = false
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"
vim.opt.background = "dark"
vim.opt.termguicolors = true

vim.o.exrc = true
vim.o.secure = true

vim.cmd("autocmd Filetype go setlocal noexpandtab")

local my_group = vim.api.nvim_create_augroup("tarunbod", {})
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  group = my_group,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

local yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

-- Plugins

vim.call("plug#begin")

vim.call("plug#", "nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate", ["branch"] = "main" })
vim.call("plug#", "nvim-lua/plenary.nvim")
vim.call("plug#", "nvim-telescope/telescope.nvim")
vim.call("plug#", "nvim-tree/nvim-web-devicons")
vim.call("plug#", "nvim-tree/nvim-tree.lua")
vim.call("plug#", "neovim/nvim-lspconfig")
vim.call("plug#", "rafamadriz/friendly-snippets")
vim.call("plug#", "L3MON4D3/LuaSnip", { ["tag"] = "v2.*", ["do"] = "make install_jsregexp" })
vim.call("plug#", "saadparwaiz1/cmp_luasnip")
vim.call("plug#", "hrsh7th/cmp-nvim-lsp")
vim.call("plug#", "hrsh7th/cmp-buffer")
vim.call("plug#", "hrsh7th/cmp-path")
vim.call("plug#", "hrsh7th/cmp-cmdline")
vim.call("plug#", "hrsh7th/nvim-cmp")
vim.call("plug#", "nvim-lualine/lualine.nvim")
vim.call("plug#", "github/copilot.vim")
vim.call("plug#", "HakonHarnes/img-clip.nvim")
vim.call("plug#", "rose-pine/neovim")
vim.call("plug#", "stevearc/dressing.nvim")
vim.call("plug#", "MunifTanjim/nui.nvim")
vim.call("plug#", "folke/snacks.nvim")
vim.call("plug#", "dmtrKovalenko/fff.nvim", { ["do"] = "cargo build -r" })

vim.call("plug#end")

-- Charcoal Atelier colors from charcoal-atelier.json.
local charcoal_ansi = {
  "#222222", "#d96a4d", "#9aab84", "#cfae7a",
  "#8aa0b4", "#b193a8", "#8fafa8", "#b5b1ab",
  "#5f5c58", "#e8886e", "#b3c39d", "#e0c493",
  "#a4b9cc", "#c8adc0", "#a8c7c0", "#efece7",
}
local charcoal_background = "#161616"
local charcoal_selection = "#3a3835"

require("rose-pine").setup({
  variant = "main",
  palette = {
    main = {
      _nc = "#1a1a1a",
      base = charcoal_background,
      surface = "#1d1d1d",
      overlay = "#262626",
      muted = "#716f6c",
      subtle = "#8f8c88",
      text = "#d6d2cc",
      love = charcoal_ansi[2],
      gold = charcoal_ansi[4],
      rose = charcoal_ansi[10],
      pine = charcoal_ansi[5],
      foam = charcoal_ansi[7],
      iris = charcoal_ansi[6],
      leaf = charcoal_ansi[3],
      highlight_low = charcoal_ansi[1],
      highlight_med = charcoal_selection,
      highlight_high = "#4b4a48",
    },
  },
  groups = {
    git_add = "leaf",
    git_change = "gold",
    git_dirty = "gold",
    git_text = "gold",
  },
  highlight_groups = {
    Cursor = { fg = charcoal_background, bg = "#e05d3a" },
    Visual = { fg = charcoal_ansi[16], bg = charcoal_selection, inherit = false },
  },
  enable = {
    terminal = false,
  },
  styles = {
    italic = false,
  }
})
vim.cmd("colorscheme rose-pine")
vim.opt.guicursor:append("a:Cursor")

for index, color in ipairs(charcoal_ansi) do
  vim.g["terminal_color_" .. (index - 1)] = color
end

require("lualine").setup({
  options = {
    theme = "rose-pine"
  }
})

local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-o>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            if luasnip.expandable() then
                luasnip.expand()
            else
                cmp.confirm({
                    select = true,
                })
            end
        else
            fallback()
        end
    end),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline" }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

vim.diagnostic.config({
  -- update_in_insert = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

require("nvim-treesitter.config").setup({
  highlight = {
    enable = true
  }
})

require("nvim-tree").setup({
  sync_root_with_cwd = true,
  view = {
    side = "right"
  }
})

vim.lsp.enable({
  'astro',
  'gopls',
  'ruff',
  'rust_analyzer',
  'ts_ls',
  'nil_ls',
  'clangd',
  'nushell',
  'zls',
  'ocamllsp'
})

vim.lsp.config('elixirls', {
  cmd = { "elixir-ls" }
})

require("img-clip").setup({
  default = {
    embed_image_as_base64 = false,
    prompt_for_file_name = false,
    drag_and_drop = {
      insert_mode = true,
    },
  },
})

require("fff").setup({})

-- Keybinds

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>p", function()
  require("fff").find_files()
end)
vim.keymap.set("n", "<leader>s", "<cmd>Telescope git_status<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>f", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>g", "<cmd>NvimTreeToggle<cr>")
local ts_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>t", ts_builtin.treesitter)
vim.keymap.set("n", "<C-w>", "<cmd>bdelete<cr>")
vim.keymap.set("n", "<leader>h", "<cmd>wincmd h<cr>")
vim.keymap.set("n", "<leader>j", "<cmd>wincmd j<cr>")
vim.keymap.set("n", "<leader>k", "<cmd>wincmd k<cr>")
vim.keymap.set("n", "<leader>l", "<cmd>wincmd l<cr>")

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gr", ts_builtin.lsp_references, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "gh", function()
      vim.lsp.buf.hover({ border = "rounded" })
    end, bufopts)
    vim.keymap.set("n", "ge", vim.lsp.buf.rename, bufopts)
    -- vim.keymap.set("i", "<C-o>", vim.lsp.omnifunc, bufopts)
    vim.keymap.set("n", "<leader>d", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.format, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)

    vim.keymap.set("n", "<leader>n", vim.diagnostic.goto_next)
    vim.keymap.set("n", "<leader>m", vim.diagnostic.goto_prev)
  end
})

vim.keymap.set("i", "<C-j>", "copilot#Accept(\"\")", {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

local open_in_github = function()
  local url = vim.fn.system("git remote get-url origin")
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD")
  local line = vim.fn.line(".")
  local column = vim.fn.col(".")
  local file = vim.fn.expand("%")

  local url = string.gsub(url, "git@", "https://")
  local url = string.gsub(url, "github.com:", "github.com/")
  local url = string.gsub(url, "%.git", "")
  local url = string.gsub(url, "\n", "")
  local branch = string.gsub(branch, "\n", "")
  local url = url .. "/blob/" .. branch .. "/" .. file .. "#L" .. line
  vim.fn.system("open \"" .. url .. "\"")
end

local open_in_github_safe = function()
  if not pcall(open_in_github) then
    print("Failed to open in github")
  end
end
vim.keymap.set("n", "<leader>og", open_in_github_safe)
