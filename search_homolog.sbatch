#!/bin/bash
#
#SBATCH --job-name blast
#SBATCH --cpus-per-task=4
#SBATCH --time=5:00:00
#SBATCH --partition=campus-new 
#SBATCH --mem-per-cpu=2g

module load BLAST+

#file of your seq list, if you have too many genes, you can submit a array job.
#list=$(sed -n "$SLURM_ARRAY_TASK_ID"p job)
#echo $list

list='list'


#please setup your blast parameters here
blast='tblastn'
blast_evalue=1
evalue=0.01
identity=20
score=10


#search homolog for each gene
while read name; do

#make a folder for each gene
mkdir $name
cd $name

#search homolog for each species, the blast database should be listed in blastdb.out
#blastdb.out format
#blastdb/C.costata.blastdb
#blastdb/D.acanthoptera.blastdb

while read species; do
species_name=`echo $species|sed 's/.blastdb//g' |sed 's/blastdb\///g'`
echo ""$species_name"_$name.out"

#Run Blast
$blast -db $species -query ../$name.fa -outfmt 6 -out "$species_name"_$name.out -evalue $blast_evalue -num_threads $SLURM_CPUS_PER_TASK

#Filter Blast result
awk '$11<'$evalue' {print}' "$species_name"_$name.out | awk '$3>'$identity' {print}' | awk '$12>'$score' {print}' |sort -nk9,9  | sort -s -k 2,2 > test1

#Extract sequences in genome using BLAST results, and try to merge exons.
#Please use fasta files with one sequence per line
perl merge_del_seq2.pl oneline_fasta/"$species_name".fasta "$species_name"_$name.out $species_name

#Extract sequences in genome, including introns
perl blast_grep_seq.pl "$species_name".fasta "$species_name"_$name.out.simple.out

#Reciprocal BLAST results, create a protein database with one gene-one translation sequence (dmel_nonred_translation.fasta )
blastx -query "$species_name"_$name.out.simple.out_reextract.fa  -db dmel_nonred_translation.fasta -outfmt 6 -out "$species_name"_$name.out -evalue 1 -num_threads $SLURM_CPUS_PER_TASK -max_target_seqs 1

#Summarize Reciprocal BLAST result
perl  blast_reciprocal.pl "$species_name"_$name.reciprocal.out "$species_name"_$name.out.simple.out

#Summarize BLAST results for all species
perl get_reciprocal_result.pl "$species_name"_$name.out.simple.out.rep $name $species_name

done < blastdb.out
cd .. 
done < list

