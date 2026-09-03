local scheme = "rose-pine"
local scheme_table = {}

if scheme == "rose-pine" then
	scheme_table = {
		pin = true,
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		lazy = false,
		opts = {
      variant="main",
			styles = {
				transparency = true,
				bold = true,
				italic = true,
			},
      highlight_groups = {
        Comment = { italic = true }
      }
		},
		config = function(_, opts)
			require("rose-pine").setup(opts)

			vim.cmd("colorscheme rose-pine")
		end,
	}
elseif scheme == "gruvbox" then
	scheme_table = {
		pin = true,
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		name = "gruvbox",
		lazy = false,
		opts = {
			transparent_mode = true,
		},
		config = function(_, opts)
			require("gruvbox").setup(opts)

			vim.cmd("colorscheme gruvbox")
		end,
	}
elseif scheme == "catppuccin" then
  scheme_table =  {
    pin = true,
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)

      vim.cmd("colorscheme catppuccin-mocha")
    end,
  }
else
--	scheme_table = {
--		"tribela/transparent.nvim",
--		event = "VimEnter",
--		config = true,
--	}
  vim.cmd("colorscheme default")
end

return {
	scheme_table,
	{
		pin = true,
    -- main is for nvim version 12
    branch="master",
    build=":TSUpdate",
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		lazy = true,
		name = "treesitter",
    opts = {
				auto_install = true,
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
				ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "python" },
    }
	}
}
