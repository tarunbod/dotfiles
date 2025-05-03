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

vim.cmd("autocmd Filetype go setlocal ts=4 sw=4 sts=4 noexpandtab")

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

-- Keybinds

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>p", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>s", "<cmd>Telescope git_status<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>f", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>g", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<C-w>", "<cmd>bdelete<cr>")
vim.keymap.set("n", "<leader>h", "<cmd>wincmd h<cr>")
vim.keymap.set("n", "<leader>j", "<cmd>wincmd j<cr>")
vim.keymap.set("n", "<leader>k", "<cmd>wincmd k<cr>")
vim.keymap.set("n", "<leader>l", "<cmd>wincmd l<cr>")

-- Plugins

vim.call("plug#begin")

vim.call("plug#", "nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
vim.call("plug#", "nvim-lua/plenary.nvim")
vim.call("plug#", "nvim-telescope/telescope.nvim", { ["tag"] = "0.1.8" })
vim.call("plug#", "nvim-tree/nvim-web-devicons")
vim.call("plug#", "nvim-tree/nvim-tree.lua")
vim.call("plug#", "williamboman/mason.nvim")
vim.call("plug#", "williamboman/mason-lspconfig.nvim")
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
vim.call("plug#", "ThePrimeagen/harpoon")
vim.call("plug#", "github/copilot.vim")
vim.call("plug#", "HakonHarnes/img-clip.nvim")
--vim.call("plug#", "zbirenbaum/copilot.lua")
vim.call("plug#", "rose-pine/neovim")
vim.call("plug#", "stevearc/dressing.nvim")
vim.call("plug#", "MunifTanjim/nui.nvim")
vim.call("plug#", "yetone/avante.nvim", { ["branch"] = "main", ["do"] = "make" })

vim.call("plug#end")

require("rose-pine").setup({
  variant = "main",
  styles = {
    italic = false,
  }
})
vim.cmd("colorscheme rose-pine")

require("lualine").setup({
  options = {
    theme = "rose-pine"
  }
})

local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>y", function()
  harpoon_mark.add_file()
  print("Added " .. vim.fn.expand("%") .. " to harpoon marks")
end)
vim.keymap.set("n", "<leader>u", harpoon_ui.nav_prev)
vim.keymap.set("n", "<leader>i", harpoon_ui.nav_next)
vim.keymap.set("n", "<leader>o", harpoon_ui.toggle_quick_menu)

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
    ["<CR>"] = cmp.mapping(function(fallback)
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

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
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

require "nvim-treesitter.configs".setup {
  highlight = {
    enable = true
  }
}

local ts_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>t", ts_builtin.treesitter)
local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gr", ts_builtin.lsp_references, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gh", vim.lsp.buf.hover, bufopts)
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

require("nvim-tree").setup {
  sync_root_with_cwd = true,
  view = {
    side = "right"
  }
}

require("mason").setup()

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup {
  ensure_installed = { "rust_analyzer", "gopls" }
}
mason_lspconfig.setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {
      on_attach = on_attach
    }
  end
}

vim.keymap.set("i", "<C-j>", "copilot#Accept(\"\")", {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

require("img-clip").setup({
  default = {
    embed_image_as_base64 = false,
    prompt_for_file_name = false,
    drag_and_drop = {
      insert_mode = true,
    },
  },
})

require("avante_lib").load()
require("avante").setup({
  claude = {
    model = "claude-3-7-sonnet-20250219",
  }
})

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
