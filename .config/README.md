# dotfiles

Personal dotfiles for macOS, managed with a bare git repository.

Files live at their real locations — no symlinks. The `dotfiles` alias wraps git with
`--git-dir=$HOME/.dotfiles/ --work-tree=$HOME` so only explicitly added files are tracked.

## Bootstrap on a new machine

```bash
# 1. Clone the bare repo
git clone --bare git@github.com:<user>/dotfiles.git "$HOME/.dotfiles"

# 2. Add the alias temporarily (it will be in .zshrc once checked out)
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# 3. Suppress untracked-file noise
dotfiles config status.showUntrackedFiles no

# 4. Check out — back up any conflicting files first if needed
dotfiles checkout

# 5. Reload the shell so the alias becomes permanent
source ~/.zshrc
```

If checkout reports conflicts, back up and remove the offending files then rerun step 4.

## Day-to-day usage

```bash
dotfiles status              # what's changed
dotfiles add ~/.zshrc        # stage a change
dotfiles diff                # review before commit
dotfiles commit -m "..."     # commit
dotfiles push                # push to remote
```

## Additional setup required on a new machine

These are managed separately and need manual bootstrapping:

### tmux plugins (tpm)

Plugins are excluded from this repo. Clone the plugin manager first:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

Then start tmux and press `<prefix> + I` to install all plugins listed in `tmux.conf`.

### Claude Code skills

The skills directory is its own repo:

```bash
git clone git@github.com:rhvdbergh/claude-skills.git ~/.claude/skills
```

## What's tracked

| Path | Contents |
|------|----------|
| `~/.zshrc`, `~/.zprofile` | Shell config |
| `~/.gitignore` | Home-dir gitignore (safety net for this repo) |
| `~/.config/nvim/` | Neovim config (LazyVim) |
| `~/.config/tmux/tmux.conf` | tmux config (plugins excluded) |
| `~/.config/ghostty/` | Ghostty terminal config + shaders |
| `~/.config/karabiner/` | Karabiner-Elements key remapping |
| `~/.config/lazygit/` | lazygit config |
| `~/.config/git/` | Global gitignore |
| `~/.config/borders/` | JankyBorders config |
| `~/.config/starship.toml` | Starship prompt config |
| `~/.claude/CLAUDE.md` | Claude Code global instructions |
| `~/.claude/settings.json` | Claude Code settings |
| `~/.claude/statusline-command.sh` | Claude Code statusline script |
