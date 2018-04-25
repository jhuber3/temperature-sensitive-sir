#!/bin/csh
#$ -pe smp 1
#$ -t 1-50:1
#$ -q long
#$ -N testarray

./simulations ${SGE_TASK_ID}




