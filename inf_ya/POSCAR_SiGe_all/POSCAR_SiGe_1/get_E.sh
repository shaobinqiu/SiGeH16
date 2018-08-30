#!/bin/sh
for i in {1..25}
do
E=`tail -1 OSZICAR-R$i`
echo $i$E >>energy_1
done
