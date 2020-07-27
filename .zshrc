# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/alfierichards/.oh-my-zsh"
export PATH=$PATH:/opt/apache-maven/bin

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
 HIST_STAMPS="dd/mm/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# Add oh-my-zsh 
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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

