" Terminal {{{
  " Exit Terminal insert mode
  tnoremap <C-[> <C-\><C-n>

  " Switch windows
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l

  " Open Terminal in insert mode
  autocmd TermOpen * startinsert
" }

" LSP {{{
  " TODO: Chews too much resources
  " lua require('lspconfig').pyright.setup{}

  " TODO: Add keybindings and completions
  " https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
" }}}
