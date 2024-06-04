# Homolog_detection

Created by Ching-Ho Chang

Contact hilynano@gmail.com if you have any question.

Please use search_homolog.sbatch for the job submission

search_homolog.sbatch will use tBLASTn and BLASTx to conduct reciprocal BLAST,
It will use merge_del_seq2.pl to merge calls from different exons.
use blast_grep_seq.pl to get candidate sequences, 
use blast_reciprocal.pl to summarize the reciprocal BLASTx result,
and use get_reciprocal_result.pl to collect all results from different species.

For each gene, it will generate a new folder.
The folder will contain BLAST result for each species,
For example, 
D.ananassae_Arp53D.out.simple.out.rep -- summarized reciprocal BLASTx information
D.ananassae_Arp53D.reciprocal.out  -- raw reciprocal BLASTx result
D.ananassae_Arp53D.out.simple.out_reextract.fa
D.ananassae_Arp53D.out.fa  -- Extracted sequences from the genome using tBLASTn results
D.ananassae_Arp53D.out.simple.out --  merge exons for each copy and summarized tBLASTn information
D.ananassae_Arp53D.out   -- raw tBLASTn results




Use grep_synteny.sh (synteny_list.out as your input) if you want to get information for genes upstream and downstream
