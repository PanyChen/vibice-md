#!/bin/bash

# Slurm job options
#SBATCH --account=e
#SBATCH --partition=standard
#SBATCH --qos=standard

#SBATCH --job-name=xx
#SBATCH --time=12:00:00
#SBATCH --exclusive
#SBATCH --nodes=4
#SBATCH --tasks-per-node=36
#SBATCH --cpus-per-task=1

# submit as follows
# sbatch meas.slurm

# monitor job
# squeue -u $USER


# This module needs to be loaded in ALL scripts as the first module
module load fftw
export PATH="/work/.../build:$PATH" 

# Set the number of threads to 1
export OMP_NUM_THREADS=1


n=10; # number of submissions, can be larger


# before starting the first ever block run, don't forget to remove older counter.txt file [this is key]
file=counter.txt # create file to store counter (0,1,2...)

# if file does not exist, create it and initialise with a 0
if [[ ! -e $file ]]; then
    touch $file
    echo 0 >> $file
fi

num=`head -1 $file` # take number from file
num1=$(($num + 1)) # and add 1 to it
    
srun lmp -in in.meas > log_meas_$num1

# back up of measured file
cp meas.txt meas_$num1
cp measTrj.lammpstrj measTrj_$num1
    
#combine all meas.txt files here 
nM=`ls meas_* | wc -l`

rm meas_final.txt  
touch intFile.txt

for (( i=1; i<=$nM; i++ ))
do
    tail -n +4  meas_$i > int.txt

    cat intFile.txt int.txt > tempFile.txt

    mv tempFile.txt intFile.txt
    rm int.txt
done

mv intFile.txt meas_final.txt  

#combine all measTrj.lammpstrj files here 
nMM=`ls measTrj_* | wc -l`


if [[ ! -e measTrj_final.lammpstrj ]]; then
    touch measTrj_final.lammpstrj
fi

    tail -n +78457 measTrj_$num1 >> measTrj_final.lammpstrj 


rm measTrj_$num1

#post processing to force manual stop goes here 
# all you need to do is create a post processing file for meas_final.txt and when a criteria
# is established we just change stop = 1 here

#numChk=`tail -1 meas_final.txt`
g++ numChk.cpp
./a.out >> log_auto
rm a.out

pe=pe.txt
numChk=`head -1 $pe` # take number from file
 
#stop=0; # 1 = true; 0 = false <--- MANUAL STOP FOR NOW

if [ "$numChk" -lt "-670000" ]; then

   stop=1;

else

   stop=0;

fi

if [ "$stop" == "1" ]; then

num2=$(($num1 + 1)) # and add 1 to it
    
srun lmp -in in.meas > log_meas_$num2 # run one more sub simulation

# back up of measured file
cp meas.txt meas_$num2
cp measTrj.lammpstrj measTrj_$num2

nM=`ls meas_* | wc -l`

rm meas_final.txt  
touch intFile.txt

for (( i=1; i<=$nM; i++ ))
do
    tail -n +4  meas_$i > int.txt

    cat intFile.txt int.txt > tempFile.txt

    mv tempFile.txt intFile.txt
    rm int.txt
done

mv intFile.txt meas_final.txt  

#combine all measTrj.lammpstrj files here 

if [[ ! -e measTrj_final.lammpstrj ]]; then
    touch measTrj_final.lammpstrj
fi

    tail -n +78457 measTrj_$num2 >> measTrj_final.lammpstrj 

    echo "Simulation manually stopped!" 
    rm pe.txt
    exit # <--- leave
fi

# stopping simulation
if [ "$num1" == "$n" ]; then 
    echo "Simulation completed!" 
    rm pe.txt
    
else
    rm $file
    touch $file
    echo $num1 >> $file # new number goes into file
    echo "Submitting again!" 
    sbatch meas.slurm
fi
