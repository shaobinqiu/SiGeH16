rm sp_3.txt 
for i in {52..70}
do
grep 'cm-1' OUTCAR-V$i >> sp_3.txt
done
