-- General Options

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.hlsearch = false
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"

vim.cmd("autocmd Filetype json            setlocal ts=2 sw=2 sts=2 expandtab")
vim.cmd("autocmd Filetype lua             setlocal ts=2 sw=2 sts=2 expandtab")
vim.cmd("autocmd Filetype javascript      setlocal ts=2 sw=2 sts=2 expandtab")
vim.cmd("autocmd Filetype javascriptreact setlocal ts=2 sw=2 sts=2 expandtab")
vim.cmd("autocmd Filetype typescript      setlocal ts=2 sw=2 sts=2 expandtab")
vim.cmd("autocmd Filetype typescriptreact setlocal ts=2 sw=2 sts=2 expandtab")
vim.cmd("autocmd Filetype html            setlocal ts=2 sw=2 sts=2 expandtab")
vim.cmd("autocmd Filetype css             setlocal ts=2 sw=2 sts=2 expandtab")
vim.cmd("autocmd Filetype go              setlocal noexpandtab")

local my_group = vim.api.nvim_create_augroup("tarunbod", {})
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    group = my_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

local yank_group = vim.api.nvim_create_augroup('HighlightYank', {})
vim.api.nvim_create_autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
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
vim.call("plug#", "nvim-lualine/lualine.nvim")
vim.call("plug#", "ThePrimeagen/harpoon")
vim.call("plug#", "github/copilot.vim")
vim.call("plug#", "EdenEast/nightfox.nvim")

vim.call("plug#end")

local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>y", function()
    harpoon_mark.add_file()
    print("Added " .. vim.fn.expand("%") .. " to harpoon marks")
end)
vim.keymap.set("n", "<leader>u", harpoon_ui.nav_prev)
vim.keymap.set("n", "<leader>i", harpoon_ui.nav_next)
vim.keymap.set("n", "<leader>o", harpoon_ui.toggle_quick_menu)

vim.cmd("colorscheme carbonfox")

require "lualine".setup {
    options = {
        theme = "tokyonight"
    }
}

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
    vim.keymap.set("i", "<C-o>", vim.lsp.omnifunc, bufopts)
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
require("mason-lspconfig").setup {
    ensure_installed = { "rust_analyzer", "gopls" }
}

local lspconfig = require("lspconfig")

local default_handler = function(server_name)
    lspconfig[server_name].setup {
        on_attach = on_attach
    }
end

require("mason-lspconfig").setup_handlers {
  default_handler
}
