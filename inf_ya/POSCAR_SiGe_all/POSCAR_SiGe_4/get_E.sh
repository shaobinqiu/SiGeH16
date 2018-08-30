#!/bin/sh
for i in {71..88}
do
E=`tail -1 OSZICAR-R$i`
echo $i$E >>energy_4
done
