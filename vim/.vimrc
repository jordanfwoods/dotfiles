""""""""""""""""""""""""""""""""
"" Initial Random Settings " (syntax/plugins/font/colorscheme/arrows)
""""""""""""""""""""""""""""""""
set nocompatible " always use this feature to bring it to the 21st century
syntax on        " enable syntax highlighting

if has('win32') | let g:vim = "$HOME/vimfiles/"
else            | let g:vim = $HOME . "/.vim/" | endif

if !empty(glob(g:vim."autoload/plug.vim"))
call plug#begin(g:vim.'plugged')
  " Tim Pope is the Patron Saint of VIM
  Plug 'tpope/vim-commentary'           " Make Block comments easier (gcc)
  Plug 'tpope/vim-surround'             " Surrounds text in quotes, {}, etc
  Plug 'tpope/vim-repeat'               " Allows better . repeating for plugins
  Plug 'tpope/vim-speeddating'          " Make time / date incrementing better.
  " Make new text objects
  Plug 'kana/vim-textobj-user'          " base text object creator
  " VIM Appearance
  Plug 'vim-airline/vim-airline'        " Creates a fancy status line
  " Syntax Highlighting / Color Schemes
  Plug 'vhda/verilog_systemverilog.vim' " SystemVerilog syntax file
  Plug 'morhetz/gruvbox'                " gruvbox is the goat of colorschemes
  " Updated file manager
  Plug 'preservim/nerdtree'             " Use a capable file manager
call plug#end()
endif

" Colorize the way I want
set background=dark " gruvbox requires external background to be set
if  !empty(globpath(&rtp,'colors/jordan.vim'))   | colo jordan  | endif " scheme from Plugin
if  !empty(globpath(&rtp,'colors/gruvbox.vim'))  | colo gruvbox  | endif " scheme from Plugin
if has('win32') | hi Normal ctermbg=NONE | endif
if &t_Co!=256 | set t_Co=256 | endif

