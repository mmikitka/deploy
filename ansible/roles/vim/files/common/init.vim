" vim: sw=2 ts=2 sts=2 foldmethod=marker

" Functions {{{

  " Platform detection {{{
    silent function! g:KeetsOSX()
        return has('macunix')
    endfunction

    silent function! g:KeetsLINUX()
        return has('unix') && !has('macunix') && !has('win32unix')
    endfunction

    silent function! g:KeetsWINDOWS()
        return  (has('win32') || has('win64'))
    endfunction
  " }}}

" }}}

" Initialization {{{

  " Assume that all configuration files are stored
  " in the directories above this file (init.vim).
  let g:keets_config_dir = expand("<sfile>:p:h"). '/..'

  " Vim/NVim configuration sub-directory
  let s:keets_vim_fork = 'vim'
  let g:keets_plug_install_path = g:keets_config_dir . '/common/autoload/plug.vim'
  let g:keets_plugin_dir = g:keets_config_dir . '/common/plugged'
  if has('nvim')
    let s:keets_vim_fork = 'nvim'
    let g:keets_plug_install_path = stdpath('data') . '/nvim/common/autoload/plug.vim'
    let g:keets_plugin_dir = stdpath('data') . '/plugged'
  endif
  echo(g:keets_plug_install_path)

" }}}

" Load configuration: before plugins {{{
  if filereadable(g:keets_config_dir . '/common/before_plugins.vim')
      exec printf('source %s/common/before_plugins.vim', g:keets_config_dir)
  endif

  if filereadable(g:keets_config_dir . '/' . s:keets_vim_fork . '/before_plugins.vim')
      exec printf('source %s/%s/before_plugins.vim', g:keets_config_dir, s:keets_vim_fork)
  endif
" }}}

" Load configuration: plugins {{{
    if filereadable(g:keets_config_dir . '/common/plugins.vim')
        exec printf('source %s/common/plugins.vim', g:keets_config_dir)
    endif
    " NOTE: Vim or NeoVim specific plugins must be loaded in common/plugins.vim
" }}}

" Load configuration: after plugins {{{
    if filereadable(g:keets_config_dir . '/common/after_plugins.vim')
        exec printf('source %s/common/after_plugins.vim', g:keets_config_dir)
    endif

    if filereadable(g:keets_config_dir . '/' . s:keets_vim_fork . '/after_plugins.vim')
        exec printf('source %s/%s/after_plugins.vim', g:keets_config_dir, s:keets_vim_fork)
    endif
" }}}
