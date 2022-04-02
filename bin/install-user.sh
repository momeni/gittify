echo "Installing in $HOME ..."
cd "$(dirname "$0")"
. ./common.sh

install_configs --global
install_gittify ~/bin ~/.gittify/git.bashrc
if echo ":$PATH:" | grep -q ":$HOME/bin:"; then
  true; # ~/bin is already in the PATH
else
  echo 'export "PATH=$PATH:$HOME/bin"' >> ~/.bashrc
fi
installed_message
