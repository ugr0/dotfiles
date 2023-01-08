if &compatible
  " https://qiita.com/yu_suke1994/items/e0a19574994a57c8fe17
  set nocompatible
endif

" 外部設定ファイルの読み込み
runtime! init/*.vim
runtime! plugins/*.vim

" シンタックスハイライトをONにする
syntax enable