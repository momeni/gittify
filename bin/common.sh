function install_gittify {
  dstbin="$1"
  dstconf="$2"
  install -D -m 755 ./gittify "$dstbin/gittify"
  install -D -m 644 ../homefolder/git.bashrc "$dstconf"
}

function select_config_file {
  git version | cut -d\  -f3 | while read ver; do
    ourgit="../homefolder/.gitconfig.before-git-${ver}"
    availablegits="$(ls ../homefolder/.gitconfig.before-git-*)"
    candidate="$(echo $ourgit $availablegits ../homefolder/.gitconfig.before-git-last | tr ' ' '\n' | sort --version-sort | grep -A1 "$ourgit" | tail -n1)"
    if [ "$candidate" = "../homefolder/.gitconfig.before-git-last" ]; then
      echo "../homefolder/.gitconfig"
    elif [ -f "$candidate" ]; then
      echo "$candidate"
    else
      echo "ERROR: Cannot find candidate config file."
      exit -1;
    fi
  done
}

function should_overwrite {
  while true; do
    read -p "Do you want to overwrite this config (y/n)? " yes_or_no < /dev/stdin
    case "$yes_or_no" in
      y|yes)
        return 0
        ;;
      n|no)
        return 1
        ;;
      *)
        echo ""
        echo "Either type y or yes in order to overwrite this config"
        echo "or type n or no in order to keep it unchanged"
        ;;
    esac
  done
}

function install_configs {
  local opt="$1"
  local oldval
  local name
  local value
  exec {USER_PROMPT}>&0
  select_config_file | xargs cat | sed 's/#.*//g' | awk '{ sub(/[\t ]*/, ""); if (/\[(.*)\]/) { prefix=substr($0, 2, length()-2); } else if ($0 ~ /[^\t ]/) { print prefix"."$0; } }' | sed 's/ = /\n/' | while read name; do
    read value;
    oldval="$(git config "$opt" "$name")"
    if [ $? = 0 ]; then
      echo "Config[$name] already exists."
      if [ "a$oldval" = "a$value" ]; then
        echo "Old and new values are the same (no changes)."
      else
        echo "Old value: $oldval"
        echo "New value: $value"
        if should_overwrite <&$USER_PROMPT; then
          echo "Overwriting Config[name=$name] -> $value"
          git config "$opt" "$name" "$value"
        else
          echo "Config[name=$name] is kept unchanged."
        fi
      fi
    else
      echo "Config[name=$name] -> $value";
      git config "$opt" "$name" "$value"
    fi
  done
}

function installed_message {
  echo "Done. Run gittify in any git repo to start."
}
