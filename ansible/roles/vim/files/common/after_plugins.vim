" vim: sw=2 ts=2 sts=2 foldmethod=marker

" Theme {{{

  let g:solarized_termcolors = 256
  let g:solarized_termtrans = 1
  let g:solarized_contrast = "normal"
  let g:solarized_visibility = "normal"

  set background=dark
  let g:solarized_termcolors=16
  colorscheme solarized

" }}}

"" File Types {{{
"
"  autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
"  autocmd BufNewFile,BufRead *.coffee set filetype=coffee
"  autocmd BufNewFile,BufRead *.py.j2 set filetype=python
"  autocmd BufNewFile,BufRead *.py.template set filetype=python
"
"  "autocmd BufWritePre *.js,*.php,*.py :call <SID>StripTrailingWhitespaces()
"  autocmd BufNewFile,BufRead *.js,*.php,*.module,*.py set formatoptions=jqrocbt
"
"  autocmd FileType cpp,python setlocal ts=4 sts=4 sw=4 tw=89
"
"  autocmd BufNewFile,BufRead *.opus set foldmethod=indent
"
"" }}}
"
" Plugins {{{

  " Airline {{{

    let g:airline_theme = 'solarized'
    let g:airline_powerline_fonts = 1
    set laststatus=2

  " }}}

  " FZF {{{

    map <silent> <Leader>f :call fzf#run({'dir': FindRootDirectory(), 'sink': 'e'})<CR>

  " }}}

  " Rooter {{{

    " Do not change the working directory
    let g:rooter_manual_only = 1

  " }}}

  " vim-go {{{

    " One reference configuration: https://hackernoon.com/my-neovim-setup-for-go-7f7b6e805876

    " Disable the :GoDef shortcut (gd), since this is handled by the CoC
    " Language Client.
    let g:go_def_mapping_enabled = 0

    " run :GoBuild or :GoTestCompile based on the go file
    function! s:build_go_files()
      let l:file = expand('%')
      if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
      elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
      endif
    endfunction

    autocmd FileType go set noexpandtab
    autocmd FileType go set shiftwidth=2
    autocmd FileType go set tabstop=2
    autocmd FileType go set listchars=tab:\ \ ,trail:-,extends:>,precedes:<,nbsp:+ " Same as default, minus tab markers
    autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
    autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)
    autocmd FileType go nmap <Leader>i <Plug>(go-info)
    autocmd FileType go nmap <leader>r <Plug>(go-run)
    autocmd FileType go nmap <leader>t <Plug>(go-test)
    autocmd FileType go nmap <leader>tf <Plug>(go-test-func)
    autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

    " Auto-import deps on save
    let g:go_fmt_command = "goimports"

    " Show location results (e.g., metalinter issues) in quickfix
    let g:go_list_type = "quickfix"

    " Use camelCase instead of snake_case for auto tags
    let g:go_addtags_transform = "camelcase"

    " Metalinter
    let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
    let g:go_metalinter_autosave_enabled = ['vet', 'golint']

    " Goto
    let g:go_def_mapping_enabled = 1



    " TODO: If I use Ale, he has some Ale configs
    " TODO: If I return to ctrlp, there is a useful ctrlp + declarations
    " integration

  " }}}

"  " Ack {{{
"
"    nnoremap <Leader>g :Ack!<Space>
"    if executable('ag')
"        let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
"    elseif executable('ack-grep')
"        let g:ackprg="ack-grep -H --nocolor --nogroup --column"
"    endif
"
"  " }}}
"
"  " Matchit {{{
"
"    let b:match_ignorecase = 1
"
"  " }}}
"
"  " TagBar {{{
"
"    nnoremap <silent> <Leader>tt :TagbarToggle<CR>
"
"  " }}}
"
" UltiSnips {{{

    " Default expand trigger, Tab, conflicts with CoC.
    let g:UltiSnipsExpandTrigger="<C-k>"
    let g:UltiSnipsJumpForwardTrigger="<C-k>"
    let g:UltiSnipsJumpBackwardTrigger="<C-j>"

" }}}

"  " Rainbow {{{
"
"    let g:rainbow_active = 0
"    nnoremap <silent> <Leader>rr :RainbowToggle<CR>
"
"  " }}}
"
  " Fugitive {{{

    nnoremap <silent> <Leader>gs :Gstatus<CR>
    nnoremap <silent> <Leader>gd :Gdiff<CR>
    nnoremap <silent> <Leader>gc :Gcommit<CR>
    nnoremap <silent> <Leader>gl :Glog<CR>
    nnoremap <silent> <Leader>gp :Git push<CR>
    nnoremap <silent> <Leader>gw :Gwrite<CR>
    nnoremap <silent> <Leader>gg :SignifyToggle<CR>

