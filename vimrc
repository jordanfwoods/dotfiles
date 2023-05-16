""""""""""""""""""""""""""""""""
"" Initial Random Settings " (syntax/plugins/font/colorscheme/arrows)
""""""""""""""""""""""""""""""""
set nocompatible " always use this feature to bring it to the 21st century...
syntax on        " enable syntax highlighting

call plug#begin('~/.vim/plugged')
  " Added Features / commands
  Plug 'tpope/vim-commentary'             " Make Block comments easier (gcc)
  Plug 'tpope/vim-surround'               " Surrounds text in quotes, {}, etc.
  Plug 'tpope/vim-repeat'                 " Allows better . repeating for plugins
  " Make new text objects
  Plug 'kana/vim-textobj-user'            " base text object creator
  " VIM Appearance
  Plug 'vim-airline/vim-airline'          " Creates a fancy status line.
  " Syntax Highlighting / Color Schemes
  Plug 'vhda/verilog_systemverilog.vim'   " SystemVerilog syntax file.
  Plug 'morhetz/gruvbox'                  " gruvbox is the goat of colorschemes.
  " Updated file manager...
  Plug 'preservim/nerdtree'               " Use a capable file manager.
call plug#end()

" Colorize the way I want
set background=dark " gruvbox requires external background to be set.
if  !empty(globpath(&rtp,'colors/gruvbox.vim')) | colo gruvbox | endif " scheme from Plugin
hi  Normal ctermbg=NONE

" Grab these other vim files I wrote.
if filereadable(expand("~/.vim/autoload/FancyIncDec.vim")) | source ~/.vim/autoload/FancyIncDec.vim | endif
if filereadable(expand("~/.vim/mine/functions.vim"))       | source ~/.vim/mine/functions.vim       | endif
if filereadable(expand("~/.vim/mine/autocommands.vim"))    | source ~/.vim/mine/autocommands.vim    | endif
if filereadable(expand("~/.vim/mine/airline.vim"))         | source ~/.vim/mine/airline.vim         | endif
if filereadable(expand("~/.vim/mine/textobj.vim"))         | source ~/.vim/mine/textobj.vim         | endif
if filereadable(expand("~/.vim/mine/graveyard.vim"))       | source ~/.vim/mine/graveyard.vim       | endif

" Disable the Arrow keys in Normal Mode
map <Up>    <nop>
map <Down>  <nop>
map <Left>  <nop>
map <Right> <nop>

