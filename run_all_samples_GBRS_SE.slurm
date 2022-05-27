#!/bin/bash
#SBATCH --job-name=all_gbrs
#SBATCH -p compute # partition (queue)
#SBATCH -q batch 
#SBATCH -N 1 # number of nodes
#SBATCH -n 1 # number of cores
#SBATCH --mem 16GB # memory pool for all cores
#SBATCH -t 1-00:00 # time (D-HH:MM)
#SBATCH --mail-type=ALL
#SBATCH	--mail-user=samantha.ardery@jax.org 
# example use: sbatch --export=ALL,SAMPLELIST="/home/arders/SampleRerun/Scripts/SampleData2.tsv",INPUTDIR="/projects/munger-lab/raw/DO_mESC/Read1",OUTPUTDIR="/projects/munger-lab/SampleReruns/SE_Data" /home/arders/SampleRerun/Scripts/run_all_samples_GBRS_SE.slurm


SAMPLELIST="/home/arders/SampleRerun/Scripts/SampleData.tsv"
INPUTDIR="/projects/munger-lab/raw/DO_mESC/Read1"
OUTPUTDIR="/projects/munger-lab/SampleReruns/SE_Data"
while read p
do
  array=(${p//,/ })
  SAMPLE=${array[0]}
  SEX=${array[1]}
  GENERATION="16" #changing this manually, the samplesheet adds \r for some reason!
  if test -f "$OUTPUTDIR/${SAMPLE}_SE.8-way.transcriptome.bam"; then
    echo "no need to re-submit."
  else
    echo "submitting job."
    sbatch --export=ALL,INDIR="$INPUTDIR",OUTDIR="$OUTPUTDIR",SAMPLE=$SAMPLE,GENERATION=$GENERATION,SEX=$SEX /home/arders/SampleRerun/SE_SampleRerun.slurm
  fi
done < "$SAMPLELIST"

    

