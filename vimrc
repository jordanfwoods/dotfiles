""""""""""""""""""""""""""""""""
"" Initial Random Settings
"" (syntax/font/colorscheme/mouse/arrows)
""""""""""""""""""""""""""""""""

set nocompatible " always use this feature to bring it to the 21st century...
syntax on        " enable syntax highlighting

" Enable mouse if possible
if has('mouse')
  set mouse=a
endif

call plug#begin('~/.vim/plugged')
   " Time Pope - the patron saint of VIM
   Plug 'tpope/vim-commentary'           " #gcc Toggles comments on # lines
   Plug 'tpope/vim-fugitive'             " Adds :Git command
"  Plug 'tpope/vim-surround'             " Surrounds text in quotes, parens, etc
   Plug 'vim-airline/vim-airline'        " VIM-airline is the fancy status line.
   Plug 'morhetz/gruvbox'                " gruvbox is the goat of colorschemes.
   Plug 'vim-scripts/vim-xdc-syntax'     " xdc syntax file
   Plug 'vhda/verilog_systemverilog.vim' " SystemVerilog syntax file
   Plug 'preservim/nerdtree'             " Use a capable file manager
   " " Gutel Plugins to research
   " Plug 'junegunn/fzf'
   " Plug 'amal-khailtash/vim-xdc-syntax'
   " Plug 'gutelfuldead/vim-tex-fold'      " fork from matze/vim-tex-fold add chapter, sub&subsub section support
   " Plug 'xuhdev/vim-latex-live-preview'  " requires Okular and/or pdflatex, <leader>llp to open pdf preview
call plug#end()

set background=dark " gruvbox requires external background to be set.
colo gruvbox        " scheme from offline
"colo jordan        " Based on colo ron

" Disable the Arrow keys in Normal Mode
" NOTE: Use imap to update insert mode key bindings.
map <Up>    <nop>
map <down>  <nop>
map <left>  <nop>
map <right> <nop>

""""""""""""""""""""""""""""""""
"" Basic Settings
""""""""""""""""""""""""""""""""

" What VIM saves
set nobackup       " do not keep a backup file, use versions instead
set history=250    " keep 250 lines of command line history

" How VIM Looks
set ruler          " show the cursor position all the time in bottom right
set showcmd        " display incomplete commands in bottom right
set number         " show line numbers.
set relativenumber " change to show number of lines from current line.
set nowrap         " Don't wrap text to the next line.
set hlsearch       " Highlight all items that match search
set laststatus=2   " Display StatusLine always
set textwidth=80   " Set max width of inserted code to 80 lines before splitting
set colorcolumn=+1 " Set Color Column just after columnn of textwidth
set cursorline     " Lightly highlight current line.

" Never use tabs and backspace more efficiently
set tabstop=3      " set the tabs to display as three whitespaces.
set expandtab      " inserts spaces for tabs.
set shiftwidth=3   " on indenting with '>', use 3 spaces.
set backspace=indent,eol,start " allow backspacing over anything in insert mode
 " Allow 'list' option to see EOL($), Tab(>-), Space(·), nowrap(<>)
set listchars=eol:$,tab:>-,nbsp:·,extends:>,precedes:<

" Update the way searching occurs
set incsearch      " do incremental searching
set ignorecase     " Search and replace is case insensitive
set smartcase      " If any letter is CAPS, then search is case sensitive

" Allow for 'Fuzzy Finding', i.e. searching your entire workspace for keyword
set path+=**       " Allows recursive searching through current directory.
set wildmenu       " Enables menu to pop up to help with finishing wordsearch

" Experimental VIM Options...
set ai             " Turn on Auto Indent
set sb             " New Split Windows open below
set spr            " New Vertical Splits open to the right

