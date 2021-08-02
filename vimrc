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
  .". VIM Appearance
  Plug 'vim-airline/vim-airline'        " Creates a fancy status line.
  " Syntax Highlighting / Color Schemes
  Plug 'amal-khailtash/vim-xdc-syntax'  " XDC Syntax.
  Plug 'vhda/verilog_systemverilog.vim' " SystemVerilog syntax file.
  Plug 'morhetz/gruvbox'                " gruvbox is the goat of colorschemes.
  " Updated file system...
  Plug 'preservim/nerdtree'             " Use a capable file manager.
call plug#end()

set background=dark " gruvbox requires external background to be set.
colo gruvbox        " scheme from Plugin

" Disable the Arrow keys in Normal Mode
map <Up>    <nop>
map <Down>  <nop>
map <Left>  <nop>
map <Right> <nop>

""""""""""""""""""""""""""""""""
"" Basic Settings
""""""""""""""""""""""""""""""""
" What VIM saves
set nobackup       " do not keep a backup file, use versions instead
set history=250    " Number of lines of command line history to keep

" How VIM Looks
set number         " show line numbers.
set relativenumber " change to show number of lines from current line.
set ruler          " show the cursor position all the time in bottom right
set showcmd        " display incomplete commands in bottom right
set nowrap         " Don't wrap text to the next line.
set laststatus=2   " Display StatusLine always
set textwidth=80   " Set max width of inserted code to 80 lines before splitting
set colorcolumn=+1 " Set Color Column just after columnn of textwidth

" Never use tabs and backspace more efficiently
set tabstop=2      " set the tabs to display as 2 whitespaces.
set shiftwidth=2   " on indenting with '>', use 2 spaces.
set expandtab      " inserts spaces for tabs.
set backspace=indent,eol,start " allow backspacing over anything in insert mode

 " Allow 'list' option to see EOL($), Tab(>-), Space(·), nowrap(<>)
set listchars=eol:$,tab:>-,nbsp:·,extends:>,precedes:< " Used with <F7>

" Update the way searching occurs
set hlsearch       " Highlight all items that match search
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

""""""""""""""""""""""""""""""""
"" REMAPS
""""""""""""""""""""""""""""""""
"" :h keycodes for more info on <> nomenclature
" Change the <leader> to be ",", not "\"
let mapleader = ","

" Add single spaces in normal mode
nnoremap <Space>         i<Space><Right><ESC>
" Add a Tab while in Normal Mode
nnoremap <Leader><Tab>   i<Tab><Right><ESC>
" Remove a Tab while in Normal Mode
nnoremap <Leader><S-Tab> 3hdwi<Tab><Right><ESC>
" Make 'Y' operate like 'D', 'C', etc instead of 'yy'
nnoremap Y               y$

" Update the Date in MM/DD/YY format
nnoremap <leader>d       R<C-R>=strftime("%m/%d/%y")<CR><Esc>
nnoremap <leader>D       R<C-R>=strftime("%m/%d/%Y")<CR><Esc>
" Count the number of occurences of the last search
nnoremap <leader>/       :%s///gni<CR><C-O>
" Remove trailing whitespace on entire file (with confirms).
nnoremap <leader><Space> :%s/\s\+$//gc<CR>
" Dump a VHDL Header template to the file
nnoremap <leader>vhd     :-1read ~/.vim/templates/header.vhd<CR>
" Dump a procedure template to the file
nnoremap <leader>ver     :-1read ~/.vim/templates/header.sv<CR>

" Open/Close Nerdtree.
nnoremap <leader>nn :NERDTreeToggle<CR>
" Find location of current file.
nnoremap <leader>nf :NERDTreeFind<CR>

" Don't use <F11>, or <F12>. <S-F11>, etc. is fine.
" Toggle paste mode for easy copy/pasting from system clipboard with the mouse
nnoremap <S-F12> :set invnumber<CR>:set invrelativenumber<CR>:set invpaste<CR>
nnoremap <C-F12> :set invpaste<CR>
" Auto save and don't reload vimrc (good for most files.)
nnoremap <F10>   :w<CR>
" Auto save and reload vimrc (good for editing vimrc / colorscheme)
nnoremap <C-F10> :w<CR>:source ~/.vimrc<CR>
" Increase / Decrease Tabstop for looking at foreign files.
nnoremap <F9>    :set ts+=1<CR>:set ts?<CR>
nnoremap <S-F9>  :set ts-=1<CR>:set ts?<CR>

" Output Basic syntax Name, i.e. Comment, and the colors associated.
nnoremap <C-F8>  :verbose highlight
  \ <C-r>=synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")<CR><CR>
