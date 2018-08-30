#!/bin/sh
for i in {26..51}
do
E=`tail -1 OSZICAR-R$i`
echo $i$E >>energy_2
done
