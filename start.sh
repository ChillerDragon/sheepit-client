#!/bin/bash
client=./build/libs/sheepit-client-all.jar
cfg_path=config.cfg
read -rd '' sample_cfg << EOF
password ***
login ChillerDragon
ui text
cores 1
priority -19
EOF

function build() {
    ./gradlew shadowJar
}

function run() {
    if [ ! -f $cfg_path ]
    then
        echo "$sample_cfg" > "$cfg_path"
        vim "$cfg_path"
    fi
    if [ ! -f $client ]
    then
        build
    fi
    java -jar $client -config $cfg_path
}

if ! [ -x "$(command -v java)" ]
then
  echo 'Error: java is not installed.' >&2
  exit 1
fi

if [ "$1" == "--help" ] || [ "$1" == "-h" ]
then
    echo "usage: $(basename "$0") [OPTIONS]"
    echo "options:"
    echo "<none>    runs client and builds if not found"
    echo "--build   re builds no matter if built already"
    exit
elif [ "$1" == "--build" ]
then
    build
    exit
elif [ "$#" -ne "0" ]
then
    echo "unkown argument try --help"
    exit 1
fi

run