" Output Specific syntax name, i.e. vimLineComment, and the associated linking.
nnoremap <S-F8>  :verbose highlight
  \ <C-r>=synIDattr(synstack(line("."), col("."))[-1], "name")<CR><CR>
" Display list of color groups that character under cursor belongs to.
nnoremap <F8>    :echo
  \ map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>
" Toggle Tab/Endline Viewer
nnoremap <F7>    <Esc>:set list!<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""
"" AUTO COMMANDS
""""""""""""""""""""""""""""""""
" Prefer // style to /* stuff */ 
autocmd FileType verilog_systemverilog setlocal commentstring=//\ %s
" VHDL doesn't work for some reason
autocmd FileType vhdl setlocal commentstring=--\ %s

" Reliably prompt for file changes upon changing buffers.
au FocusGained,BufEnter     * :silent! checktime
au CursorHold,CursorHoldI   * :silent! checktime
" au CursorMoved,CursorMovedI * :silent! checktime
let v:fcs_choice="ask"

""""""""""""""""""""""""""""""""
"" COMMANDS
""""""""""""""""""""""""""""""""
" Edit the vimrc in new window
command! EditVimrc   sp ~/.vimrc
" " Make Tags for interfile autofill (from branch/csp-gse)
command! MakeTags ! ctags --langmap=Verilog:+.sv --languages=vhdl,Verilog
         \ -R --Verilog-kinds=-prn --exclude=proj --exclude=temp
         \ --exclude=_Archive ./
""""""""""""""""""""""""""""""""
"" FUNCTIONS
""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""
"" LEGACY / UNUSED
""""""""""""""""""""""""""""""""
" Other vim colorschemes in unused plugins
" colo atom-dark-256 " other interesting colorscheme
" colo onehalfdark  " other interesting Plugin theme
" if g:colors_name=="onehalfdark" " onehalfdark has a lame commenting scheme...
"   hi Comment guifg=#282c34 ctermfg=236
"   hi Comment guibg=#5c6370 ctermbg=241
"   hi Comment gui=italic    cterm=italic
" endif

" - Use :find <filename> to open some stuff

" I have become a VIM super user, and I don't need it... right?
" if has('mouse') | set mouse=a | endif

" SMI version of vim can't use [] ... " Wipe all registers
" command! WipeReg for i in range(34,122) |
"                \    silent! call setreg(nr2char(i),[]) |
"                \ endfor

" LEGACY - NETRW
" Don't use NETRW, use NERDTree
" let g:netrw_banner=0       " disable annoying banner
" let g:netrw_browse_split=4 " open in prior window
" let g:netrw_altv=1         " opens splits to the right
" let g:netrw_liststyle=3    " tree view
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

""""""""""""""""""""""""""""""""
"" GVIM
""""""""""""""""""""""""""""""""

set guifont=Consolas:h10:cANSI:qDRAFT " Preferred Font for gvim
set guioptions=i " by default, hide gui menus

" " Only for GVIM
" " Toggle gvim Menu / Scrollbars See <F11> above for shortcut
" function! ToggleGUICruft()
"   if &guioptions=='i'
"     exec('set guioptions=imTrL')
"   else
"     exec('set guioptions=i')
"   endif
" endfunction

" Toggle gvim Menu / Scrollbars See Function below
" nnoremap <F12>     <Esc>:call ToggleGUICruft()<cr>

" " save the location of the vim files on Personal Folder
" cmap <A-a> /home/jwoods/Documents/jwoods/Personal/vim/
" " save the location of svn
" cmap <A-s> /home/jwoods/Documents/svn/
" " save the location of vim files (colors, syntax, etc)
" cmap <A-d> /usr/share/vim/
" " save the location of vimfiles
" cmap <A-f> /home/jwoods/.vim/

" Comment these out until needed
" Plug 'junegunn/vim-easy-align'       " Align using ga...
" Plug 'dhruvasagar/vim-table-mode'    " create ascii tables <leader>tm.
" Plug 'tpope/vim-fugitive'            " Adds :Git command.
" VIM  Colorschemes
" Plug 'flazz/vim-colorschemes'        " All in one place...
" Plug 'sonph/onehalf', { 'rtp': 'vim' } " Other Interesting colorscheme.
" Plug 'gosukiwi/vim-atom-dark'        " Other Interesting colorscheme.
" Gutel Plugins to research
" Plug 'junegunn/fzf'                  " Fuzzy Finder for VIM fork from matze/vim-tex-fold add chapter, sub&subsub section support
" Plug 'gutelfuldead/vim-tex-fold'     " requires Okular and/or pdflatex, <leader>llp to open pdf preview
" Plug 'xuhdev/vim-latex-live-preview'
