"-- PLUGINS
call plug#begin('~/.config/nvim/plugged')
	" Airline
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	" Neotree
	Plug 'nvim-neo-tree/neo-tree.nvim'
	Plug 'MunifTanjim/nui.nvim'

	" Treesitter
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	" LSP config
	Plug 'williamboman/mason.nvim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'williamboman/mason-lspconfig.nvim'

	" Git tools
	Plug 'tpope/vim-fugitive'
	Plug 'sindrets/diffview.nvim'

	" Themes
	Plug 'arcticicestudio/nord-vim'
	Plug 'kyazdani42/nvim-web-devicons'
	" Plug 'levouh/tint.nvim'

	" Autocompletion engine
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'L3MON4D3/LuaSnip'
	Plug 'saadparwaiz1/cmp_luasnip'
	Plug 'rafamadriz/friendly-snippets'

	" Telescope
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'

	" Todo comments
	Plug 'folke/todo-comments.nvim'

	" Comments tool
	Plug 'numToStr/Comment.nvim'

	" Nvim DAP
	Plug 'mfussenegger/nvim-dap'
	Plug 'rcarriga/nvim-dap-ui'
	Plug 'theHamsta/nvim-dap-virtual-text'
	Plug 'leoluz/nvim-dap-go'
	Plug 'ray-x/guihua.lua'
call plug#end()

"--- IMPORTING LUA FILES
luafile $HOME/.config/nvim/config/plugins_config.lua

"--- STYLE
set nocompatible
if (has("termguicolors"))
  set termguicolors
endif

set number
syntax enable
set laststatus=3
let g:nord_italic = 1
let g:nord_italic_comments = 1
colorscheme nord

highlight WinSeparator guibg=None
hi Normal guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE

"--- VARIABLES
set mouse=a
set clipboard=unnamed
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set smartindent
set smarttab

"--- KEYBINDINGS-NAVIGATION
nnoremap <silent><c-j> }
nnoremap <silent><c-k> {
vnoremap <silent><c-j> }
vnoremap <silent><c-k> {
nnoremap <silent><c-h> b
nnoremap <silent><c-l> e
vnoremap <silent><c-h> b
vnoremap <silent><c-l> e

nnoremap <silent><c-a> 0
nnoremap <silent><c-d> $
vnoremap <silent><c-a> 0
vnoremap <silent><c-d> $

inoremap <silent><c-h> <left>
inoremap <silent><c-l> <right>
inoremap <silent><c-k> <up>
inoremap <silent><c-j> <down>

"--- KEYBINDINGS-BUFFERS
nnoremap << :bp<cr>
nnoremap >> :bn<cr>

"--- KEYBINDINGS-MODES
inoremap jj <Esc>

"--- KEYBINDINGS-TELESCOPE
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fd <cmd>Telescope diagnostics<cr>

"--- KEYBINDINGS-SAVE FILE
nnoremap <silent><c-s> :<c-u>update<cr>
vnoremap <silent><c-s> <c-c>:update<cr>gv
inoremap <silent><c-s> <c-o>:update<cr><Esc>

"--- KEYBINDINGS CLOSE BUFFER
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

"--- VIM-AIRLINE CONFIG
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"--- AUTOMCOMPLETION
set completeopt=menu,menuone,noselect

"--- FOLDING
set foldmethod=indent
