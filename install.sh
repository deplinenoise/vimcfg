#! /bin/bash

for f in ~/.vimrc ~/.gvimrc ~/.vim; do
	test -e $f && (mv -f $f $f.bak && echo "backed up $f to $f")
done

mkdir ~/.vim
mkdir ~/.vim/bundle
mkdir ~/.vim-backup

ln -s $PWD/dot.vimrc ~/.vimrc
ln -s $PWD/dot.gvimrc ~/.gvimrc

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
