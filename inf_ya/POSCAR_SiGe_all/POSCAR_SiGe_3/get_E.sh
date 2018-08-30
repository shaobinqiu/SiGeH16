#!/bin/sh
for i in {52..70}
do
E=`tail -1 OSZICAR-R$i`
echo $i$E >>energy_3
done
