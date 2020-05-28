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
if ! [ -x "$(command -v java)" ]
then
  echo 'Error: java is not installed.' >&2
  exit 1
fi
if [ ! -f $cfg_path ]
then
    echo "$sample_cfg" > "$cfg_path"
    vim "$cfg_path"
fi
if [ ! -f $client ]
then
    ./gradlew shadowJar
fi
java -jar $client -config $cfg_path