"  " }}}
"
"  " UndoTree {{{
"
"    nnoremap <Leader>ut :UndotreeToggle<CR>
"    let g:undotree_SetFocusWhenToggle=1
"
"  " }}}
"
"  " Indent guides {{{
"
"    let g:indent_guides_guide_size = 1
"    let g:indent_guides_enable_on_vim_startup = 1
"    let g:indent_guides_exclude_filetypes = ['help']
"
"    if !has('gui_running')
"      let g:indent_guides_auto_colors = 0
"      autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=black
"      autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black
"    endif
"
"  " }}}
"
"  " vim-expand-region {{{
"
"    vmap v <Plug>(expand_region_expand)
"    vmap <C-v> <Plug>(expand_region_shrink)
"
"  " }}}
"
"  " PlantUML {{{
"
"    let g:plantuml_executable_script = '/usr/bin/plantuml -tpng'
"
"  " }}}
"
"  " Previm {{{
"    let g:previm_open_cmd = 'firefox'
"  " }}}
"
"  " Polyglot {{{
"
"    " Using Nvim-R
"    let g:polyglot_disabled = ['r-lang']
"
"  " }}}
"
"  " Syntastic {{{
"
"    let g:syntastic_check_on_open = 0
"    let g:syntastic_check_on_wq = 0
"    let g:syntastic_aggregate_errors = 0
"    let g:syntastic_enable_balloons = 0
"
"    " Passive checking by default
"    let g:syntastic_mode_map = { 'mode': 'passive',
"                               \ 'active_filetypes': [],
"                               \ 'passive_filetypes': [] }
"
"    let g:syntastic_enable_r_lintr_checker = 1
"    let g:syntastic_r_checkers = ['lintr']
"
"  " }}}
"
"  " VDebug {{{
"
"    let g:vdebug_options = {
"        \    "port" : 9000,
"        \    "server" : 'localhost',
"        \    "timeout" : 20,
"        \    "on_close" : 'detach',
"        \    "ide_key" : '1'}
"
"    let g:vdebug_features = {
"        \    "max_depth" : 5,
"        \    "max_children" : 64,
"        \    "max_data" : 128}
"
"    let g:vdebug_keymap = {
"        \    "run_to_cursor" : "<F1>",
"        \    "set_breakpoint" : "<F4>",
"        \    "run" : "<F5>",
"        \    "close" : "<F6>",
"        \    "detach" : "<F7>",
"        \    "get_context" : "<F8>",
"        \    "eval_under_cursor" : "<F9>",
"        \    "step_over" : "<F10>",
"        \    "step_into" : "<F11>",
"        \    "step_out" : "<S-F11>"}
"
"  " }}}
"
"  " vim-test {{{
"
"    nmap <silent> <Leader>tn :TestNearest<CR>
"    nmap <silent> <Leader>tf :TestFile<CR>
"    nmap <silent> <Leader>ts :TestSuite<CR>
"    nmap <silent> <Leader>tl :TestLast<CR>
"    nmap <silent> <Leader>tv :TestVisit<CR>
"
"    " Use absolute file paths
"    let test#filename_modifier = ':p'
"
"    " Maximum search depth while searching up the directories for the
"    " testrunner executable.
"    let g:test#executable_search_depth = 5
"
"    " My Pull Request was not accepted, so I'm overriding the vim-test
"    " functions. See https://github.com/janko-m/vim-test/pull/99
"
"    function! s:search_local_executable(dir) abort
"      " Look for phpunit in Composer's vendor/bin and Symfony's bin directories
"      echo a:dir
"      if filereadable(a:dir . '/vendor/bin/phpunit')
"        return a:dir . '/vendor/bin/phpunit'
"      elseif filereadable(a:dir . '/bin/phpunit')
"        return a:dir . '/bin/phpunit'
"      else
"        return ''
"      endif
"    endfunction
"
"    "function! test#php#phpunit#executable() abort
"    "  let phpunit_path = ''
"    "  let search_count = 0
"    "  let search_base_dir = expand("%:p:h")
"    "  while search_count < g:test#executable_search_depth
"    "    let phpunit_path = s:search_local_executable(search_base_dir)
"    "    if phpunit_path != ''
"    "        break
"    "    endif
"    "    let search_base_dir = search_base_dir . '/..'
"    "    let search_count = search_count + 1
"    "  endwhile
"
"    "  if filereadable(phpunit_path)
"    "    return phpunit_path
"    "  else
"    "    return 'phpunit'
"    "  endif
"    "endfunction
"
"  " }}}
"
"" }}}
