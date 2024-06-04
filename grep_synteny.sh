# Extract the result from the homology search

while read up gene down; do
echo "$up gene $down"
awk -v name="$up"  '($11==name) {print $1"\t"$2"\t"$3"\t"$6"\t"$7}' $up/*_$up.out.simple.out.rep |sort -n  | awk '!x[$3]++' >>"$gene"synteny_reciprocal_blast_result.out
awk -v name="$gene" '($11==name) {print $1"\t"$2"\t"$3"\t"$6"\t"$7}' $gene/*_$gene.out.simple.out.rep |sort -n  | awk '!x[$3]++' >>"$gene"synteny_reciprocal_blast_result.out
awk -v name="$down"  '($11==name) {print $1"\t"$2"\t"$3"\t"$6"\t"$7}' $down/*_$down.out.simple.out.rep |sort -n  | awk '!x[$3]++' >>"$gene"synteny_reciprocal_blast_result.out
done < synteny_list.out


