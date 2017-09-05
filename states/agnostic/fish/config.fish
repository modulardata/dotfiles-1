if status --is-interactive
  source $HOME/.config/base16-shell/profile_helper.fish
end

# Set GPG TTY
set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/.gnupg/S.gpg-agent.ssh

gpg-connect-agent killagent /bye
gpg-connect-agent /bye
