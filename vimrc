""""""""""""""""""""""""""""""""
"" Initial Random Settings
"" (syntax/plugins/font/colorscheme/arrows)
""""""""""""""""""""""""""""""""
set nocompatible " always use this feature to bring it to the 21st century...
syntax on        " enable syntax highlighting

call plug#begin('~/.vim/plugged')
  " Added Features / commands
  Plug 'tpope/vim-commentary'           " Make Block comments easier (gcc)
  Plug 'tpope/vim-surround'             " Surrounds text in quotes, {}, etc.
  Plug 'tpope/vim-repeat'               " Allows better . repeating for plugins
  " Make new text objects
  Plug 'kana/vim-textobj-user'          " base text object creator
  Plug 'kana/vim-textobj-diff'          " allows adh, idh for diff files.
  Plug 'Julian/vim-textobj-brace'       " allows aj, ij for closest [], {}, or ()
  Plug 'lucapette/vim-textobj-underscore' " allows for a_, i_
  " VIM Appearance
  Plug 'vim-airline/vim-airline'        " Creates a fancy status line.
  Plug 'vim-airline/vim-airline-themes' " Themes for said fancy status line.
  " Syntax Highlighting / Color Schemes
  Plug 'vhda/verilog_systemverilog.vim' " SystemVerilog syntax file.
  Plug 'morhetz/gruvbox'                " gruvbox is the goat of colorschemes.
  " Updated file manager...
  Plug 'preservim/nerdtree'             " Use a capable file manager.
call plug#end()

set  background=dark " gruvbox requires external background to be set.
colo gruvbox         " scheme from Plugin
hi   Normal ctermbg=NONE

source ~/.vim/autoload/verilogInc.vim
" Disable the Arrow keys in Normal Mode
map <Up>    <nop>
map <Down>  <nop>
map <Left>  <nop>
map <Right> <nop>

""""""""""""""""""""""""""""""""
"" Basic Settings
""""""""""""""""""""""""""""""""
" What VIM saves
set nobackup           " do not keep a backup file, use versions instead
set history=250        " Number of lines of command line history to keep
" scriptencoding utf-8   " Save vimrc to allow for special characters like √.
" set encoding=utf-8     " Save vimrc to allow for special characters like √.
" set fileencoding=utf-8 " Save vimrc to allow for special characters like √.

" How VIM Looks
set number         " show line numbers.
set relativenumber " change to show number of lines from current line.
set ruler          " show the cursor position all the time in bottom right
set showcmd        " display incomplete commands in bottom right
set nowrap         " Don't wrap text to the next line.
set laststatus=2   " Display StatusLine always
set textwidth=0    " Set to not split text into multiple lines. (Used to be 84)
set colorcolumn=85 " Set Color Column just after columnn of textwidth

" Never use tabs and backspace more efficiently
set tabstop=2      " set the tabs to display as 2 whitespaces.
set shiftwidth=2   " on indenting with '>', use 2 spaces.
set expandtab      " inserts spaces for tabs.
set backspace=indent,eol,start " allow backspacing over anything in insert mode

 " Allow 'list' option to see EOL($), Tab(>-), Space(·), etc. Used with <F7>
set listchars=eol:$,tab:>-,trail:·,extends:>,precedes:<,conceal:&,nbsp:·

" Update the way searching occurs
set hlsearch       " Highlight all items that match search
set incsearch      " do incremental searching
set ignorecase     " Search and replace is case insensitive
set smartcase      " If any letter is CAPS, then search is case sensitive

" Allow for 'Fuzzy Finding', i.e. searching your entire workspace for keyword
set path+=**       " Allows recursive searching through current directory.
set wildmenu       " Enables menu to pop up to help with finishing wordsearch

" Experimental VIM Options...
set autoindent     " Turn on Auto Indent
set splitbelow     " New Split Windows open below
set splitright     " New Vertical Splits open to the right
set nrformats=hex  " Get octal / alpha out of here.
set timeout        " timeout on partial command like: <leader>, g, etc.
set tm=1000        " timeoutlen is 1 second
set ttimeout       " Have separate value for timeout re: leaving insert mode
set ttimeoutlen=0  " insert / visual timeout immediately
set fdm=marker     " foldmethod: allows for '{ { { 1' stuff
set wildmode=longest,list,full " Make autocomplete in command mode better
set diffopt+=iwhite " Tell Vim to ignore whitespace

