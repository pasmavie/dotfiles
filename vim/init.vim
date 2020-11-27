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
    "Plug 'ervandew/supertab'                                          " Use tab instead of fucking C-x
    " Code completion, syntax highlighting, linting etc
    Plug 'sheerun/vim-polyglot'                                       " A collection of language packs for Vim
    let g:polyglot_disabled = ['python', 'scala']
    "Plug 'derekwyatt/vim-scala'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    "Plug 'davidhalter/jedi-vim'
    "Plug 'dense-analysis/ale'                                         " Linting
call plug#end()

let home = $HOME

tnoremap <Esc> <C-\><C-n>  " Exit terminal mode

" ------ "
" PYTHON "
" ------ "
"let g:python3_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = home.'/miniconda3/envs/nvim_env/bin/python'
let g:loaded_python_provider = 1 "disable python2 support
" JEDI
""let g:jedi#completions_enabled = 1 
""let g:jedi#use_tabs_not_buffers = 1 "or let g:jedi#use_splits_not_buffers = 'right'
""let g:jedi#popup_on_dot = 1
" ALE
""let g:ale_completion_enabled = 0 " Enable completion where available.
""let g:ale_python_flake8_options = '--ignore E501,E731,E203,E266,F403,F401,W503'
""let g:ale_python_autopep8_options = '--ignore E501,E731,E203,E266,F403,F401,W503'
""let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
""let g:ale_fix_on_save = 0 " Do not run autopep8 on save to autoformat code
""" let g:ale_fixers = { 'python': ['autopep8'] }
""let g:ale_linters = { 'python': ['flake8', 'mypy'] }

if has(('persistent_undo'))
set undofile          " Enable persistent undo so that undo history persists across vim sessions
set undodir=~/.vim/undo
endif

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
nnoremap B ^ 
nnoremap E $
inoremap jj <esc>
inoremap Â <esc>

" Cycle buffers
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <C-q> :bd<CR>
command Bd bp\|bd \#
" bp("buffer previous") moves us to a different buffer in the current window (bn would work, too), then bd # ("buffer delete" "alternate file") deletes the buffer we just moved away from https://stackoverflow.com/questions/4465095/vim-delete-buffer-without-losing-the-split-window

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


" Scala! Configuration for coc.nvim

autocmd FileType json syntax match Comment +\/\/.\+$+

" If hidden is not set, TextEdit might fail.
"set hidden

" Some servers have issues with backup files
set nobackup
set nowritebackup

" You will have a bad experience with diagnostic messages with the default 4000.
set updatetime=300

" Don't give |ins-completion-menu| messages.
set shortmess+=c

" Help Vim recognize *.sbt and *.sc as Scala files
au BufRead,BufNewFile *.sbt,*.sc set filetype=scala

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Used in the tab autocompletion for coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Used to expand decorations in worksheets
nmap <Leader>ws <Plug>(coc-metals-expand-decoration)

" Use K to either doHover or show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType scala setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of current line
xmap <leader>a  <Plug>(coc-codeaction-line)
nmap <leader>a  <Plug>(coc-codeaction-line)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Trigger for code actions
" Make sure `"codeLens.enable": true` is set in your coc config
nnoremap <leader>cl :<C-u>call CocActionAsync('codeLensAction')<CR>

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<CR>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Notify coc.nvim that <enter> has been pressed.
" Currently used for the formatOnType feature.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Toggle panel with Tree Views
nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
" Toggle Tree View 'metalsPackages'
nnoremap <silent> <space>tp :<C-u>CocCommand metals.tvp metalsPackages<CR>
" Toggle Tree View 'metalsCompile'
nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
" Toggle Tree View 'metalsBuild'
nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
" Reveal current current class (trait or object) in Tree View 'metalsPackages'
nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsPackages<CR>