""""""""""""""""""""""""""""""""
"" Basic Settings {{{1
""""""""""""""""""""""""""""""""
" What VIM saves
set nobackup           " do not keep a backup file, use versions instead
set history=250        " Number of lines of command line history to keep
scriptencoding utf-8   " Save vimrc to allow for special characters
set encoding=utf-8     " Save vimrc to allow for special characters
set fileencoding=utf-8 " Save vimrc to allow for special characters

" How VIM Looks
set number          " show line numbers
set relativenumber  " change to show number of lines from current line
set ruler           " show the cursor position all the time in bottom right
set showcmd         " display incomplete commands in bottom right
set nowrap          " Don't wrap text to the next line
set laststatus=2    " Display StatusLine always
set textwidth=0     " Set to not split text into multiple lines. (Used to be 84)
" set colorcolumn=100 " Set Color Column just after columnn of textwidth
set splitbelow      " New Split Windows open below
set splitright      " New Vertical Splits open to the right

" Never use tabs and backspace more efficiently
set tabstop=3    " set the tabs to display as 2 whitespaces
set shiftwidth=3 " on indenting with '>', use 2 spaces
set expandtab    " inserts spaces for tabs
set backspace=indent,eol,start " allow backspacing over anything in insert mode
set autoindent   " Turn on Auto Indent

" Allow 'list' option to see EOL($), Tab(>-), Space( ), etc. Used with <F7>
set listchars=eol:$,tab:>-,extends:>,precedes:<,conceal:&
if v:version > 899
   set listchars=eol:$,tab:>-,space:·,trail:·,extends:>,precedes:<,conceal:&
endif

" Update the way searching occurs
set hlsearch   " Highlight all items that match search
set incsearch  " do incremental searching
set ignorecase " Search and replace is case insensitive
set smartcase  " If any letter is CAPS, then search is case sensitive

" Allow for 'Fuzzy Finding', i.e. searching your entire workspace for keyword
set path+=**       " Allows recursive searching through current directory
set wildmenu       " Enables menu to pop up to help with finishing wordsearch
set wildmode=longest,list,full " Make autocomplete in command mode better

" Set timeouts for <Esc>, etc
set timeout       " timeout on partial command like: <leader>, g, etc
set timeoutlen=999 " timeoutlen is 1 second
set ttimeout      " Have separate value for timeout re: leaving insert mode
set ttimeoutlen=0 " insert / visual timeout immediately

" Other general settings (vimdiff, folds, number formats, etc.)
set diffopt+=iwhite   " Tell Vim to ignore whitespace
set nrformats=hex     " Get octal / alpha out of here
set tags=tags;        " reverse recursive tag search?
" set noautochdir     " Don't Jump around
" 1}}}
""""""""""""""""""""""""""""""""
"" Basic Remaps {{{1
""""""""""""""""""""""""""""""""
" Add single spaces in normal mode
nnoremap <Space>               i <Esc>l
" Make 'Y' operate like 'D', 'C', etc instead of 'yy'
nnoremap Y                     y$
" Disable the Arrow keys in Normal Mode
map <Up>    <nop>
map <Down>  <nop>
map <Left>  <nop>
map <Right> <nop>

" 1}}}
""""""""""""""""""""""""""""""""
"" Leader Remaps {{{1
""""""""""""""""""""""""""""""""
" Change the <leader> to be ",", not "\"
let mapleader = ","
nnoremap <leader><leader> ,

" Increment using my custom function
nnoremap <leader><c-a>         :call FancyIncDec(1)<CR>
nnoremap <leader><c-x>         :call FancyIncDec(0)<CR>

" Date and Times and name over-writing
" Update the Date in MM/DD/YY format (DD Mon YYYY for <leader>D)
nnoremap <leader>d             R<C-R>=strftime("%m/%d/%y")<CR><Esc>
nnoremap <leader>D             R<C-R>=strftime("%a, %d %b %Y")<CR><Esc>
nnoremap <leader><C-d>         R<C-R>=strftime("%m/%d/%Y")<CR><Esc>
" Update the Time in H?H:MM [a|p]m format
nnoremap <leader>T             R<C-R>=strftime("%-I:%M %P")<CR><Esc>
" Replace with Week Number of the Year
nnoremap <leader>W             Rww<C-R>=strftime("%y%W.%w")<CR><Esc>
" Update the Name of the last modified
nnoremap <leader>J             RJordan Woods<Esc>l
" Insert filename root (no path, no extension)
nnoremap <leader>f             R<C-R>=expand("%:r")<CR><Esc>l
nnoremap <leader>F             R<C-R>=expand("%:t")<CR><Esc>l
" Renumber a list starting at current line (looking at one line above)
nnoremap <silent> <leader>n    :call ReNumberList()<CR>
" Make New Scratch Buffer
nnoremap <leader>s             :call ScratchBuffer()<CR>
" Modify the font
if !exists('g:fontsize') | let g:fontsize = 14 | endif
nnoremap          <leader>S    :call FontChange( 1)<CR>:echo g:fontsize<CR>
nnoremap         <leader><c-s> :call FontChange(-1)<CR>:echo g:fontsize<CR>

" Searching
" Clear Search coloring
nnoremap <silent> <leader><CR> :nohlsearch<CR>
" Count the number of occurences of the current word
nnoremap <leader>?             :%s/\<<C-R><C-W>\>//gn<CR><C-O>
" Count the number of occurences of the last search
nnoremap <leader>/             :%s///gn<CR><C-O>
" Remove trailing whitespace on entire file (with confirms)
nnoremap <leader><Space>       :%s/\s\+$//gc<CR>
" Search for conflicts
nnoremap <leader>[             :%s/^[<=>]\{7}//gni<CR><C-O>

" Verilog / VHDL Templates
" Dump a VHDL Header template to the file
nnoremap <leader>vhd           :call VHDLExamples()<CR>
" Dump a procedure template to the file
nnoremap <leader>ver           :-1read ~/.vim/templates/header.sv<CR>
" Automate adding mark_debug attributes to vhdl / verilog
nnoremap <leader>m             :call MarkDebug()<CR>
nnoremap <leader>M             :call UnmarkDebug()<CR>
" nnoremap <leader><C-M>         Oattribute mark_debug : string;<ESC>

" NerdTree + Making Chrome usable (it steals my ctrl-t, ctrl-w, etc)
" Open/Close Nerdtree
nnoremap <leader>N             :NERDTreeToggle<CR>

" Re-window
" resize current buffer by +/-N
nnoremap <leader>h             :<C-U>execute "vertical resize -" . v:count1<CR>
nnoremap <leader>j             :<C-U>execute          "resize +" . v:count1<CR>
nnoremap <leader>k             :<C-U>execute          "resize -" . v:count1<CR>
nnoremap <leader>l             :<C-U>execute "vertical resize +" . v:count1<CR>

" Turn Off airline warnings
nnoremap <leader>A             :AirlineToggleWhitespace<CR>

"" Make My Own To-Do List
" Auto setfiletype... syntax is in .vim/syntax/todo_done.vim
nnoremap <silent> <leader>q    :call TodoFunc()<CR>
vnoremap <silent> <leader>q    :call TodoFunc()<CR>
nnoremap <leader>Q :echo   "TodoFold: "   . TodoFold(line(".")) .
                       \ ", line fold level: " . foldlevel(line(".")) .
                       \ ", currently folding at: " . v:foldlevel<CR>

" 1}}}
""""""""""""""""""""""""""""""""
"" F-Key Remaps {{{1
""""""""""""""""""""""""""""""""
" Don't use <F11>, or <F12>. <S-F11>, etc. is fine
" Toggle paste mode for easy copy/pasting from system clipboard with the mouse
nnoremap <leader><F12>         :set invnumber<CR>:set invrelativenumber<CR>:set invpaste<CR>
nnoremap <F2>                  :hi Normal ctermbg=None<CR>
nnoremap <F4>                  :set invnumber<CR>

" Auto save and don't reload vimrc (good for most files.)
nnoremap <F5>                 :w<CR>
inoremap <F5>                 <Esc>:w<CR>
" Because I am incapable of hitting escape sometimes, and ':w' is uncommon
inoremap :w                   <Esc>:w<CR>
" Auto save and reload vimrc (good for editing vimrc / colorscheme)
if has('win32') | nnoremap <silent><leader><F5> :w<CR>:exec "source " . g:vim . "vimrc"<CR>:noh<CR>
else            | nnoremap <silent><leader><F5> :w<CR>:exec "source ~/.vimrc"<CR>:noh<CR>
endif

" Increase / Decrease Tabstop for looking at foreign files
nnoremap <F9>                  :set ts+=1<CR>:set sw+=1<CR>:set ts?<CR>
nnoremap <S-F9>                :set ts-=1<CR>:set sw-=1<CR>:set ts?<CR>

" Output Basic syntax Name, i.e. Comment, and the colors associated
nnoremap <leader><S-F8>        :verbose highlight <C-r>=synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")<CR><CR>
" Output Specific syntax name, i.e. vimLineComment, and the associated linking
nnoremap <leader><F8>          :verbose highlight <C-r>=synIDattr(synstack(line("."), col("."))[-1], "name")<CR><CR>
" Display list of color groups that character under cursor belongs to
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
" command! MakeFWTags ! ctags --langmap=Verilog:+.sv -R --Verilog-kinds=-prn --exclude=@.ctagsignore --languages=vhdl,Verilog .
command! MakeFWTags ! ctags --langmap=Verilog:+.svh --langmap=Verilog:+.sv -R --Verilog-kinds=-prn --languages=vhdl,Verilog $ES_PROJECT/hdl $ES_PROJECT/sub/*/hdl $ES_PROJECT/sub/*/sub/*/hdl
" Generic ctags call
" command! MakeTags    ! ctags --langmap=Verilog:+.sv -R --Verilog-kinds=-prn --exclude=@.ctagsignore .
" 1}}}
""""""""""""""""""""""""""""""""
"" GVIM and MAC {{{1
""""""""""""""""""""""""""""""""
" GVIM
if has('gui_running')
  " set guifont=Consolas\ NF\ 10 " Since I select the font
  execute "set guifont=Consolas_NF:h" . g:fontsize . ":cANSI:qDRAFT"
  " set guifont=Consolas:h11:cANSI:qDRAFT " Preferred Font for gvim
  set guioptions=i " by default, hide gui menus

  " Toggle gvim Menu / Scrollbars See Function below
  nnoremap <F12>     <Esc>:call ToggleGUIOpts()<cr>
  set nobackup
  set nowritebackup
endif

" MAC
" assume we don't want the mouse, but the mac wants you to have it
set mouse=""
if has('macunix')
  if has('mouse') | set mouse=a | endif
endif

if has('win32')
   set belloff=all       " Turn off audio notifications
   nnoremap <silent><leader><F5> :exec "source " . g:vim . "/vimrc"<CR>:noh<CR>
   nnoremap <leader>vhd   :call VHDLExamples()<CR>
   nnoremap <leader>ver   :-1read ~\vimfiles\templates\header.sv<CR>
   nnoremap <leader>T     R<C-R>=strftime("%#I:%M %p")<CR><Esc>
endif
" 1}}}
""""""""""""""""""""""""""""""""
"" Other Vimfiles {{{1
""""""""""""""""""""""""""""""""
" Grab these other vim files I wrote
if filereadable(expand(g:vim."/autoload/FancyIncDec.vim")) | exec "source ".g:vim."/autoload/FancyIncDec.vim" | endif
"if filereadable(expand(g:vim."/mine/functions.vim"))       | exec "source ".g:vim."/mine/functions.vim"       | endif
if filereadable(expand(g:vim."/mine/autocommands.vim"))    | exec "source ".g:vim."/mine/autocommands.vim"    | endif
if filereadable(expand(g:vim."/mine/airline.vim"))         | exec "source ".g:vim."/mine/airline.vim"         | endif
if filereadable(expand(g:vim."/mine/textobj.vim"))         | exec "source ".g:vim."/mine/textobj.vim"         | endif
if filereadable(expand(g:vim."/mine/graveyard.vim"))       | exec "source ".g:vim."/mine/graveyard.vim"       | endif
" 1}}}
""""""""""""""""""""""""""""""""
