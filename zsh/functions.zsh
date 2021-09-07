# General

calc() {
  echo "scale=3; $1" | bc
}

# replace $1 with $2 in a git repository
git-replace() {
  git grep -rl "$1" . | xargs sed -i "s/$1/$2/g"
}

# replace $1 with $2 in a git repository (words)
git-replace-word() {
  git grep -rlw "$1" . | xargs sed -i "s/$1/$2/g"
}

# 1pass
one-password-login () {
  eval $(op signin my)
}

# Mercury

mwb-start () {
  cd $MERCURY_HOME/mercury-web-backend
  nix-shell --command "zsh -c \"make tags\"; zsh -i"
}

mwb-run() {
  cd $MERCURY_HOME/mercury-web-backend
  nix-shell --command "zsh -c \"make tags && make run\"; zsh -i"
}

mwb-watch () {
  if [[ "$1" != "build" && "$1" != "test" && "$1" != "run" ]]; then
    echo "usage: mwb-watch <build|test|run>"
  fi

  ls -d **/*.hs | entr -rc make $1
}

list-haskell-files() {
  ls -d **/*.(hs|persistentmodels|yesodroutes)
}

mwb-build-watch () {
  list-haskell-files | entr -rc make build
}

mwb-run-watch () {
  list-haskell-files | entr -rc make run
}

mwb-test-watch () {
  list-haskell-files | entr -rc make test-fast match="$1"
}

mwf-run() {
  cd $MERCURY_HOME/mwf
  sensible-browser http://localhost:3001 && yarn start
}

function pr () {
  gh pr view $1 --web
}
