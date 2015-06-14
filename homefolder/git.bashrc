[ -z "$PS1" ] && return

# Prompt
if [ -f ~/.bashrc ]; then
   . ~/.bashrc
fi

function get_remote_origin_domain_name {
  if git remote -v >/dev/null 2>&1; then
    git remote -v | grep '^origin\W*\(\w*://\)\?\(\(@\|\.\|\w\)*\).*(push)$' | head -n1 | sed 's/^origin\W*\(\w*:\/\/\)\?\(\(@\|\.\|\w\)*\).*(push)$/\2/' | sed 's/[^@]*@\(.*\)/\1/'
  fi
}

author_committer_name=""
author_committer_email=""

function get_repo_specific_git_parameter {
  local domain="$1"
  local parameter="$2"
  if git config "${domain}.${parameter}" > /dev/null; then
    git config "${domain}.${parameter}"
  elif git config "user.${parameter}" > /dev/null; then
    git config "user.${parameter}"
  fi
}

function update_author_committer_info {
  local domain="$(get_remote_origin_domain_name)";
  if [ "a$domain" != "a" ]; then
    local newname=$(get_repo_specific_git_parameter "$domain" "name")
    if [ "a$newname" != "a$author_committer_name" ]; then
      author_committer_name="$newname"
      export GIT_AUTHOR_NAME="$newname"
      export GIT_COMMITTER_NAME="$newname"
      author_committer_name_or_email_is_changed="1"
    fi
    newemail=$(get_repo_specific_git_parameter "$domain" "email")
    if [ "a$newemail" != "a$author_committer_email" ]; then
      author_committer_email="$newemail"
      export GIT_AUTHOR_EMAIL="$newemail"
      export GIT_COMMITTER_EMAIL="$newemail"
      author_committer_name_or_email_is_changed="1"
    fi
  fi
}

function inspect_git_repo {
  author_committer_name_or_email_is_changed="0"
  update_author_committer_info
  if [ "a$author_committer_name_or_email_is_changed" = "a1" ]; then
    if [ "a$author_committer_name" != "a" ]; then
      local newname="$author_committer_name"
    else
      local newname="No Name"
    fi
    if [ "a$author_committer_email" != "a" ]; then
      local newemail="$author_committer_email"
    else
      local newemail="No Email"
    fi
    echo "Author/Committer switched to $newname < $newemail >"
  fi
}

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\[\033[31;36m\]\u@\h\[\033[00m\]:\[\033[33;38m\]\w\[\033[1;31m\]\$(parse_git_branch)\[\033[00m\]: "

inspect_git_repo

function cd {
  builtin cd "$@"
  inspect_git_repo
}

