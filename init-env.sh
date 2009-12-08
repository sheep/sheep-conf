#! /bin/sh

conf_dir="$HOME/.myconf"
backup_dir="$conf_dir/backup"

apply(){
  if test -f "$HOME/$2" -a ! -L "$HOME/$2"; then
    echo "~/$2 already exist, do you want to replace it ? [y/N]"
    read answer
    case answer in
      y|Y)
        mkdir -p "$backup_dir"
        mv "$1" "$backup_dir"
        echo "A backup of ~/$2 has placed in $backup_dir."
        echo ln -Tfs "$conf_dir/$1" "$HOME/$2"
        ;;
      *)
        return
        ;;
    esac
  else
    echo ln -Tfs "$conf_dir/$1" "$HOME/$2"
  fi
}

apply gitconfig .gitconfig
apply dot.vimrc .vimrc
apply dot.vim  .vim
apply zshrc .zshrc
apply dot.screenrc .screenrc
apply dot.ion3 .ion3
apply gostai/dot.Xdefaults .Xdefaults
apply dot.Xmodmap .Xmodmap
apply dot.colorgccrc .colorgccrc
