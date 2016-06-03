" ---- NeoBundle
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'zenorocha/dracula-theme', {'rtp': 'vim/'}
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'

call neobundle#end()

" Required:
filetype plugin indent on

NeoBundleCheck
" ---

syntax on
set autoindent
"バックアップファイルを作るディレクトリ

"ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set browsedir=buffer 
"クリップボードをWindowsと連携
set clipboard=unnamed
"Vi互換をオフ
set nocompatible
"スワップファイル用のディレクトリ
"変更中のファイルでも、保存しないで他のファイルを表示
set hidden
"インクリメンタルサーチを行う
set incsearch
"タブ文字、行末など不可視文字を表示する
set list
"listで表示される文字のフォーマットを指定する
set listchars=tab:>\ ,extends:<
"行番号を表示する
set number
"シフト移動幅
set shiftwidth=2
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
"新しい行を作ったときに高度な自動インデントを行う
set smartindent
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
"ファイル内の <Tab> が対応する空白の数
set tabstop=2
set whichwrap=b,s,h,l,<,>,[,]
"検索をファイルの先頭へループしない
set nowrapscan
"ファイルエンコーディング
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,ucs2le,ucs-2,cp932,euc-jp
" 縦線の表示
set cursorcolumn
" ハイライトの表示
set hlsearch

set t_Co=256
let g:hybrid_use_iTerm_colors = 1
colorscheme jellybeans

"tabs
nnoremap <silent> gr :tabprev<CR>

"US keybord
noremap ; :
noremap : ;

" python実行
function! s:Exec()
    exe "!" . &ft . " %"        
:endfunction         
command! Exec call <SID>Exec() 
map <silent> <C-P> :call <SID>Exec()<CR>
nmap ls :ls<CR>:buf 
map gb :bn<CR>
map gB :bp<CR>
map gw <C-W><C-W>
imap <C-X> <C-[>
imap <C-F> <C-[>
imap <C-E> <C-Y>,

nmap <silent> <Space>e :NERDTreeToggle<CR>

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1

" python
filetype plugin on
autocmd FileType python setl autoindent
autocmd FileType python setl expandtab smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl  tabstop=4 shiftwidth=4 softtabstop=4

"ruby 
autocmd FileType ruby setl expandtab tabstop=2 shiftwidth=2 softtabstop=2
au BufNewFile,BufRead *.erb set expandtab tabstop=2 shiftwidth=2

"HTML/CSS/JavaScript/scss/coffeescript
autocmd FileType html setl  tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType css setl  tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType javascript setl  tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType scss setl  tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType coffeescript setl  tabstop=2 shiftwidth=2 softtabstop=2


augroup MyXML
	autocmd!
	autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
	autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
	autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
augroup END

