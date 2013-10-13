[ -z "$PS1" ] && return

# Prompt
if [ -f ~/.bashrc ]; then
   . ~/.bashrc
fi

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\[\033[31;36m\]\u@\h\[\033[00m\]:\[\033[33;38m\]\w\[\033[1;31m\]\$(parse_git_branch)\[\033[00m\]: "
