# macOS $TMPDIR paths are long enough that Neovim's socket paths exceed the
# 104-byte sun_path limit, which makes serverstart() fail with EINVAL.
export XDG_RUNTIME_DIR="$HOME/.cache/nvim-run"
[ -d "$XDG_RUNTIME_DIR" ] || mkdir -m 700 -p "$XDG_RUNTIME_DIR"

# nvm is lazy-loaded in .zshrc, so non-interactive shells get no node on PATH.
# Tools with a `#!/usr/bin/env -S npx ...` shebang need it at exec time.
export NVM_DIR="$HOME/.nvm"
() {
  local v d
  v=$(<"$NVM_DIR/alias/default")
  d=("$NVM_DIR"/versions/node/v${v}*(N/n[-1]))
  (( $#d )) && export PATH="$d[1]/bin:$PATH"
}
