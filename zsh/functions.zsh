# General

calc() {
  echo "scale=3; $1" | bc
}

# replace $1 with $2 in a git repository
git-replace() {
  grep -rl "$1" /dir_to_search_under | xargs sed -i "s/$1/$2/g"
}

# replace $1 with $2 in a git repository (words)
git-replace-word() {
  grep -rlw "$1" /dir_to_search_under | xargs sed -i "s/$1/$2/g"
}

# 1pass
one-password-login () {
  eval $(op signin my)
}

# Mercury

mwb-start () {
  cd $MERCURY_HOME/mwb
  nix-shell --command "zsh -c \"make tags\"; zsh -i"
}

mwb-run() {
  cd $MERCURY_HOME/mwb
  nix-shell --command "zsh -c \"make tags && make run\"; zsh -i"
}

mwb-watch () {
  if [[ "$1" != "build" && "$1" != "test" && "$1" != "run" ]]; then
    echo "usage: mwb-watch <build|test|run>"
  fi

  ls -d **/*.hs | entr -rc make $1
}

mwb-build-watch () {
  ls -d **/*.hs | entr -rc make build
}

mwb-run-watch () {
  ls -d **/*.hs | entr -rc make 
}

mwb-test-watch () {
  ls -d **/*.hs | entr -rc make test-fast match="$1"
}

mwf-run() {
  cd $MERCURY_HOME/mwf
  sensible-browser http://localhost:3001 && yarn start
}

function pr () {
  gh pr view $1 --web
}
