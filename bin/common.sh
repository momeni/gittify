function install_gittify {
  dstbin="$1"
  dstconf="$2"
  install -D -m 755 ./gittify "$dstbin/gittify"
  install -D -m 644 ../homefolder/git.bashrc "$dstconf"
}

function install_configs {
  opt="$1"
  cat ../homefolder/.gitconfig | sed 's/#.*//g' | gawk '{ sub(/\s*/, ""); if (/\[(.*)\]/) { prefix=substr($0, 2, length()-2); } else if ($0 ~ /\S/) { print prefix"."$0; } }' | sed 's/ = /\n/' | while read name; do
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
