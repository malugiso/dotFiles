" leader is comma
let mapleader=","

" GENEREL SETTINGS ===========================================
set clipboard+=unnamedplus
syntax on
set encoding=utf-8
filetype plugin on
set nocompatible " wenns vimrc hat nimm das

" set Numbers and relatives
set number relativenumber

" tabs and spaces
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing

set showcmd     " shows comands in right bottem bar
set wildmenu    " visual autocomplete for command menu
set showmatch   " highlight matching [{()}]
set incsearch   " search as characters are entered
set hlsearch    " highlight matches

" MAPPINGS ===================================================
" " save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader><s-w> :wq<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader><s-q> :q!<cr>

" no highlights
nnoremap <leader><space> :nohlsearch<CR>

" buffer
nnoremap <leader>b :ls<CR>:buffer<Space>

" tab editing
noremap <leader>tn :tabnew<cr>
noremap <leader>tc :tabclose<cr>
noremap <leader>tm :tabmove
noremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" scroll 3 lines at a time
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
 
" open Plugins
noremap <C-p> :Files<CR>

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-)

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" sudo write file
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

let g:instant_markdown_autostart = 0         " Turns off auto preview
let g:instant_markdown_browser = "brave"      " Uses firefox for preview
map <Leader>md :InstantMarkdownPreview<CR>   " Previews .md file
map <Leader>ms :InstantMarkdownStop<CR>      " Kills the preview

" COPIED FROM LUKE ===========================================
" not sure about that
" Enable autocompletition:
set wildmode=longest,list,full
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" SPLITS =====================================================

set splitbelow splitright
" split vim Files
noremap <leader>- :sp <CR>
noremap <leader>\| :vs <CR>
" split navigations like vim navigation
noremap <C-h> <C-W>h
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l

" Light Line =================================================
set laststatus=2    "
set noshowmode      " hide default Mode notification
let g:lightline = {
\ 'colorscheme': 'darcula',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
\ },
\ 'component_function': {
\   'gitbranch': 'fugitive#head'
\ },
\ }



" PLUGIN INSTALL =============================================
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'jreybert/vimagit'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-commentary'
Plug 'kovetskiy/sxhkd-vim'
Plug 'junegunn/goyo.vim'
Plug 'ap/vim-css-color'                            " Color previews for CSS

Plug 'Townk/vim-autoclose'            "closes brackets and some stuff
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'          "lightline
Plug 'easymotion/vim-easymotion'             "Easy motion
Plug 'nvie/vim-flake8'
Plug 'christoomey/vim-tmux-navigator' "vim splits and tmux splits seamless
Plug 'suan/vim-instant-markdown', {'rtp': 'after'} " Markdown Preview
Plug 'suan/vim-instant-markdown', {'rtp': 'after'} " Markdown Preview
call plug#end()

" PLUGIN CONFING =============================================
" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    if has('nvim')
        let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
    else
        let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
    endif

" augroup tabs
augroup configgroup
	autocmd!
	autocmd VimEnter * highlight clear SignColumn
	autocmd FileType java setlocal noexpandtab
	autocmd FileType java setlocal formatprg=par\ -w80\ -T4
	autocmd FileType php setlocal expandtab
	autocmd FileType php setlocal list
	autocmd FileType php setlocal formatprg=par\ -w80\ -T4
	autocmd FileType *.py setlocal tabstop=4
	autocmd FileType *.py setlocal shiftwidth=4
	autocmd FileType *.py setlocal softtabstop=4
	autocmd FileType *.py setlocal textwidth=79
	autocmd FileType *.py setlocal commentstring=#\ %s
	autocmd BufEnter *.sh setlocal tabstop=2
	autocmd BufEnter *.sh setlocal shiftwidth=2
	autocmd BufEnter *.sh setlocal softtabstop=2
	autocmd BufEnter *.c setlocal tabstop=2
	autocmd BufEnter *.c setlocal shiftwidth=2
	autocmd BufEnter *.c setlocal softtabstop=2
augroup END

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %









" " some random settings
" "set cursorline  " highlight current line
" "set spell spelllang=en_us " checks spelling
" "syntastic settings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" 
" "tmux settings
" "set term=screen-256color
" 
" " Plugin 'vim-syntastic/syntastic'        "Checks Syntax when saveing
" Plugin 'scrooloose/nerdtree'            "Explorer left side
" Plugin 'jistr/vim-nerdtree-tabs'        "tabing in nerdtree
" Plugin 'tpope/vim-surround'             "souround brackets and stuff
" Plugin 'tpope/vim-repeat'               "repeat plugins with dot
" Plugin 'scrooloose/nerdcommenter'       "comments
" Plugin 'andviro/flake8-vim'             "flake8
" Plugin 'tpope/vim-fugitive'             "git function
" Plugin 'airblade/vim-gitgutter'         "show git + - 
" 
" " New Plugins
" Plugin 'terryma/vim-multiple-cursors'   "Ctr N multiple lines selection
" 
" "Plugin 'benmills/vimux'                 "commands from vim with tmux
" "Plugin 'majutsushi/tagbar'              "Tagbar
" "Plugin 'vimwiki/vimwiki'                "Vim Wiki
" 
" " Vim und Tmux zu alt
" "Plugin 'SirVer/ultisnips'               "Snippets
" "Plugin 'valloric/youcompleteme'         "Autocomplete
" 
