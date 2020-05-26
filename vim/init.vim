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
    Plug 'ervandew/supertab'                                          " Use tab instead of fucking C-x
    Plug 'davidhalter/jedi-vim'
    Plug 'derekwyatt/vim-scala'
    Plug 'sheerun/vim-polyglot'                                       " A collection of language packs for Vim
    let g:polyglot_disabled = ['scala', 'python']
    Plug 'dense-analysis/ale'                                         " Linting
call plug#end()

let home = $HOME
" ------ "
" PYTHON "
" ------ "
let g:python3_host_prog = home.'/miniconda3/envs/nvim_env/bin/python'
let g:loaded_python_provider = 1 "disable python2 support
" JEDI
let g:jedi#use_tabs_not_buffers = 1 "or let g:jedi#use_splits_not_buffers = "right"
let g:jedi#popup_on_dot = 0
" ALE
let g:ale_completion_enabled = 1 " Enable completion where available.
let g:ale_python_flake8_options = '--ignore E501,E731' " Disable line too long error
let g:ale_python_autopep8_options = '--ignore E501,E731'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_fix_on_save = 0 " Do not run autopep8 on save to autoformat code
let g:ale_fixers = { 'python': ['autopep8'] }
let g:ale_linters = { 'python': ['flake8', 'mypy'] }

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