" Allows recursive searching through all of WDL
set path+=./**

"" To Update Tags file, Guac into a linux comp, update svn, and run ctags!
set tags=./tags,./TAGS,tags,TAGS
" " Make Tags for interfile autofill (from branch/csp-gse)
command! MakeTags ! ctags --langmap=Verilog:+.sv --languages=vhdl,Verilog -R ./
         \ --languages=vhdl,Verilog -R ./

""""""""""""""""""""""""""""""""
"" REMAPS
""""""""""""""""""""""""""""""""

"" Basic Movement Remapping
"" :h keycodes for more info on <> nomenclature
" Add single spaces in normal mode
nnoremap <Space>   i<Space><Right><ESC>
" Add indentation where cursor is (internal indentation)
" execute  "set <S-Tab>=\e[Z"
" nnoremap <S-Tab> i<Tab><Right><ESC>
" execute  "set <C-Space>=^@"
" nnoremap <C-Space> i<Tab><Right><ESC>
" Make 'Y' operate like 'D', 'C', etc instead of 'yy'
nnoremap Y         y$
" Reverse Tab
" imap     <S-Tab>   <C-D>

"" Helpful reused operations
" Count the number of occurences of the last search
nnoremap ,*        :%s///gni<CR>``
" Remove trailing whitespace on entire file.
nnoremap ,<Space>  :%s/\s\+$//gc<CR>
" Dump a VHDL Header template to the file
nnoremap ,vhd      :-1read
         \ /home/jwoods/jwoods/personal/vim/header.vhd<CR>
" Dump a procedure template to the file
nnoremap ,ver      :-1read
         \ /home/jwoods/jwoods/personal/vim/header.sv<CR>

" Nerdtree mappings.
nnoremap ,nn       :NERDTreeToggle<CR>
nnoremap ,nf       :NERDTreeFind<CR>

" Auto save and reload vimrc (good for editing vimrc / colorscheme)
nnoremap <F10>     :w<CR>:SourceVimrc<CR>
" Reload the current file for any external changes.
nnoremap <F9>      :e<CR>
" Output Basic syntax Name, i.e. Comment, and the colors associated.
 \ <C-r>=synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")<CR><CR>
" Output Specific syntax name, i.e. vimLineComment, and the associated linking.
 \ <C-r>=synIDattr(synstack(line("."), col("."))[-1], "name")<CR><CR>
" Display list of color groups that character under cursor belongs to.
nnoremap <F6>      :call <SID>SynStack()<CR>
" Toggle Tab/Endline Viewer
nnoremap <F5>      <Esc>:set list!<CR>

""""""""""""""""""""""""""""""""
"" COMMANDS
""""""""""""""""""""""""""""""""

" source _vimrc
command! SourceVimrc source ~/.vimrc
" Edit the vimrc in new window
command! EditVimrc   sp ~/.vimrc
" Edit my color scheme
command! EditJordan  sp ~/.vim/colors/jordan.vim

" Function to determine what color group character under cursor belongs to.
function! <SID>SynStack()
   if !exists("*synstack")
      return
   endif
   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

""""""""""""""""""""""""""""""""
"" Helpful Commands to Remember
""""""""""""""""""""""""""""""""
" - Use :ls to see all files vim has opened
" - Use :b <filename_substring> to open previously opened file
" - Use :find <filename> to open some stuff

" - With two vertical buffers, call :windo diffthis for basic diff
" - :diffupdate after updating a file.
" - :diffoff(!) when done!

" :%!xxd<CR>         " View a file in hex format. (add -r to go back)

""""""""""""""""""""""""""""""""
"" LEGACY / UNUSED
""""""""""""""""""""""""""""""""
" highlight OverLength ctermbg=52 guibg=#592929
" match OverLength /\%81v.\+/

"" " Enables using ':make --compile' or ':make --scenario loopback', etc
"" set makeprg=perl\ -S\ MakePLD.pl

" " Wipe all registers
" command! WipeReg for i in range(34,122) |
"                \    silent! call setreg(nr2char(i),[]) |
"                \ endfor

" " Turn on/off FileChangedShell Autocommand
" function! ChangeThisBuffer()
"   "set an environment variable to current buffer name
"   let $aucfile = expand( "%" )
"   "add autocmd which only applies to this buffer which
"   "removes itself once it runs once
"   autocmd FileChangedShell $aucfile autocmd! FileChangedShell $aucfile
"   execute( 'silent !mycommand' )
" endfunc

" " Turn on/off FileChangedShell Autocommand
" nnoremap <S-F5>    :call ChangeThisBuffer()<CR>
" nnoremap <F5>      :exe "au! FileChangedShell " . expand("%")<CR>

" Don't use NETRW, use NERDTree
" let g:netrw_banner=0       " disable annoying banner
" let g:netrw_browse_split=4 " open in prior window
" let g:netrw_altv=1         " opens splits to the right
" let g:netrw_liststyle=3    " tree view
" " let g:netrw_list_hide=netrw_gitignore#Hide()
" " let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

""""""""""""""""""""""""""""""""
"" GVIM Options
""""""""""""""""""""""""""""""""

set guifont=Consolas:h10:cANSI:qDRAFT " Preferred Font for gvim
set guioptions=i " by default, hide gui menus

" Toggle gvim Menu / Scrollbars See <F11> above for shortcut
function! ToggleGUICruft()
  if &guioptions=='i'
    exec('set guioptions=imTrL')
  else
    exec('set guioptions=i')
  endif
endfunction

" Toggle gvim Menu / Scrollbars See Function below
nnoremap <F12>     <Esc>:call ToggleGUICruft()<cr>

" set hidden         " Hide the file when you open another one

" " save the location of the vim files on Personal Folder
" cmap <A-a> /home/jwoods/Documents/jwoods/Personal/vim/
" " save the location of svn
" cmap <A-s> /home/jwoods/Documents/svn/
" " save the location of vim files (colors, syntax, etc)
" cmap <A-d> /usr/share/vim/
" " save the location of vimfiles
" cmap <A-f> /home/jwoods/.vim/

