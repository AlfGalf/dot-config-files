# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/alfierichards/.oh-my-zsh"

# Add amven to path
export PATH=$PATH:/opt/apache-maven/bin

# Oh my ZSH theme
ZSH_THEME="agnoster"

# Use a sansible date format...
HIST_STAMPS="dd/mm/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git command-not-found autojump auto-color-ls zsh-syntax-highlighting)

# Add oh-my-zsh 
source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
 export LANG=en_UK.UTF-8

# Preferred editor 
 export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

prompt_context(){}

# Run tmux automatically on zsh lunch
if [ "$TMUX" = "" ]; then tmux attach -t TMUX || tmux new -s TMUX; fi

# Alias to navigate to config files directory
alias openConfig="cd ~/Documents/GitRepos/ConfigFiles"

# Set default terminal behaviour to emulate vim 
bindkey -v

# Alias for NOT using rm unless I really mean to
alias rm="echo Don't use rm! Use rmtrash instead (or /bin/rm)"

# Color ls alias
alias lsc='colorls -lA --sd'

