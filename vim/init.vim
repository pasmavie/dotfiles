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
    Plug 'sheerun/vim-polyglot'                                       " A collection of language packs for Vim
    Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
    Plug 'ncm2/ncm2'                                                  " AutoCompletion!
    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2-bufword'                                          " Current Buffer
    Plug 'ncm2/ncm2-path'                                             " Path
    " Py specific
    let g:polyglot_disabled = ['python']
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

" General
set ruler
set nu
set cursorline
set lazyredraw      " redraw only when we need to.

" Movements
nnoremap B ^      " move to beginning/end of line
nnoremap E $
inoremap jj <esc>
inoremap � <esc>

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

" NCM2
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" suppress the annoying 'match x of y', 'The only match' and 'Pattern not found' messages
set shortmess+=c
" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" wrap existing omnifunc
au User Ncm2Plugin call ncm2#register_source({
        \ 'name' : 'css',
        \ 'priority': 9,
        \ 'subscope_enable': 1,
        \ 'scope': ['css','scss'],
        \ 'mark': 'css',
        \ 'word_pattern': '[\w\-]+',
        \ 'complete_pattern': ':\s*',
        \ 'on_complete': ['ncm2#on_complete#delay', 180, 
                       \  'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
        \ })

" Langugage Servers!
let g:LanguageClient_autoStart = 1
let g:LanguageClient_settingsPath = home.'/.vim/settings.json'
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_serverCommands = {
    \ 'python': [home.'/miniconda3/envs/nvim_env/bin/pyls'],
    \}

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
