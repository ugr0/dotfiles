" Start NERDTree when Vim is started without file arguments.
" https://github.com/mhinz/vim-startify/issues/319
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter *
            \   if !argc() && !exists('s:std_in')
            \ |   Startify
            \ |   NERDTree
            \ | endif