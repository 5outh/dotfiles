export EDITOR='nvim'
# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'
export GRIM_DEFAULT_DIR="$HOME/screenshots"

# Preferred GHC Options
export GHC_OPTIONS='-fmax-relevant-binds=3 -fdiagnostics-color=always -fprint-expanded-synonyms -freverse-errors -fobject-code -Werror -Wall'

# postgres config for Mercury
export PGDATABASE=mercury-web-backend-development
export PGHOST=localhost
export PGPORT=5432
export PGUSER=mercury-web-backend
