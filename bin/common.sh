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

function install_configs {
  opt="$1"
  select_config_file | xargs cat | sed 's/#.*//g' | awk '{ sub(/[\t ]*/, ""); if (/\[(.*)\]/) { prefix=substr($0, 2, length()-2); } else if ($0 ~ /[^\t ]/) { print prefix"."$0; } }' | sed 's/ = /\n/' | while read name; do
    read value;
    if git config "$opt" "$name" > /dev/null; then
      echo "Config[$name] already exists. Ignoring it."
    else
      echo "Config[name=$name] -> $value";
      git config "$opt" "$name" "$value"
    fi
  done
}

function installed_message {
  echo "Done. Run gittify in any git repo to start."
}
