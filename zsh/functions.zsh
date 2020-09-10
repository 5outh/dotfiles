# General

calc() {
  echo "scale=3; $1" | bc
}

# Freckle

start-work() {
  cd "$MEGAREPO_ROOT"
  make update
  docker-compose up -d
}

watch-classroom() {
  cd "$MEGAREPO_ROOT/frontend/classroom"; yarn watch;
}

watch-student() {
  cd "$MEGAREPO_ROOT/frontend/student"; yarn watch;
}

watch-school() {
  cd "$MEGAREPO_ROOT/frontend/school"; yarn watch;
}

watch-console() {
  cd "$MEGAREPO_ROOT/frontend/console"; yarn watch;
}

watch-api() {
  cd "$MEGAREPO_ROOT/backend"; make api.watch
}

watch-fr-project() {
  cd "$MEGAREPO_ROOT/backend/$1"; stack-test --no-run-tests
}

run-qa-test() {
  if [ -z $FR_DOMAIN_NAME ]; then
    vared -p "Domain name (e.g. freckletest.com): " -c TMP_DOMAIN_NAME
    export FR_DOMAIN_NAME="$TMP_DOMAIN_NAME"
  fi

  if [ -z $FR_ENVSUFFIX ]; then
    vared -p "Environment suffix (e.g. -staging): " -c TMP_ENVSUFFIX
    export FR_ENVSUFFIX="$TMP_ENVSUFFIX" # NB. This adds the leading hyphen
  fi

  cd "$MEGAREPO_ROOT/qa"
  ./node_modules/nightwatch/bin/nightwatch -c nightwatch.js -e local_chrome -t tests/$1.js
}

# Haskell

stack-test() {
  if [ $# -eq 0 ]; then
    PGDATABASE=classroom_test \
      stack test $(basename $(pwd)) \
      --fast \
      --file-watch \
      --pedantic \
      --interleaved-output \
      --ghc-options="$GHC_OPTIONS"
  else
    PGDATABASE=classroom_test \
      stack test $(basename $(pwd)) \
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
