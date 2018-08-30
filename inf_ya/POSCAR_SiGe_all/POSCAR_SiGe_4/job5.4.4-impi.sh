#! /bin/sh     
#$ -S /bin/sh
#$ -cwd            
#$ -V            
#$ -N SiGe7190
#$ -pe impi 12
#$ -j y         

#for i in {88}
#do
i=88 
cp INCAR_R INCAR
cp POSCAR-$i POSCAR
mpirun -np ${NSLOTS} vasp5.4.4-std
mv CONTCAR CONTCAR-R$i
mv OSZICAR OSZICAR-R$i
mv OUTCAR OUTCAR-R$i
rm WAVECAR
rm EIGENVAL
cp INCAR_V INCAR
cp CONTCAR-R$i POSCAR
mpirun -np ${NSLOTS} vasp5.4.4-std
mv CONTCAR CONTCAR-V$i
mv OSZICAR OSZICAR-V$i
mv OUTCAR OUTCAR-V$i
rm WAVECAR
rm EIGENVAL
#done