""""""""""""""""""""""""""""""""
"" REMAPS
"" :h keycodes for more info on <> nomenclature
""""""""""""""""""""""""""""""""
" Change the <leader> to be ",", not "\"
let mapleader = ","

nnoremap <leader><c-a> :call FancyInc()<CR>
" " Random Remaps
" " Remap <C-A> to increment systemverilog correctly...
" nnoremap <expr> <silent> <c-a> expand('<cWORD>') =~# '\v\c\d+''h[0-9a-f]+' ?
"       \ ":<c-u>norm! \"_yiWf'ls0x<c-v><esc>" . v:count1 . "<c-v><c-a>F'lvlpE<cr>" : '<c-a>'
" " Remap <C-A> to decrement systemverilog correctly...
" nnoremap <expr> <silent> <c-x> expand('<cWORD>') =~# '\v\c\d+''h[0-9a-f]+' ?
"       \ ":<c-u>norm! \"_yiWf'ls0x<c-v><esc>" . v:count1 . "<c-v><c-x>F'lvlpE<cr>" : '<c-x>'

" Add single spaces in normal mode
nnoremap <Space>               i <Esc>l
" Make 'Y' operate like 'D', 'C', etc instead of 'yy'
nnoremap Y                     y$
" Clear Search coloring
nnoremap <silent> <Leader><CR> :noh<CR>:echo "Clearing Search"<CR>

" <leader> Remaps
" Add a Tab while in Normal Mode
nnoremap <Leader><Tab>         i<Tab><ESC>l
" Remove a Tab while in Normal Mode
nnoremap <Leader><S-Tab>       hhhdwi<Tab><ESC>l
" Update the Date in MM/DD/YY format (DD Mon YYYY for <leader>D)
nnoremap <leader>d             R<C-R>=strftime("%m/%d/%y")<CR><Esc>
nnoremap <leader>D             R<C-R>=strftime("%a, %d %b %Y")<CR><Esc>
nnoremap <leader><leader>d     R<C-R>=strftime("%m/%d/%Y")<CR><Esc>
" Update the Time in H?H:MM [a|p]m format
nnoremap <leader>T             R<C-R>=strftime("%-I:%M %P")<CR><Esc>
" Update the Name of the last modified.
nnoremap <leader>J             RJordan Woods<Esc>l
" Insert filename (no path or suffix)
nnoremap <leader>>             "=expand("%:t")<CR>pdF.x
" Remove <> and paste in filename (without path)
nnoremap <leader><             da<"=expand("%:t")<CR>P
" Count the number of occurences of the current word
nnoremap <leader>?             :%s/\<<C-R><C-W>\>//gni<CR><C-O>
" Count the number of occurences of the last search
nnoremap <leader>/             :%s///gni<CR><C-O>
" Remove trailing whitespace on entire file (with confirms).
nnoremap <leader><Space>       :%s/\s\+$//gc<CR>
" Dump a VHDL Header template to the file
nnoremap <leader>vhd           :-1read ~/.vim/templates/header.vhd<CR>
" Dump a procedure template to the file
nnoremap <leader>ver           :-1read ~/.vim/templates/header.sv<CR>
" Open/Close Nerdtree.
nnoremap <leader>nn            :NERDTreeToggle<CR>
" Find location of current file.
nnoremap <leader>nf            :NERDTreeFind<CR>
" Make chrome more usable....
nnoremap <leader>w             <C-w>
nnoremap <leader>W             <C-w><C-w>
nnoremap <leader>t             <C-t>

" F-Keys - Don't use <F11>, or <F12>. <S-F11>, etc. is fine.
" Toggle paste mode for easy copy/pasting from system clipboard with the mouse
nnoremap <Leader><F12> :set invnumber<CR>:set invrelativenumber<CR>:set invpaste<CR>
" Auto save and don't reload vimrc (good for most files.)
nnoremap <F10>         :w<CR>
inoremap <F10>         <Esc>:w<CR>
" Because I am incapable of hitting escape sometimes, and ':w' is uncommon...
inoremap :w            <Esc>:w<CR>
" Auto save and reload vimrc (good for editing vimrc / colorscheme)
nnoremap <Leader><F10> :w<CR>:source ~/.vimrc<CR>:noh<CR>:echo<CR>
" Increase / Decrease Tabstop for looking at foreign files.
nnoremap <F9>          :set ts+=1<CR>:set sw+=1<CR>:set ts?<CR>
nnoremap <S-F9>        :set ts-=1<CR>:set sw-=1<CR>:set ts?<CR>

