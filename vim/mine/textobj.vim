if !exists('g:loaded_textobj_dash')
  call textobj#user#plugin('dash', {
  \      '-': {
  \        '*sfile*': expand('<sfile>:p'),
  \        'select-a': 'a-',  '*select-a-function*': 's:select_a',
  \        'select-i': 'i-',  '*select-i-function*': 's:select_i'
  \      }
  \    })

  function! s:select_a()
    normal! F-

    let end_pos = getpos('.')

    normal! f-

    let start_pos = getpos('.')
    return ['v', start_pos, end_pos]
  endfunction

  function! s:select_i()
    normal! T-

    let end_pos = getpos('.')

    normal! t-

    let start_pos = getpos('.')

    return ['v', start_pos, end_pos]
  endfunction

  let g:loaded_textobj_dash = 1
endif

if !exists('g:loaded_textobj_slash')
  call textobj#user#plugin('slash', {
  \      '-': {
  \        '*sfile*': expand('<sfile>:p'),
  \        'select-a': 'a/',  '*select-a-function*': 's:select_a',
  \        'select-i': 'i/',  '*select-i-function*': 's:select_i'
  \      }
  \    })

  function! s:select_a()
    normal! F/

    let end_pos = getpos('.')

    normal! f/

    let start_pos = getpos('.')
    return ['v', start_pos, end_pos]
  endfunction

  function! s:select_i()
    normal! T/

    let end_pos = getpos('.')

    normal! t/

    let start_pos = getpos('.')

    return ['v', start_pos, end_pos]
  endfunction

  let g:loaded_textobj_slash = 1
endif