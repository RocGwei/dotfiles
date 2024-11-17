# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/roc/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by pnpm
export PNPM_HOME="/home/roc/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# End of lines configured by pnpm

# Lines configured by Roc
## plugin and theme
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
## zoxide
eval "$(zoxide init zsh)"
## fzf
source <(fzf --zsh)
## command alias
alias ll='lsd -l'
alias la='lsd -A'
alias lt='lsd --tree'
alias lla='lsd -l -A'
alias nvim='proxychains -q nvim'
## scripts
#source ~/dev/script/zsh-fun.zsh
if [[ "$(who am i)" == *tty* ]]; then
  [[ ! -f ~/.p10k.tty.zsh ]] || source ~/.p10k.tty.zsh
else
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi
# End of lines added by Roc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# This is configured in Roc's script.
