# perl D.melanogaster_tHMG.reciprocal.out D.melanogaster_tHMG.out.simple.out

open (input_file1,"$ARGV[0]");
while($line=<input_file1>)
{
chomp($line);
@blast=split(/\s+/,$line);
#D.bipectinata.contig_38.51183   FBpp0083651     45.205  73      40      0       5       223     4       76      1.83e-17
${$blast[0]}="$blast[1]\t$blast[10]";
#print "$blast[0] ${$blast[0]}\n";
}
open (OUT,">$ARGV[1].rep");
open (input_file2,"$ARGV[1]");

$n=0;
while($line=<input_file2>)
{
chomp($line);
#D.bipectinata   tHMG_Dsim       contig_38       2       78      51183   51413   230     1       1
@output=split(/\s+/,$line);
@sorted_numbers = sort { $a <=> $b }($output[5],$output[6]);
$name="$output[0]\.$output[2]\.$sorted_numbers[0]";
${$name}="Besthit\tevalue" if $output[0] eq 'species';
#print "$name ${$name}\n";

#print  "$line\t${$output[0].$output[2].$sorted_numbers[0]}\t${$name}\n";
print OUT "$line\t${$output[0].$output[2].$sorted_numbers[0]}\t${$name}\n";


}
