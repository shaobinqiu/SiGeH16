#!/bin/sh
for i in {89..90}
do
E=`tail -1 OSZICAR-R$i`
echo $i$E >>energy_5
done
