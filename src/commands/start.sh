if ! (id | grep -q root); then
  echo "$(red_bold "ERROR: You must run this command as root")"
  exit 1
fi

config_path="$(dirname $0)/config.json"
if [ -n "${args[--config]}" ]; then
  config_path="${args[--config]}"
fi

if [ ! -f "$config_path" ]; then
  echo "$(red_bold "ERROR: config.json does not exist")"
  echo "config.json must have the following format"
  cat <<EOF
{
  "hostname": "ap_name",
  "password": "ap_password",
  "interface_fullname": "Broadcom BCM4354 WLAN card"
}
// You can find "interface_fullname" using 'create_ap list'
EOF
  exit 1
fi

hostname="$(jq -r .hostname "$config_path")"
password="$(jq -r .password "$config_path")"
fullname="$(jq -r .interface_fullname "$config_path")"

if [[ -z "$fullname" ]]; then
  echo "$(red_bold "ERROR: interface_fullname is invalid")"
  echo "Run 'create_ap list'"
  exit
fi

list_cmd="create_ap list"

if [[ -z "$($list_cmd | rg "$fullname")" ]]; then
  echo "$(red_bold "ERROR: interface with fullname '$fullname' was not found")"
  exit
fi

interface="$($list_cmd | rg "$fullname" | cut -d':' -f1 | head -n1)"

echo "$(green "creating access point...")"
echo
echo "hostname:           $hostname"
echo "password:           $password"
echo "interface:          $interface"
echo "interface_fullname: $fullname"
echo

if [ "$(cat /sys/module/bcmdhd/parameters/op_mode)" -ne 2 ]; then
  echo "Changing op_mode to 2 (AP mode)"
  echo 2 >/sys/module/bcmdhd/parameters/op_mode
  systemctl restart network-manager
fi

lnxrouter --ap "$interface" "$hostname" -p "$password" -g 12 --no-virt ${other_args[@]}
