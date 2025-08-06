echo "NAME FULLNAME"

nmcli | rg '^(\w+):.+$\n\s+"(.+)"' --multiline -or '$1: $2'
