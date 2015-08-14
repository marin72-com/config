#!/bin/bash
set -e
set -x

cd "$(dirname $0)"

ln -sf "$(pwd)/zsh/dot.zshrc" ~/.zshrc
ln -sf "$(pwd)/vim/dot.vimrc" ~/.vimrc
ln -sfh "$(pwd)/vim/dot.vim" ~/.vim

mkdir -p -f vim/dot.vim/bundle

if [ ! -d vim/dot.vim/bundle/neobundle.vim ]; then
	git clone https://github.com/Shougo/neobundle.vim vim/dot.vim/bundle/neobundle.vim
fi
