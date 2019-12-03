call plug#begin('~/.vim/plugged') ":PlugInstall --sync
    " Appearence
    Plug 'altercation/vim-colors-solarized'
    Plug 'vim-airline/vim-airline'                                    " Powerline-style bar
    Plug 'vim-airline/vim-airline-themes'                             " Airline themes
    Plug 'tpope/vim-fugitive'                                         " Show git branch in airline + use :Gedit :Gsplit :Gvsplit etc
    Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    " Accessibility
    Plug 'christoomey/vim-tmux-navigator'                             " Move smoothly between vim and tmux panes
    " Code completion, syntax highlighting etc
    Plug 'derekwyatt/vim-scala'
    Plug 'sheerun/vim-polyglot'                                       " A collection of language packs for Vim
    let g:polyglot_disabled = ['scala']
    Plug 'ambv/black', {'for': 'python'}                              " Uncompromised PEP8 formatter
call plug#end()

let home = $HOME
" Py stuff
let g:python3_host_prog = home.'/miniconda3/envs/nvim_env/bin/python'
let g:loaded_python_provider = 1 "disable python2 support
" autocmd BufWritePre *.py execute ':Black'
" let g:black_linelength = 160

" Disable annoying SQL completion
let g:loaded_sql_completion = 0
let g:omni_sql_no_default_maps = 1

" Colorscheme
syntax enable
set background=dark
colorscheme solarized
" transparent vim
hi Normal guibg=NONE ctermbg=NONE 

" General
set ruler
set nu
set cursorline
set lazyredraw      " redraw only when we need to.

" Movements
nnoremap B ^      " move to beginning/end of line
nnoremap E $
inoremap jj <esc>
inoremap Â <esc>

" Cycle buffers
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <C-q> :bd<CR>

" Search
set incsearch                             " search as chars are entered
set hlsearch                              " highlight matches
nnoremap <leader>/ :nohlsearch<CR>  " turn off search highlight

" delete without yanking
nnoremap d "_d
vnoremap d "_d
" replace currently selected text with default register without yanking it
vnoremap <leader>p "_dP

" OS Clipboard interaction
if !has('nvim')
  vmap <C-y> :w !pbcopy<CR><CR>
endif
vnoremap <C-y> "*y

" Mouse
set mouse=a
if !has('nvim')
    set ttymouse=xterm2
endif

" Tabs and indent
set tabstop=4       " Number of spaces a tab counts for
set softtabstop=4   " Number of spaces inserted with tab
set expandtab       " Turns tab into spaces
set shiftwidth=4    " Indents will have a width of 2 spaces

" Nerdtree
map - :NERDTreeToggle<CR>

" airline
let g:airline_powerline_fonts=1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#virtualenv#enabled = 1
