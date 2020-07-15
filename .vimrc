let mapleader = "\<space>"      " LeaderキーをSpaceキーに変更

syntax on                       " シンタックスハイライトを有効化
filetype plugin indent on       " ファイルタイプに基づいたインデントを有効化
set autoindent                  " 新しい行を始めるときに自動でインデント
set expandtab                   " タブをスペースに変換(Pythonでは必須
set tabstop=4                   " タブをスペース4文字とカウント
set shiftwidth=4                " 自動インデントに使われるスペースの数
set backspace=2                 " 多くのターミナルでバックスペースの挙動を修正
set hlsearch                    " 検索結果をハイライトする
colorscheme murphy              " カラースキームを変更
" 端末が広ければ行番号を表示する
if &co > 80
    set number
endif

" swapファイル置き場を指定
if !isdirectory(expand("$HOME/.vim/swap"))
    call mkdir(expand("$HOME/.vim/swap"), "p")
endif
set directory=$HOME/.vim/swap// 

" すべてのファイルについて永続アンドゥを有効にする
set undofile
if !isdirectory(expand("$HOME/.vim/undodir"))
    call mkdir(expand("$HOME/.vim/undodir"), "p")
endif
set undodir=$HOME/.vim/undodir

packloadall                       " すべてのプラグインをロードする
silent! helptags ALL              " すべてのプラグイン用にヘルプファイルをロードする

" set foldmethod=indent             " コード折りたたみ

set wildmenu                      " Tabによる自動補完を有効にする
set wildmode=list:longest,full    " 最長マッチまで補完してから自動補完メニューを開く
set visualbell t_vb=              " 警告音を鳴らさない

" vim-plugがまだインストールされていなければインストールする
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plugでプラグインを管理する
call plug#begin()
Plug 'tpope/vim-vinegar'                    " -でnetrwを開く
Plug 'ctrlpvim/ctrlp.vim'                   " Ctrl+pであいまい検索
Plug 'mileszs/ack.vim'                      " 検索コマンドAckとの統合
Plug 'easymotion/vim-easymotion'            " より良い移動コマンド
Plug 'junegunn/vim-plug'
let g:plug_timeout = 300 " YouCompleteMeはコンパイルに時間がかかるためタイムアウトを伸ばす
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
Plug 'sjl/gundo.vim'                        " undoツリーの可視化
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'       " より良いtmuxとの統合
Plug 'janko-m/vim-test'
Plug 'vim-scripts/ScrollColors'             " カラースキーム確認を容易に
Plug 'flazz/vim-colorschemes'               " カラースキーム
Plug 'vim-airline/vim-airline'              " より良いステータスライン
call plug#end()

noremap <leader>] :YcmCompleter GoTo<cr>    " 関数定義へジャンプ
set tags=tags;                              " 親ディレクトリにあるtagsファイルを再帰的に探す

let g:gundo_prefer_python3 = 1              " python3系でgundoが動くようにする
noremap <f5> :GundoToggle<cr>               " F5でGundoToggle呼び出し

" Pythonファイルのみ:makeの挙動を変える
autocmd filetype python setlocal makeprg=pylint3\ --reports=n\ --msg-template=\"{path}:{line}:\ {msg_id}\ {symbol},\ {obj}\ {msg}\"\ %:p
autocmd filetype python setlocal errorformat=%f:%l:\ %m

