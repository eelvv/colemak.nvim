local M = {}
vim.g.mapleader = " "

local mode_nv = { "n", "v" }
local mode_v = { "v" }
local mode_i = { "i" }
local mode_ti = { "t", "i" }
local nmappings = {
	{ from = "S",			to = "<cmd>w<CR>"					},
	{ from = "Q",			to = "<cmd>q<CR>"					},
	{ from = "tn",			to = "<ESC>",		mode = mode_ti	},
	{ from = ";",			to = ":",			mode = mode_nv	},
	{ from = "Y",			to = '"+y',			mode = mode_v	},
	{ from = "`",			to = "~",			mode = mode_nv	},

	-- Movement
	{ from = "u",			to = "k",			mode = mode_nv	},
	{ from = "e",			to = "j",			mode = mode_nv	},
	{ from = "n",			to = "h",			mode = mode_nv	},
	{ from = "i",			to = "l",			mode = mode_nv	},
	{ from = "U",			to = "5k",			mode = mode_nv	},
	{ from = "E",			to = "5j",			mode = mode_nv	},
	{ from = "N",			to = "7h",			mode = mode_nv	},
	{ from = "I",			to = "7l",			mode = mode_nv	},
	{ from = "<c-n>",		to = "0",			mode = mode_nv	},
	{ from = "<c-i>",		to = "$",			mode = mode_nv	},
	{ from = "gu",			to = "gk",			mode = mode_nv	},
	{ from = "ge",			to = "gj",			mode = mode_nv	},
	{ from = "h",			to = "e",			mode = mode_nv	},
	{ from = "<C-U>",		to = "5<C-y>",		mode = mode_nv	},
	{ from = "<C-E>",		to = "5<C-e>",		mode = mode_nv	},
	{ from = "ci",			to = "cl"							},
	{ from = "cn",			to = "ch"							},
	{ from = "ck",			to = "ci"							},
	{ from = "c,.",			to = "c%"							},
	{ from = "yh",			to = "ye"							},

	-- Actions
	{ from = "l",			to = "u"							},
	{ from = "k",			to = "i",			mode = mode_nv	},
	{ from = "K",			to = "I",			mode = mode_nv	},

	-- Useful actions
	{ from = "\\v",			to = "v$h"							},
	{ from = ",.",			to = "%",			mode = mode_nv	},
	{ from = "<c-a>",		to = "<ESC>A",		mode = mode_i	},
	{ from = "<c-y>",		to = "<ESC>A {}<ESC>i<CR><ESC>ko",		mode = mode_i	},

	-- Window & splits
	{ from = "<leader>w",	to = "<C-w>w"						},
	{ from = "<leader>u",	to = "<C-w>k"						},
	{ from = "<leader>e",	to = "<C-w>j"						},
	{ from = "<leader>n",	to = "<C-w>h"						},
	{ from = "<leader>i",	to = "<C-w>l"						},
	{ from = "qf",			to = "<C-w>o"						},
	{ from = "s",			to = "<nop>"						},
	{ from = "su",			to = "<cmd>set nosplitbelow<CR><cmd>split<CR><cmd>set splitbelow<CR>"	},
	{ from = "sn",			to = "<cmd>set nosplitright<CR><cmd>vsplit<CR><cmd>set splitright<CR>"	},
	{ from = "se",			to = "<cmd>set splitbelow<CR>:split<CR>"								},
	{ from = "si",			to = "<cmd>set splitright<CR><cmd>vsplit<CR>"							},
	-- { from = "<up>",	to = "<cmd>res +5<CR>" },
	-- { from = "<down>",	to = "<cmd>res -5<CR>" },
	-- { from = "<left>",	to = "<cmd>vertical resize-5<CR>" },
	-- { from = "<right>",	to = "<cmd>vertical resize+5<CR>" },
	-- { from = "sh",            to = "se", },
	-- { from = "sh",            to = "<C-w>t<C-w>K", },
	-- { from = "sv",            to = "<C-w>t<C-w>H", },
	{ from = "srh",			to = "<C-w>b<C-w>K"					},
	{ from = "srv",			to = "<C-w>b<C-w>H"					},

	-- Tab management
	{ from = "tu",			to = "<cmd>tabe<CR>"				},
	{ from = "tU",			to = "<cmd>tab split<CR>"			},
	{ from = "tn",			to = "<cmd>-tabnext<CR>"			},
	{ from = "ti",			to = "<cmd>+tabnext<CR>"			},
	{ from = "tmn",			to = "<cmd>-tabmove<CR>"			},
	{ from = "tmi",			to = "<cmd>+tabmove<CR>"			},

	-- Other
	{ from = "<leader>sw",	to = "<cmd>set wrap<CR>"			},
	{ from = "<leader>sc",	to = "<cmd>set spell!<CR>"			},
	{ from = "<f10>",		to = "<cmd>TSHighlightCapturesUnderCursor<CR>"								},
	{ from = "<leader>o",	to = "za"							},
	{ from = "<leader>pr",	to = ":profile start profile.log<CR>:profile func *<CR>:profile file *<CR>"	},
	{ from = "<leader>rc",	to = "<cmd>e ~/.config/nvim/init.lua<CR>"									},
	-- { from = "<leader>rv",	to = "<cmd>e .vim.lua<CR>" },
	{ from = "<leader>tt",	to = "<cmd>%s/    /\\t/g<CR>"		},
	{ from = ",v",			to = "v%"							},
	{ from = "<leader><esc>",	to = "<nop>"					},

	-- search replace
	{ from = "\\s",			to = ":%s//g<left><left>"			},
	{ from = "<leader><CR>",	to = "<cmd>nohlsearch<CR>"		},
	{ from = "-",			to = "N"							},
	{ from = "=",			to = "n" },
  { from = ",q",    to = "q" },
}

local default_config = { key_mappings = nmappings }
M.config = default_config

function M.apply()
    for _, mapping in pairs(nmappings) do
        vim.api.nvim_set_keymap(
            mapping.mode or "n",
            mapping.from,
            mapping.to,
            { noremap = true }
        )
    end
end

function M.unapply()
    for _, mapping in pairs(nmappings) do
        vim.keymap.del(mapping.mode or "n", mapping.from)
    end
end

function M.setup(user_config)
    M.config = vim.tbl_deep_extend("force", default_config, user_config or {})
    for _, mapping in pairs(M.config.key_mappings) do
        vim.api.nvim_set_keymap(
            mapping.mode or "n",
            mapping.from,
            mapping.to,
            { noremap = true }
        )
    end
end


return M
