#移動系
alias wall="cd ~/Pictures/wall"
alias pic="cd ~/Pictures"
alias pub="cd ~/Public"
alias desk="cd ~/Desktop"
alias down="cd ~/Downloads"
alias c++11="g++ -std=c++11"

# そのた
alias datahide="defaults write com.apple.finder AppleShowAllFiles FALSE"
alias datashow="defaults write com.apple.finder AppleShowAllFiles TRUE"

#export的なの
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

alias curl='curl --proxy http://proxy.uec.ac.jp:8080'

# Prompt
autoload -U colors;colors
colors

setopt prompt_subst
#PROMPT="%B%{$fg[green]%}%m:%{$fg[cyan]%}(℃_°) $ %{$reset_color%}%b"
#PROMPT="%B%{$fg[green]%}%n:%{$fg[cyan]%}|✽╹◡╹) $ %{$reset_color%}%b"
PROMPT="%B%{$fg[green]%}%n %(?|%{$fg[cyan]%}ヾ(๑╹◡╹%)ﾉ'|%{$fg[red]%}ヾ(｡>﹏<｡%)ﾉﾞ)%{$reset_color%}%b "
RPROMPT="[%~]"

# uec
export HTTP_PROXY="http://proxy.uec.ac.jp:8080"
export HTTPS_PROXY="http://proxy.uec.ac.jp:8080"
export ALL_PROXY=$http_proxy
git config --global http.proxy http://proxy.uec.ac.jp:8080 
git config --global https.proxy http://proxy.uec.ac.jp:8080
git config --global url."https://".insteadOf git://
export PATH=/usr/local/texlive/2015/bin:$PATH
export PATH=/usr/local/texlive/2015/bin/universal-darwin:$PATH

# refiute からもらった
# 履歴
HISTSIZE=5000 #histリストのサイズ
SAVEHIST=5000 #histファイルのサイズ
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

source ~/.zsh/incr*.zsh

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

# pip系
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh

# opencv for python
#export PYTHONPATH="/usr/local/lib/python2.7/site-packages/:$PYTHONPATH"

# android
#export ANDROID_NDK_ROOT=/Applications/android-ndk-r10b
#	export PATH=$PATH:$ANDROID_NDK_ROOT
#	export NDK_PROJECT_PATH=$PATH:$ANDROID_NDK_ROOT
export ANDROID_NDK_ROOT=/Applications/android-ndk-r10d
	export PATH=$PATH:$ANDROID_NDK_ROOT
	export NDK_PROJECT_PATH=$PATH:$ANDROID_NDK_ROOT


export PATH="$HOME/.rbenv/bin:$PATH"; eval "$(rbenv init -)"

# LISP
export PATH="/Applications/Racket v6.1.1/bin:$PATH"

# ----- PROMPT -----
## PROMPT
PROMPT=$'[%*] → '
## RPROMPT
RPROMPT=$'`branch-status-check` %~' # %~はpwd
setopt prompt_subst #表示毎にPROMPTで設定されている文字列を評価する

# {{{ methods for RPROMPT
# fg[color]表記と$reset_colorを使いたい
# @see https://wiki.archlinux.org/index.php/zsh
autoload -U colors; colors
function branch-status-check {
    local prefix branchname suffix
        # .gitの中だから除外
        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
            return
        fi
        branchname=`get-branch-name`
        # ブランチ名が無いので除外
        if [[ -z $branchname ]]; then
            return
        fi
        prefix=`get-branch-status` #色だけ返ってくる
        suffix='%{'${reset_color}'%}'
        echo ${prefix}${branchname}${suffix}
}
function get-branch-name {
    # gitディレクトリじゃない場合のエラーは捨てます
    echo `git rev-parse --abbrev-ref HEAD 2> /dev/null`
}
function get-branch-status {
    local res color
        output=`git status --short 2> /dev/null`
        if [ -z "$output" ]; then
            res=':' # status Clean
            color='%{'${fg[green]}'%}'
        elif [[ $output =~ "[\n]?\?\? " ]]; then
            res='?:' # Untracked
            color='%{'${fg[yellow]}'%}'
        elif [[ $output =~ "[\n]? M " ]]; then
            res='M:' # Modified
            color='%{'${fg[red]}'%}'
        else
            res='A:' # Added to commit
            color='%{'${fg[cyan]}'%}'
        fi
        # echo ${color}${res}'%{'${reset_color}'%}'
        echo ${color} # 色だけ返す
}
eval "$(rbenv init -)"