" Output Basic syntax Name, i.e. Comment, and the colors associated.
nnoremap <Leader><Leader><F8> :verbose highlight
\ <C-r>=synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")<CR><CR>
" Output Specific syntax name, i.e. vimLineComment, and the associated linking.
nnoremap <Leader><F8>         :verbose highlight
\ <C-r>=synIDattr(synstack(line("."), col("."))[-1], "name")<CR><CR>
" Display list of color groups that character under cursor belongs to.
nnoremap <F8>                 :echo
\ map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>
" Toggle Tab/Endline Viewer
nnoremap <F7>    <Esc>:set list!<CR>

" resize current buffer by +/- 5
nnoremap <leader>h :<C-U>execute "vertical resize -" . v:count1<CR>
nnoremap <leader>j :<C-U>execute          "resize +" . v:count1<CR>
nnoremap <leader>k :<C-U>execute          "resize -" . v:count1<CR>
nnoremap <leader>l :<C-U>execute "vertical resize +" . v:count1<CR>

""""""""""""""""""""""""""""""""
"" Make My Own To-Do List...
""""""""""""""""""""""""""""""""
" Auto setfiletype... syntax is in ~/.vim/synatx/todo_done.vim
autocmd BufRead,BufNewFile *.done,TODO,todo,*.todo setlocal filetype=todo_done
nnoremap <leader>1 :call TodoFunc('1')<CR>
nnoremap <leader>2 :call TodoFunc('2')<CR>
nnoremap <leader>3 :call TodoFunc('3')<CR>
nnoremap <leader>4 :call TodoFunc('4')<CR>
nnoremap <leader>5 :call TodoFunc('5')<CR>

""""""""""""""""""""""""""""""""
"" AUTO COMMANDS
""""""""""""""""""""""""""""""""
" VIM Commentary doesn't have my filetype defaults the way I like.
autocmd FileType verilog_systemverilog setlocal commentstring=//\ %s
autocmd FileType c                     setlocal commentstring=//\ %s
autocmd FileType cpp                   setlocal commentstring=//\ %s
autocmd FileType vhdl                  setlocal commentstring=--\ %s
autocmd FileType xdc                   setlocal commentstring=#\ %s
autocmd FileType matlab                setlocal commentstring=%\ %s
autocmd FileType todo_done             setlocal commentstring=#\ %s

" Reliably prompt for file changes upon changing buffers.
au FocusGained,BufEnter     * :silent! checktime
au CursorHold,CursorHoldI   * :silent! checktime
let v:fcs_choice="ask"

""""""""""""""""""""""""""""""""
"" AIR-LINE (STATUS LINE)
""""""""""""""""""""""""""""""""
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline_detect_modified=1
if !exists('g:airline_symbols') | let g:airline_symbols = {} | endif
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_skip_empty_sections = 1
let g:airline_symbols.maxlinenr = '≡ '
let g:airline_symbols.linenr = ' № '
let g:airline_symbols.colnr = '℅:'

""""""""""""""""""""""""""""""""
"" COMMANDS
""""""""""""""""""""""""""""""""
" Edit the vimrc in new window
command! EditVimrc   sp ~/.vimrc
" HDL Specific
command! MakeFWTags ! ctags --langmap=Verilog:+.sv --languages=vhdl,Verilog
         \ -R --Verilog-kinds=-prn --exclude=@.ctagsignore .
" Generic ctags call
command! MakeTags ! ctags --langmap=Verilog:+.sv -R --Verilog-kinds=-prn
         \ --exclude=@.ctagsignore .

""""""""""""""""""""""""""""""""
"" OTHER FUNCTIONS
""""""""""""""""""""""""""""""""

"" To-do Function " manage check boxes
function! TodoFunc(...)
  execute "normal! ^"
  if getline(".")[col(".")-1] != "[" | execute "normal! f[" | endif
  if getline(".")[col(".")-1] == "["
    if     a:1 == "1" | execute "normal! lr√:noh<CR>f]j"
    elseif a:1 == "2" | execute "normal! lrI:noh<CR>f]j"
    elseif a:1 == "3" | execute "normal! lrX:noh<CR>f]j"
    elseif a:1 == "4" | execute "normal! lr :noh<CR>f]j"
    endif
  endif
  if a:1 == "5" | execute "normal! ^i[ ] " | endif
  +1
