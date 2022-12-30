call plug#begin()
" -------------
" 標準拡張機能系
" -------------
Plug 'preservim/nerdtree'                  " Vimでディレクトリを表示
Plug 'lukas-reineke/indent-blankline.nvim' " インデントを見やすくする
Plug 'unblevable/quick-scope'              " 移動改善
Plug 'terryma/vim-expand-region'           " 選択
Plug 'mhinz/vim-grepper'                   " 全体検索
Plug 't9md/vim-quickhl'                    " Highlight
Plug 'junegunn/vim-easy-align'             " 整形支援

" ---------------------
" レイアウトカスタマイズ系
" ---------------------
Plug 'itchyny/lightline.vim'    " status line
Plug 'mhinz/vim-startify'       " start menu 
Plug 'sainnhe/gruvbox-material' " color scheme


" ---------
" 機能追加系
" ---------


" ----------------
" コーディング支援系
" ----------------
Plug 'neoclide/coc.nvim', {'branch': 'release'} " 自動補完, LSP
Plug 'preservim/nerdcommenter' " コメント支援


" --------------------------
" プログラミング言語別プラグイン
" --------------------------
Plug 'rust-lang/rust.vim' " Rustの拡張


" --------
" その他
" --------
Plug 'wakatime/vim-wakatime'

" -----
" 保留
" -----
" Plug 'deoplete-plugins/deoplete-clang'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }


call plug#end()