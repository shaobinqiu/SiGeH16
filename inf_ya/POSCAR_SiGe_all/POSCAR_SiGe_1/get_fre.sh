rm sp_1.txt 
for i in {1..25}
do
grep 'cm-1' OUTCAR-V$i >> sp_1.txt
done
