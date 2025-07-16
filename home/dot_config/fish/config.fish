#-------------------------------------------------------------------------------
# Ghostty Shell Integration
#-------------------------------------------------------------------------------
# Ghostty supports auto-injection but Nix-darwin hard overwrites XDG_DATA_DIRS
# which make it so that we can't use the auto-injection. We have to source
# manually.
if set -q GHOSTTY_RESOURCES_DIR
    source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
end

#-------------------------------------------------------------------------------
# Homebrew Shell Integration
#-------------------------------------------------------------------------------
if type -q brew
    if test -d (brew --prefix)"/share/fish/completions"
        set -p fish_complete_path (brew --prefix)/share/fish/completions
    end

    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end
end

status is-login; and begin
    fish_add_path --prepend /opt/homebrew/bin
    fish_add_path --prepend /opt/homebrew/opt/node@22/bin

    # Login shell initialisation
    npm set prefix ~/.npm
end

status is-interactive; and begin
    alias cat bat
    alias eza 'eza --git'
    alias la 'eza -a'
    alias lg lazygit
    alias ll 'eza -l'
    alias lla 'eza -la'
    alias ls eza
    alias lt 'eza --tree'
    alias vi nvim
    alias vim nvim

    # Interactive shell initialisation
    zoxide init fish | source

    if test "$TERM" != dumb
        starship init fish | source

    end

    atuin init fish | source
end

if [ -n "$VARS_SOURCED" ]
    return
end

set -gx VARS_SOURCED '1'
set -gx EDITOR 'nvim'
set -gx LANG 'en_US.UTF-8'
set -gx LC_ALL 'en_US.UTF-8'
set -gx LC_CTYPE 'en_US.UTF-8'
