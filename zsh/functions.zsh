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

# Haskell

stack-test() {
  if [ $# -eq 0 ]; then
    PGDATABASE=classroom_test \
      stack test $(basename $(pwd)):spec \
      --fast \
      --file-watch \
      --pedantic \
      --interleaved-output \
      --ghc-options="$GHC_OPTIONS"
  else
    PGDATABASE=classroom_test \
      stack test $(basename $(pwd)):spec \
      --fast \
      --test-arguments="-m \"$1\"" \
      --file-watch \
      --pedantic \
      --interleaved-output \
      --ghc-options="$GHC_OPTIONS" \
      "${@:2}"
  fi
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

mwb-build-watch () {
  ls -d **/*.hs | entr -rc make build
}

mwb-test-watch () {
  ls -d **/*.hs | entr -rc make test-fast match="$1"
}

mwf-run() {
  cd $MERCURY_HOME/mwf
  sensible-browser http://localhost:3001 && yarn start
}
