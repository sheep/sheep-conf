#! /bin/sh -v

tmp_worktree=/tmp/sheep-conf
github="git@github.com:sheep/sheep-conf"

if test $# -eq 1; then
  commit_to_pick="$1"
else
  commit_to_pick="origin/local"
fi

_cd() {
    cd $@ || exit 1
}

git() {
    command git $@ || exit $?
}

tmp_conf_exist=false
if [ -d "$tmp_worktree" ]; then
    _cd "$tmp_worktree"
    git fetch origin
    tmp_conf_exist=true
else
    git clone --shared --branch master ~/.myconf "$tmp_worktree"
    #_cd "$tmp_worktree"
    #git remote add github "$github"
    ln -s ~/.myconf/.git/refs/remotes/origin "$tmp_worktree/.git/refs/remotes/github"
fi
_cd "$tmp_worktree"
#git fetch github
# Add github remote if not exist
#if $tmp_conf_exist; then
    #git checkout github/master -b master
#else
git checkout master
    #git reset --hard github/master
git rebase github/master
#fi
git cherry-pick "$commit_to_pick"
git push origin master
