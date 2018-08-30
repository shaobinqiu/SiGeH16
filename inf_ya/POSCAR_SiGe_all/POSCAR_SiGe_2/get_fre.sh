rm sp_2.txt 
for i in {26..51}
do
grep 'cm-1' OUTCAR-V$i >> sp_2.txt
done
