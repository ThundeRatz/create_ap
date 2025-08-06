if ! (id | grep -q root); then
  echo "$(red_bold "You must run this command as root")"
  exit 1
fi

set +e

echo "$(yellow "killing all running lnxrouter daemons")"
lnxrouter -l | rg '^(\d+)\s\w+' -or '$1' | xargs kill

if [ "$(cat /sys/module/bcmdhd/parameters/op_mode)" -eq 2 ]; then
  echo "Changing op_mode to 1 (WIFI mode)"
  echo 1 >/sys/module/bcmdhd/parameters/op_mode
  systemctl restart network-manager
fi
