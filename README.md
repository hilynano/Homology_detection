# Homolog_detection

Please use search_homolog.sbatch for the job submission

For each gene, it will generate a new folder.
The folder will contain BLAST result for each species,
For example, 
D.ananassae_Arp53D.out.simple.out.rep -- summaried reciprocal BLASTx information
D.ananassae_Arp53D.reciprocal.out  -- raw reciprocal BLASTx result
D.ananassae_Arp53D.out.simple.out_reextract.fa
D.ananassae_Arp53D.out.fa  -- Extracted sequences from the genome using tBLASTn results
D.ananassae_Arp53D.out.simple.out --  merge exons for each copy and summaried tBLASTn information
D.ananassae_Arp53D.out   -- raw tBLASTn results


Use grep_synteny.sh if you want to get information for genes upstream and downstream
