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

vim.cmd("colorscheme jellybeans")

-- Keybinds

vim.g.mapleader = " "

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
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
vim.call("plug#", "nvim-telescope/telescope.nvim", { tag = "0.1.0" })
vim.call("plug#", "nvim-tree/nvim-web-devicons")
vim.call("plug#", "nvim-tree/nvim-tree.lua")
vim.call("plug#", "williamboman/mason.nvim")
vim.call("plug#", "williamboman/mason-lspconfig.nvim")
vim.call("plug#", "neovim/nvim-lspconfig")

vim.call("plug#end")

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-space>', vim.lsp.omnifunc, bufopts)
  vim.keymap.set('n', '<leader>d', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
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
    ensure_installed = { "rust_analyzer" }
}
require("mason-lspconfig").setup_handlers {
    function (server_name)
        require("lspconfig")[server_name].setup {
            on_attach = on_attach
        }
    end
}