endfunction

"" Vim Diff Stuff
" Allows to see diff in current file before saving with :diffSaved
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! Diff call s:DiffWithSaved()

" Allows to see diff between current file and svn
function! s:DiffWithSVNCheckedOut()
  let filetype=&ft
  diffthis
  vnew | exe "%!svn cat " . fnameescape( expand("#:p") )
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! SvnDiff call s:DiffWithSVNCheckedOut()

function! s:DiffWithGITCheckedOut()
  let filetype=&ft
  diffthis
  vnew | exe "%!git diff " . fnameescape( expand("#:p") ) . " | patch -p 1 -Rs -o -"
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  diffthis
endfunction
com! GitDiff call s:DiffWithGITCheckedOut()

""""""""""""""""""""""""""""""""
"" GVIM
""""""""""""""""""""""""""""""""
if has('gui_running')
  set guifont=Consolas:h10:cANSI:qDRAFT " Preferred Font for gvim
  set guioptions=i " by default, hide gui menus

  " Only for GVIM
  " Toggle gvim Menu / Scrollbars See <F12> above for shortcut
  function! ToggleGUICruft()
    if &guioptions=='i'
      exec('set guioptions=imTrL')
    else
      exec('set guioptions=i')
    endif
  endfunction
  " Toggle gvim Menu / Scrollbars See Function below
  nnoremap <F12>     <Esc>:call ToggleGUICruft()<cr>
endif

""""""""""""""""""""""""""""""""
"" VIMRC Graveyard.... {{{1
""""""""""""""""""""""""""""""""
" - Use :find <filename> to open some stuff

" I have become a VIM super user, and I don't need it... right?
" if has('mouse') | set mouse=a | endif

" " SMI version of vim can't use [] ... Wipe all registers
" command! WipeReg for i in range(34,122) |
"                \    silent! call setreg(nr2char(i),[]) |
"                \ endfor

" " Spell-check (underline misspelled words in md,rst files)
" hi clear SpellBad
" hi SpellBad cterm=underline
" set spellfile=$HOME/.spellen.utf-8.add
" set spell
" " autocmd BufRead,BufNewFile *.md setlocal spell
" " autocmd BufRead,BufNewFile *.rst setlocal spell
" " autocmd BufRead,BufNewFile *.tex setlocal spell
" map <leader>sn ]s
" map <leader>sp [s
" map <leader>sa zg
" map <leader>s? z=

" LEGACY - NETRW
" Don't use NETRW, use NERDTree
" let g:netrw_banner=0       " disable annoying banner
" let g:netrw_browse_split=4 " open in prior window
" let g:netrw_altv=1         " opens splits to the right
" let g:netrw_liststyle=3    " tree view
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

""""""""""""""""""""""""""""""""
"" Unused Plugins To Remember
""""""""""""""""""""""""""""""""
" " Start interactive EasyAlign in visual mode (e.g. vipga)
" xmap ga <Plug>(EasyAlign)
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ga <Plug>(EasyAlign)

" Comment these out until needed
" Plug 'junegunn/vim-easy-align'       " Align using ga...
" Plug 'dhruvasagar/vim-table-mode'    " create ascii tables <leader>tm.
" Plug 'tpope/vim-fugitive'            " Adds :Git command.
" Plug 'tpope/vim-speeddating'          " Allows for incrementing dates...
" VIM  Colorschemes
" Plug 'flazz/vim-colorschemes'        " All in one place...
" Plug 'sonph/onehalf', { 'rtp': 'vim' } " Other Interesting colorscheme.
" Plug 'gosukiwi/vim-atom-dark'        " Other Interesting colorscheme.
" Gutel Plugins to research
" Plug 'junegunn/fzf'                  " Fuzzy Finder for VIM fork from matze/vim-tex-fold add chapter, sub&subsub section support
" Plug 'gutelfuldead/vim-tex-fold'     " requires Okular and/or pdflatex, <leader>llp to open pdf preview
" Plug 'xuhdev/vim-latex-live-preview'
" Plug 'vimwiki/vimwiki'               " todo list manager?
" Plug 'amal-khailtash/vim-xdc-syntax'  " XDC Syntax.
" 1}}}
""""""""""""""""""""""""""""""""
