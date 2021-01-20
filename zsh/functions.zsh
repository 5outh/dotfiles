# General

calc() {
  echo "scale=3; $1" | bc
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
  nix-shell --command zsh
}

make-build-watch () {
  ls -d **/*.hs | entr -rc make build
}

make-test-watch () {
  ls -d **/*.hs | entr -rc make test match="$1"
}
