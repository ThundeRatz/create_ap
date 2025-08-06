#!/bin/bash

shopt -s expand_aliases

alias bashly='docker run --rm -it --user $(id -u):$(id -g) --volume "$PWD:/app" dannyben/bashly'

(cd ~/Tools/create_ap && bashly add colors && bashly generate --upgrade)

cat <<EOF

Now run the command below to give the configuration scripts permission to run

chmod +x \$HOME/Tools/create_ap/src/**/*.sh
EOF
