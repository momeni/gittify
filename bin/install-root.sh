if [ "$(whoami)" != "root" ]; then
  echo "ERROR: install-root needs root access!";
  exit -1;
fi
echo "Installing system-wide ..."
. ./common.sh
install_configs --system
install_gittify /usr/bin /etc/gittify/git.bashrc
installed_message
