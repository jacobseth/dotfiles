# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/jmckenzi/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="pygmalion"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git wd)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
plugins=(git-extras)

alias docker='sudo -E docker'
alias docker-compose='sudo -E docker-compose'
alias ec='emacsclient'
alias view='xdg-open'
alias docket='ET_NO_AUTOSTART="true" docker-compose up &'
alias bashet='docker-compose exec dev bash'

cdd(){
    cd "$1"
    ls
}
# allows 'et rails console' to open up a rails console
et() {
    sudo docker-compose exec dev bash -l -c "$*"
}

rr() {
  NO_FIXTURE_LOAD=1 bundle exec ruby -Ilib:test $*
}

helppls() {
    echo "Escape command: 'ctrl+a'"
    echo "Create window: 'c'"
    echo "Next window: 'n'"
    echo "Monitor window: 'M'"
    echo "Kill window: 'k'"
    echo "Select window: '[0-9]'"
}
preexec () {
  clear
}
preexec_invoke_exec () {
    [ -n "$COMP_LINE" ] && return                     # do nothing if completing
    [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return # don't cause a preexec for $PROMPT_COMMAND
    local this_command=`history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//g"`; # obtain the command from the history, removing the history number at the beginning
    preexec "$this_command"
}
trap 'preexec_invoke_exec' DEBUG

alias sl=ls

function cdr(){
    cd $(git rev-parse --show-toplevel)
}

function f(){
  find -name "*$1*"
}

function makewf(){
  for file in $(ls); do
    echo "  - encoding: b64" >> wf;
    echo "    content: $(cat $file | base64 -w 0)" >> wf;
    echo "    owner: root:root" >> wf;
    echo "    path: $file " >> wf;
    echo "    permissions: '600'" >> wf;
  done
}

function sshr(){
    host=$(xclip -o)
    if [[ $host ]]; then
        ssh -i ~/.ssh/et-jenkins-slave root@$host
    else
        echo "Clipboard empty, exiting..."
    fi
}

function sshf(){
    host=$(xclip -o)
    if [ $host ]; then
        ssh -i ~/.ssh/et-jenkins-slave fedora@$host
    else
        echo "Clipboard empty, exiting..."
    fi
}

function sshj(){
    host=$(xclip -o)
    if [ $host ]; then
        ssh -i ~/.ssh/et-jenkins-slave jenkins@$host
    else
        echo "Clipboard empty, exiting..."
    fi
}

function et-no-auto(){
    grep -e '"true"' docker-compose.yml | wc -l
}

function et-server(){
    if ((2 == $(grep -e '"true"' docker-compose.yml | wc -l))); then
        sed -ie 's/"true"//g' docker-compose.yml
    fi
    sudo -E docker-compose up
}

function et-container(){
    if ((1 == $(grep -e '"true"' docker-compose.yml | wc -l))); then
        sed -ie 's/ET_NO_AUTOSTART:/ET_NO_AUTOSTART: "true"/g' docker-compose.yml
    fi
    sudo -E docker-compose up &
    sudo -E docker-compose exec dev bash
}

function rmcontainers(){
    sudo docker rm $(docker ps -aq)
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export ALTERNATE_EDITOR=''