""""""""""""""""""""""""""""""""
"" Basic Settings {{{1
""""""""""""""""""""""""""""""""
" What VIM saves
set nobackup           " do not keep a backup file, use versions instead
set history=250        " Number of lines of command line history to keep
scriptencoding utf-8   " Save vimrc to allow for special characters like √.
set encoding=utf-8     " Save vimrc to allow for special characters like √.
set fileencoding=utf-8 " Save vimrc to allow for special characters like √.

" How VIM Looks
set number          " show line numbers.
set relativenumber  " change to show number of lines from current line.
set ruler           " show the cursor position all the time in bottom right
set showcmd         " display incomplete commands in bottom right
set nowrap          " Don't wrap text to the next line.
set laststatus=2    " Display StatusLine always
set textwidth=0     " Set to not split text into multiple lines. (Used to be 84)
set colorcolumn=100 " Set Color Column just after columnn of textwidth
set splitbelow      " New Split Windows open below
set splitright      " New Vertical Splits open to the right

" Never use tabs and backspace more efficiently
set tabstop=2    " set the tabs to display as 2 whitespaces.
set shiftwidth=2 " on indenting with '>', use 2 spaces.
set expandtab    " inserts spaces for tabs.
set backspace=indent,eol,start " allow backspacing over anything in insert mode
set autoindent   " Turn on Auto Indent

 " Allow 'list' option to see EOL($), Tab(>-), Space(·), etc. Used with <F7>
set listchars=eol:$,tab:>-,trail:·,extends:>,precedes:<,conceal:&,nbsp:·

" Update the way searching occurs
set hlsearch   " Highlight all items that match search
set incsearch  " do incremental searching
set ignorecase " Search and replace is case insensitive
set smartcase  " If any letter is CAPS, then search is case sensitive

" Allow for 'Fuzzy Finding', i.e. searching your entire workspace for keyword
set path+=**       " Allows recursive searching through current directory.
set wildmenu       " Enables menu to pop up to help with finishing wordsearch
set wildmode=longest,list,full " Make autocomplete in command mode better

" Set timeouts for <Esc>, etc.
set timeout       " timeout on partial command like: <leader>, g, etc.
set tm=1000       " timeoutlen is 1 second
set ttimeout      " Have separate value for timeout re: leaving insert mode
set ttimeoutlen=0 " insert / visual timeout immediately

" Other general settings (vimdiff, folds, number formats, etc.)
set foldmethod=marker " allows for '{ { { 1' stuff
set diffopt+=iwhite   " Tell Vim to ignore whitespace
set nrformats=hex     " Get octal / alpha out of here.
set tags=tags;        " reverse recursive tag search?
set autochdir         " Jump around
" 1}}}
""""""""""""""""""""""""""""""""
"" Basic Remaps {{{1
""""""""""""""""""""""""""""""""
" Add single spaces in normal mode
nnoremap <Space>               i <Esc>l
" Make 'Y' operate like 'D', 'C', etc instead of 'yy'
nnoremap Y                     y$
" 1}}}
""""""""""""""""""""""""""""""""
"" Leader Remaps {{{1
""""""""""""""""""""""""""""""""
" Change the <leader> to be ",", not "\"
let mapleader = ","

" <leader> Remaps
" Increment using my custom function
nnoremap <leader><c-a>         :call FancyIncDec(1)<CR>
nnoremap <leader><c-x>         :call FancyIncDec(0)<CR>

" Date and Times and name over-writing
" Update the Date in MM/DD/YY format (DD Mon YYYY for <leader>D)
nnoremap <leader>d             R<C-R>=strftime("%m/%d/%y")<CR><Esc>
nnoremap <leader><leader>d     R<C-R>=strftime("%m/%d/%Y")<CR><Esc>
nnoremap <leader>D             R<C-R>=strftime("%a, %d %b %Y")<CR><Esc>
" Update the Time in H?H:MM [a|p]m format
nnoremap <leader>T             R<C-R>=strftime("%-I:%M %P")<CR><Esc>
" Update the Name of the last modified.
nnoremap <leader>J             RJordan Woods<Esc>l

" Searching
" Clear Search coloring
nnoremap <silent> <Leader><CR> :noh<CR>:echo "Clearing Search"<CR>
" Count the number of occurences of the current word
nnoremap <leader>?             :%s/\<<C-R><C-W>\>//gni<CR><C-O>
" Count the number of occurences of the last search
nnoremap <leader>/             :%s///gni<CR><C-O>
" Remove trailing whitespace on entire file (with confirms).
nnoremap <leader><Space>       :%s/\s\+$//gc<CR>

" Verilog / VHDL Templates
" Dump a VHDL Header template to the file
nnoremap <leader>vhd           :-1read ~/.vim/templates/header.vhd<CR>
" Dump a procedure template to the file
nnoremap <leader>ver           :-1read ~/.vim/templates/header.sv<CR>
" Automate adding mark_debug attributes to vhdl / verilog
nnoremap <leader>e             :call MarkDebug()<CR>
nnoremap <leader>E             Oattribute mark_debug : string;<ESC>
nnoremap <leader>m             :call UnmarkDebug()<CR>

" NerdTree + Making Chrome usable (it steals my ctrl-t, ctrl-w, etc)
" Open/Close Nerdtree.
nnoremap <leader>nn            :NERDTreeToggle<CR>
" Make chrome more usable....
nnoremap <leader>w             <C-w>
nnoremap <leader>t             :silent! pop<CR>

" Re-window
" resize current buffer by +/-N
nnoremap <leader>h             :<C-U>execute "vertical resize -" . v:count1<CR>
nnoremap <leader>j             :<C-U>execute          "resize +" . v:count1<CR>
nnoremap <leader>k             :<C-U>execute          "resize -" . v:count1<CR>
nnoremap <leader>l             :<C-U>execute "vertical resize +" . v:count1<CR>

"" Make My Own To-Do List...
" Auto setfiletype... syntax is in ~/.vim/synatx/todo_done.vim
nnoremap <leader>1             :call TodoFunc('1')<CR>
nnoremap <leader>2             :call TodoFunc('2')<CR>
nnoremap <leader>3             :call TodoFunc('3')<CR>
nnoremap <leader>4             :call TodoFunc('4')<CR>
nnoremap <leader>5             :call TodoFunc('5')<CR>
nnoremap <leader>6             :call TodoFunc('6')<CR>
" 1}}}
""""""""""""""""""""""""""""""""
"" F-Key Remaps {{{1
""""""""""""""""""""""""""""""""
" Don't use <F11>, or <F12>. <S-F11>, etc. is fine.
" Toggle paste mode for easy copy/pasting from system clipboard with the mouse
nnoremap <Leader><F12>         :set invnumber<CR>:set invrelativenumber<CR>:set invpaste<CR>
nnoremap <F4>                  :set invnumber<CR>

" Auto save and don't reload vimrc (good for most files.)
nnoremap <F10>                 :w<CR>
inoremap <F10>                 <Esc>:w<CR>
" Because I am incapable of hitting escape sometimes, and ':w' is uncommon...
inoremap :w                    <Esc>:w<CR>
" Auto save and reload vimrc (good for editing vimrc / colorscheme)
nnoremap <Leader><F10>         :w<CR>:source ~/.vimrc<CR>:noh<CR>:echo<CR>

" Increase / Decrease Tabstop for looking at foreign files.
nnoremap <F9>                  :set ts+=1<CR>:set sw+=1<CR>:set ts?<CR>
nnoremap <S-F9>                :set ts-=1<CR>:set sw-=1<CR>:set ts?<CR>

" Output Basic syntax Name, i.e. Comment, and the colors associated.
nnoremap <Leader><Leader><F8>  :verbose highlight <C-r>=synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")<CR><CR>
" Output Specific syntax name, i.e. vimLineComment, and the associated linking.
nnoremap <Leader><F8>          :verbose highlight <C-r>=synIDattr(synstack(line("."), col("."))[-1], "name")<CR><CR>
" Display list of color groups that character under cursor belongs to.
nnoremap <F8>                  :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>
"
" Toggle Tab/Endline Viewer
nnoremap <F7>                  <Esc>:set list!<CR>
" 1}}}
""""""""""""""""""""""""""""""""
"" COMMANDS {{{1
""""""""""""""""""""""""""""""""
" Edit the vimrc in new window
command! EditVimrc   sp ~/.vimrc
" HDL Specific
command! MakeFWTags  ! ctags --langmap=Verilog:+.sv -R --Verilog-kinds=-prn --exclude=@.ctagsignore --languages=vhdl,Verilog .
" Generic ctags call
command! MakeTags    ! ctags --langmap=Verilog:+.sv -R --Verilog-kinds=-prn --exclude=@.ctagsignore .
" 1}}}
""""""""""""""""""""""""""""""""
"" GVIM {{{1
""""""""""""""""""""""""""""""""
if has('gui_running')
  if has('gui_win32')
    set guifont=Consolas:h10:cANSI:qDRAFT " Preferred Font for gvim
  endif
  set guioptions=i " by default, hide gui menus

  " Toggle gvim Menu / Scrollbars See Function below
  nnoremap <F12>     <Esc>:call ToggleGUIOpts()<cr>
endif
" 1}}}
""""""""""""""""""""""""""""""""
