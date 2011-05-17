#! /bin/sh

conf_dir="$HOME/.myconf"
backup_dir="$conf_dir/backup"

# command
ln="ln --no-target-directory --force --symbolic"

debug(){
  echo "[DEBUG] $*"
}

info(){
  echo "[INFO] $*"
}

apply(){
  if test -e "$HOME/$2" -a ! -L "$HOME/$2"; then
    echo -n "~/$2 already exist, do you want to replace it ? [y/N] "
    read answer
    case "$answer" in
      y|Y)
        mkdir -p "$backup_dir"
        mv "$HOME/$2" "$backup_dir"
        echo "A backup of ~/$2 has placed in $backup_dir."
        $ln "$conf_dir/$1" "$HOME/$2"
        ;;
      *)
        return
        ;;
    esac
  else
    $ln "$conf_dir/$1" "$HOME/$2"
  fi
}

apply gitconfig .gitconfig
apply vimrc .vimrc
apply vim  .vim
apply zshrc .zshrc
apply zsh .zsh
apply dot.screenrc .screenrc
apply ion3 .ion3
apply Xdefaults .Xdefaults
apply Xmodmap .Xmodmap

# TODO: ion3 must be check if is in the path before applying this next command.
apply xinitrc .xinitrc

# Setup colorgcc
info "Setup of colorgcc"
apply dot.colorgccrc .colorgccrc
bin_dir="$HOME/bin"
mkdir -p "$bin_dir"
$ln "$conf_dir/script/colorgcc" "$bin_dir/gcc"
$ln "$conf_dir/script/colorgcc" "$bin_dir/g++"
$ln "$conf_dir/script/colorgcc" "$bin_dir/cc"

apply vimperator/.vimperatorrc .vimperatorrc
apply vimperator/.vimperator .vimperator
# TODO Must check the version of wmii
apply wmii .wmii
apply indent.pro .indent.pro
