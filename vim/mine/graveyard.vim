""""""""""""""""""""""""""""""""
"" VIMRC Graveyard....
""""""""""""""""""""""""""""""""
" nnoremap <leader>W             <C-w><C-w>
" " Find location of current file.
" nnoremap <leader>nf            :NERDTreeFind<CR>
" " Insert filename (no path or suffix)
" nnoremap <leader>>             "=expand("%:t")<CR>pdF.x
" " Remove <> and paste in filename (without path)
" nnoremap <leader><             da<"=expand("%:t")<CR>P
" " Add a Tab while in Normal Mode
" nnoremap <Leader><Tab>         i<Tab><ESC>l
" " Remove a Tab while in Normal Mode
" nnoremap <Leader><S-Tab>       hhhdwi<Tab><ESC>l

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
