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

-- Keybinds

vim.g.mapleader = " "

function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true })
end

function nmap(shortcut, command)
    map("n", shortcut, command)
end

function imap(shortcut, command)
    map("i", shortcut, command)
end

nmap("<leader>p", "<cmd>Telescope find_files<cr>")
nmap("<leader>s", "<cmd>Telescope git_status<cr>")
nmap("<leader>b", "<cmd>Telescope buffers<cr>")
nmap("<leader>f", "<cmd>Telescope live_grep<cr>")
nmap("<leader>g", "<cmd>NvimTreeToggle<cr>")
nmap("<C-w>", "<cmd>bdelete<cr>")
nmap("<leader>h", "<cmd>wincmd h<cr>")
nmap("<leader>j", "<cmd>wincmd j<cr>")
nmap("<leader>k", "<cmd>wincmd k<cr>")
nmap("<leader>l", "<cmd>wincmd l<cr>")

-- Plugins

vim.call("plug#begin")

vim.call("plug#", "nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
vim.call("plug#", "nvim-lua/plenary.nvim")
vim.call("plug#", "nvim-telescope/telescope.nvim", { ["tag"] = "0.1.0" })
vim.call("plug#", "nvim-tree/nvim-web-devicons")
vim.call("plug#", "nvim-tree/nvim-tree.lua")
vim.call("plug#", "williamboman/mason.nvim")
vim.call("plug#", "williamboman/mason-lspconfig.nvim")
vim.call("plug#", "neovim/nvim-lspconfig")
vim.call("plug#", "nvim-lualine/lualine.nvim")
vim.call("plug#", "rebelot/kanagawa.nvim")

vim.call("plug#end")

require "kanagawa".setup {
    overrides = function(colors)
        local theme = colors.theme
        return {
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
        }
    end
}
vim.cmd("colorscheme kanagawa")

require "lualine".setup {
    options = {
        theme = "kanagawa"
    }
}

require "nvim-treesitter.configs".setup {
    highlight = {
        enable = true
    }
}

ts_builtin = require("telescope.builtin")
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
require("mason-lspconfig").setup_handlers {
    function (server_name)
        require("lspconfig")[server_name].setup {
            on_attach = on_attach
        }
    end
}
