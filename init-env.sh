#! /bin/sh

conf_dir="$HOME/.myconf"
backup_dir="$conf_dir/backup"

apply(){
  if test -f "$HOME/$2" -a ! -L "$HOME/$2"; then
    echo mkdir -p "$backup_dir"
    echo mv "$1" "$backup_dir"
  fi
  echo ln -Tfs "$conf_dir/$1" "$HOME/$2"
}

apply gitconfig .gitconfig
apply dot.vimrc .vimrc
apply dot.vim  .vim
apply zshrc .zshrc
apply dot.screenrc .screenrc
apply epita/dot.ion3 .ion3
apply gostai/dot.Xdefaults .Xdefaults
apply dot.Xmodmap .Xmodmap
