#!/bin/bash

var=1
for var in `ls /home/johnforjc/sisop/praktikum/nature/`
do
`base64 -d /home/johnforjc/sisop/praktikum/nature/$var | xxd -r>/home/johnforjc/sisop/praktikum/nature/nomer1$var`
done
