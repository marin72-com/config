# 移動系
alias desk="cd ~/Desktop"
alias down="cd ~/Downloads"
alias c++11="g++ -std=c++11"

# そのた
alias datahide="defaults write com.apple.finder AppleShowAllFiles FALSE"
alias datashow="defaults write com.apple.finder AppleShowAllFiles TRUE"
alias bundle="nocorrect bundle"

# export的なの
export PATH=$HOME/Library/Haskell/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/usr/local/bin:/usr/bin:$PATH
export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
export LANG=ja_JP.UTF-8

# エイリアス
alias ls='ls -G'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias cl='clear'

# Prompt
autoload -U colors;colors
colors

setopt prompt_subst
#PROMPT="%B%{$fg[green]%}%m:%{$fg[cyan]%}(℃_°) $ %{$reset_color%}%b"
#PROMPT="%B%{$fg[green]%}%n:%{$fg[cyan]%}(⑅´◡`♥) $ %{$reset_color%}%b"
#PROMPT="%B%{$fg[green]%}%n %(?|%{$fg[cyan]%}(´灬｀%)|%{$fg[red]%}(・c_・))%{$reset_color%}%b "
PROMPT="%B%{$fg[green]%}pndcat %(?|%{$fg[cyan]%}ヾ(๑╹◡╹%)ﾉ'|%{$fg[red]%}ヾ(｡>﹏<｡%)ﾉﾞ)%{$reset_color%}%b "
RPROMPT="[%~]"

# 補完候補表示時にビープ音を鳴らさない
setopt nolistbeep

# refiute からもらった
# 履歴
HISTSIZE=50000 #histリストのサイズ
SAVEHIST=50000 #histファイルのサイズ
HISTFILE=$HOME/.zsh_history #historyファイルの保存場所
setopt append_history #ヒストリファイルに追加
setopt extended_history #時間と実行時間も一緒に記録
setopt hist_ignore_all_dups #重複したコマンドの古い方を削除
setopt hist_reduce_blanks #余計な空白を削除
setopt share_history #複数のzshプロセス間でヒストリリストを共有する
setopt hist_ignore_space #先頭の余白を削除

#--------------------------------------------------

# 補完
autoload -U compinit
compinit -u
setopt list_packed #補完を詰めて表示
setopt always_to_end #補完後コマンド末尾まで移動
setopt long_list_jobs #ジョブリストがデフォでロングフォーマット
setopt magic_equal_subst #=以降も補完
setopt numeric_glob_sort #数字入りファイル名はソートして表示
setopt print_eight_bit #マルチバイト文字補完
setopt correct #スペル訂正機能
setopt correct_all #引数のスペル訂正
setopt hist_no_store #historyコマンドを追加しない
setopt hist_verify #ヒストリを呼び出してから実行する間に編集できるように
setopt no_list_types #補完の時にファイル種別を表示しない
setopt mark_dirs #フォルダと一致した時に最後に'/'を自動補完する

zstyle ':completion:*' list-colors 'm:{a-z}={A-Z}' #小文字を大文字としても扱う
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} #色をつける

# sudoでも補完
zstyle ':completion:*:sudo:*' \
	command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

#一発解答
ex(){
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xvjf $1    ;;
	*.tar.gz)    tar xvzf $1    ;;
	*.tar.xz)    tar xvJf $1    ;;
	*.bz2)       bunzip2 $1     ;;
	*.rar)       unrar x $1     ;;
	*.gz)        gunzip $1      ;;
	*.tar)       tar xvf $1     ;;
	*.tbz2)      tar xvjf $1    ;;
	*.tgz)       tar xvzf $1    ;;
	*.zip)       unzip $1 -d ${1%.zip}  ;;
	*.Z)         uncompress $1  ;;
	*.7z)        7z x $1        ;;
	*.lzma)      lzma -dv $1    ;;
	*.xz)        xz -dv $1      ;;
	*)           echo "don't know how to extract '$1'..." ;;
	esac
	else
		echo "'$1' is not a valid file!"
			fi
}
