return {
    {
        "stevearc/conform.nvim",
        event = 'BufWritePre', -- uncomment for format on save
        opts = require "configs.conform", }, {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },
    {"ggandor/leap.nvim", commit="c6bfb191f1161fbabace1f36f578a20ac6c7642c"},
    {"rasulomaroff/telepath.nvim", commit="2879da05463db7bdc8824b13cccd8e8920c62a55"}, -- basically leap addon, needs leap to work
    {"tpope/vim-speeddating", commit="c17eb01ebf5aaf766c53bab1f6592710e5ffb796"},
    {"tpope/vim-repeat", commit="65846025c15494983dafe5e3b46c8f88ab2e9635"},
    {"nvim-lua/plenary.nvim", tag="v0.1.4"},
    {"haya14busa/is.vim", commit="d393cb346dcdf733fecd7bbfc45b70b8c05e9eb4"},
    {"github/copilot.vim", tag="v1.39.0"},
    {"BurntSushi/ripgrep", tag="14.1.0"},
    {"sindrets/diffview.nvim", commit="4516612fe98ff56ae0415a259ff6361a89419b0a"},
    {
        "NeogitOrg/neogit",
        lazy=false,
        dependencies = { "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true,
        commit="6af8fc6b03210d0ac99398f8eff27c5be7b2ba8a"
    },
    {
        "nvim-neorg/neorg",
        tag = "v9.1.1",
        lazy = false,
        opts = {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/orgfiles",
                        },
                        default_workspace = "notes",
                        index = "dashboard.norg"
                    },
                },
                ["core.export"] = {}, -- Allows for the exporting of documents using the ":Neorg export file_path" command
                ["core.export.markdown"] = {}, -- Allows for the exporting of documents using the ":Neorg export file_path" command
                ["core.completion"] = {
                    config = {
                        engine="nvim-cmp"
                    }
                }, -- Allows for the exporting of documents using the ":Neorg export file_path" command
                ["core.esupports.metagen"] = {
                    config = {
                        author="NicholasZolton",
                        type="auto"
                    }
                },
                ["core.integrations.nvim-cmp"] = {},
            },
        },
        dependencies = {
            { "nvim-lua/plenary.nvim" }
        }
    },
    -- this is a great example of overriding defaults
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
        opts = function()
            local conf = require "nvchad.configs.nvimtree"
            conf.renderer.root_folder_label = true
            return  conf
        end
    },
    {
        'numToStr/Comment.nvim',
        tag = "v0.8.0",
        lazy = false,
        opts = {
            toggler = {
                line="<C-_>",
            },
            opleader = {
                line="<C-_>",
            }
        },
        config = function ()
            require('Comment').setup()
        end
    },
}
