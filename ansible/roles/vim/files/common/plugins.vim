" vim: sw=2 ts=2 sts=2 foldmethod=marker

" Initialization {{{

  if !filereadable(g:keets_plug_install_path)
    echo "Installing Vim-Plug..."
    echo ""
    exec printf('!curl -fLo %s --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim', g:keets_plug_install_path)
    let g:not_finish_vimplug = "yes"

    autocmd VimEnter * PlugInstall
  endif

  " Set the runtimepath for the bootstrap
  exec printf('source %s', g:keets_plug_install_path)

  call plug#begin(g:keets_plugin_dir)

" }}}

" General {{{

  Plug 'airblade/vim-rooter'
  Plug 'altercation/vim-colors-solarized'
  Plug 'junegunn/fzf'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'sirver/UltiSnips'
  Plug 'honza/vim-snippets'

"  Plug 'mileszs/ack.vim'
"  Plug 'terryma/vim-multiple-cursors'
"  Plug 'terryma/vim-expand-region'
"  Plug 'easymotion/vim-easymotion'
"  Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
"  Plug 'nathanaelkane/vim-indent-guides'
"  Plug 'mhinz/vim-signify'
"  Plug 'osyo-manga/vim-over'
"  Plug 'gcmt/wildfire.vim'
"  Plug 'wikitopian/hardmode'
"
"" }}}
"
" Programming {{{

  Plug 'airblade/vim-gitgutter'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'tpope/vim-fugitive'

"  Plug 'scrooloose/nerdcommenter'
"  Plug 'scrooloose/syntastic'     " Do not use 'on' event-based loading since other plugins depend on syntastic
"  Plug 'jimhester/lintr'
"
"  Plug 'rhysd/conflict-marker.vim'
"  "Plug 'jiangmiao/auto-pairs' " Temporarily disabled: I seem to be deleting the pair often
"  Plug 'vim-scripts/matchit.zip'
"  Plug 'luochen1990/rainbow', {'on': 'RainbowToggle' }
"
"  " Default language packs in vim-polyglot and override as necessary
"  Plug 'sheerun/vim-polyglot'
"
" }}}

" Vim/NeoVim Specific {{{
  let s:keets_vim_fork = 'nvim'
  if !has('nvim')
    let s:keets_vim_fork = 'vim'
  endif

  if filereadable(g:keets_config_dir . '/' . s:keets_vim_fork . '/plugins.vim')
    exec printf('source %s/%s/plugins.vim', g:keets_config_dir, s:keets_vim_fork)
  endif
" }}}

" Cleanup {{{

  call plug#end()

" }}}
