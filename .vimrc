" Setting some decent VIM settings for programming


set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set ruler                       " show the cursor position all the time
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set backspace=indent,eol,start  " make that backspace key work the way it should
set nocompatible                " vi compatible is LAME
set background=light             " Use colours that work well on a dark background (Console is usually black)
set showmode                    " show the current mode
set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows
syntax on                       " turn syntax highlighting on by default

" Show EOL type and last modified timestamp, right after the filename
set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P

"------------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    "Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,git-rebase-todo setlocal fileencodings=utf-8

    "Remember the positions in files with some git-specific exceptions"
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$")
      \           && expand("%") !~ "COMMIT_EDITMSG"
      \           && expand("%") !~ "ADD_EDIT.patch"
      \           && expand("%") !~ "addp-hunk-edit.diff"
      \           && expand("%") !~ "git-rebase-todo" |
      \   exe "normal g`\"" |
      \ endif

      autocmd BufNewFile,BufRead *.patch set filetype=diff
      autocmd BufNewFile,BufRead *.diff set filetype=diff

      autocmd Syntax diff
      \ highlight WhiteSpaceEOL ctermbg=red |
      \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/

      autocmd Syntax gitcommit setlocal textwidth=74
endif " has("autocmd")

" MY ADDITIONS ADDED TO THE GIT VIM
set nu
set tabstop=2
set shiftwidth=2
set expandtab

" MY ADDITIONS ADDED FOR VIMWIKI
filetype plugin on
syntax on

" PATHOGEN
execute pathogen#infect()

" NERDTree - Mapping a toggle of the pannel
nmap <F6> :NERDTreeToggle<CR>

" NERDTree - making it prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" HISTORY
set history=1000

" SHOW MENU WHEN USING TAB COMPLETION
set wildmenu

" SEARCH OPTIONS 
set hlsearch 
set incsearch 
set ignorecase
set smartcase

" READABLE LINE WRAPS
set lbr

" SET AUTO INDENT AND SMART INDENT
set ai
set si

" COLORS
" colorscheme morning

" To enable 256-color console Vim syntax
if !has("gui_running") 
  set term=xterm
  set t_Co=256
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm"
  colorscheme morning
endif

" ConEmu
if !empty($CONEMUBUILD)
    echom "Running in conemu"
    set termencoding=utf8
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    " termcap codes for cursor shape changes on entry and exit to
    " /from insert mode
    " doesn't work
    "let &t_ti="\e[1 q"
    "let &t_SI="\e[5 q"
    "let &t_EI="\e[1 q"
    "let &t_te="\e[0 q"
endif
