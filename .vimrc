" Download vim-plug Plugin Manager if it is not in the system
" This depends on: curl
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugUpdate --sync | source $MYVIMRC | q | q
endif


" ========== vim-plug Plugin Manager ==========

" vim-plug automatically executes
"   - filetype plugin on
"   - syntax enable

" vim-instant-markdown dependencies:
"   - apt-get install nodejs npm xdg-utils curl
"   - npm -g install instant-markdown-d
"
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-smooth-scroll'
Plug 'vim-airline/vim-airline'
Plug 'pearofducks/ansible-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()


"========== General ==========
"Remap caps lock to Control
"- deactive caps lock when entering vim
"- map caps lock to control
"- remap when exiting vim
"https://vi.stackexchange.com/questions/376/can-vim-automatically-turn-off-capslock-when-returning-to-normal-mode
"xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
"- does that works wiuthout X?
"
"
"au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
"au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'
"
"
"This requires xorg-xmodmap
"
"http://vim.wikia.com/wiki/Map_caps_lock_to_escape_in_XWindows
"
"https://www.emacswiki.org/emacs/MovingTheCtrlKey
"
"https://askubuntu.com/questions/445099/whats-the-opposite-of-setxkbmap-option-ctrlnocaps
"
"setxkbmap -option ctrl:nocaps       # Make Caps Lock a Control key
"setxkbmap -option          # To remove the mapping
"
" How to turn off caps lock before doing that thingie
"
"
" Syntax color
syntax on

" Colorscheme for the syntax
"   - ron works well with GNOME Terminal color profile Nord/Nord Solarized.
"   - nord needs to be pluged inside plugin section.
colorscheme ron

" Column limit highlight
set colorcolumn=80
highlight ColorColumn ctermbg=darkgray

" Put color on trailing whitespaces and tabs
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$\|\t/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$\|\t/
au InsertLeave * match ExtraWhiteSpace /\s\+$\|\t/

" Highlight search results
set hlsearch
highlight Search ctermbg=Red ctermfg=Yellow

" Find dinamically as we type search term
set incsearch

" Ignore case when searching, unless a capital character is used
set ignorecase
set smartcase

" Show line numbers
set number

" Show file name as window title
set title

" Set old window title to emtpy, so the text 'Thanks for flying vim' will
" not be shown as the title of the terminal
set titleold=

" Uses 4 spaces (instead of tab) as indentation
set expandtab
set tabstop=4
set softtabstop=0
set shiftwidth=4

" Open vertical split on the right
set splitright

" Open horizontal splot on the bottom
set splitbelow

" Use two spaces for YAML indentation
au FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2

" Detect .md extension as markdown filetype
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Jump to the last position when reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


"========== vim-airline ==========

" Use colorscheme nord
let g:airline_theme='nord'

" Enable tabline to show the tabs at the top of the window
let g:airline#extensions#tabline#enabled = 1


"========== NERDTree ==========

" Open/Close NERDTree
map <C-e> :NERDTreeToggle<CR>

" Change arrows to show expandable/collapsible elements
let g:NERDTreeDirArrowExpandable = "+"
let g:NERDTreeDirArrowCollapsible = "-"

" Not Show hidden files
let NERDTreeShowHidden = 0

" Close vim automatically if NERDTree is the last window/tab
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"========== vim-gitgutter ==========

" Faster updates (strange behavior)
"set updatetime=250


"========== vim-smooth-scroll ===========

noremap <silent> <C-k> :call smooth_scroll#up(&scroll, 15, 2)<CR>
noremap <silent> <C-j> :call smooth_scroll#down(&scroll, 15, 2)<CR>

"========== YouCompleteMe ===========

" Scroll without auto-insertion using Up/Down (intro to select)
" Scroll with auto-insertion using C-p/C-u (C-x to select)
let g:ycm_key_list_select_completion = ['']
let g:ycm_key_list_previous_completion = ['']
"To try
"let g:ycm_key_list_select_completion = ['<TAB>']
"let g:ycm_key_list_previous_completion = ['<S-TAB>']
"let g:ycm_key_list_stop_completion = ['<C-y>', '<UP>', '<DOWN>']
"let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>']

"========== Key Remaps ==========

" Move cursor in Insert mode
" (This will not work if YCM window is open)
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-h> <left>
inoremap <C-l> <right>

" Esc remap
" Ctrl-C does not trigger InsertLeave autocmd. We need to remap Ctrl-C to Esc
" to have the same behavior
inoremap <C-c> <Esc>

" tabs shortcuts
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap te  :tabedit<Space>
nnoremap tx :tabclose<CR>

" Insert curly brackets automatically
inoremap {<cr> {<cr>}<c-o><s-o>

" Disable arrow keys
"nnoremap <Left> :echoe "Use h"<CR>
"nnoremap <Right> :echoe "Use l"<CR>
"nnoremap <Up> :echoe "Use k"<CR>
"nnoremap <Down> :echoe "Use j"<CR>
