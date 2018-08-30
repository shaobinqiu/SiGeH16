rm sp_4.txt 
for i in {71..88}
do
grep 'cm-1' OUTCAR-V$i >> sp_4.txt
done
