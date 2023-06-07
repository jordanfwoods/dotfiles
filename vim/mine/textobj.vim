if exists("*textobj#user#plugin")
  """"""""""""""""""""""""""""""""
  "" allows for da-, ci-, etc.
  """"""""""""""""""""""""""""""""
  if !exists('g:loaded_textobj_dash')
    call textobj#user#plugin('dash', {
    \      '-': {
    \        '*sfile*': expand('<sfile>:p'),
    \        'select-a': 'a-',  '*select-a-function*': 's:dash_a',
    \        'select-i': 'i-',  '*select-i-function*': 's:dash_i'
    \      }
    \    })

    function! s:dash_a()
      normal! F-
      let end_pos = getpos('.')

      normal! f-
      let start_pos = getpos('.')

      return ['v', start_pos, end_pos]
    endfunction

    function! s:dash_i()
      normal! T-
      let end_pos = getpos('.')

      normal! t-
      let start_pos = getpos('.')

      return ['v', start_pos, end_pos]
    endfunction

    let g:loaded_textobj_dash = 1
  endif

  """"""""""""""""""""""""""""""""
  "" allows for da/, ci/, etc.
  """"""""""""""""""""""""""""""""
  if !exists('g:loaded_textobj_slash')
    call textobj#user#plugin('slash', {
    \      '-': {
    \        '*sfile*': expand('<sfile>:p'),
    \        'select-a': 'a/',  '*select-a-function*': 's:slash_a',
    \        'select-i': 'i/',  '*select-i-function*': 's:slash_i'
    \      }
    \    })

    function! s:slash_a()
      normal! F/
      let end_pos = getpos('.')

      normal! f/
      let start_pos = getpos('.')

      return ['v', start_pos, end_pos]
    endfunction

    function! s:slash_i()
      normal! T/
      let end_pos = getpos('.')

      normal! t/
      let start_pos = getpos('.')

      return ['v', start_pos, end_pos]
    endfunction

    let g:loaded_textobj_slash = 1
  endif

  """"""""""""""""""""""""""""""""
  "" allows for da_, ci_, etc.
  """"""""""""""""""""""""""""""""
  if !exists('g:loaded_textobj_underscore')
    call textobj#user#plugin('underscore', {
    \      '-': {
    \        '*sfile*': expand('<sfile>:p'),
    \        'select-a': 'a_',  '*select-a-function*': 's:select_a',
    \        'select-i': 'i_',  '*select-i-function*': 's:select_i'
    \      }
    \    })

    function! s:select_a()
      normal! F_

      let end_pos = getpos('.')

      normal! f_

      let start_pos = getpos('.')
      return ['v', start_pos, end_pos]
    endfunction

    " ciao_come_stai

    function! s:select_i()
      normal! T_

      let end_pos = getpos('.')

      normal! t_

      let start_pos = getpos('.')

      return ['v', start_pos, end_pos]
    endfunction

    let g:loaded_textobj_underscore = 1
  endif
endif
