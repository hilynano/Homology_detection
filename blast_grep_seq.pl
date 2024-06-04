open (input_file,"$ARGV[0]");
my @file2 =<input_file> ;
my $length2 = $#file2;
close input_file;
my $stream=300;
open (OUT,">$ARGV[1]_reextract.fa");
$i=1;
$m=1;
$n=1;
$spe=$ARGV[1];
open (input_file,"$spe");
while($line=<input_file>)
{
@snp=split(/\s+/,$line);
next if $line =~ /species/;
$contig=$snp[2];
for $j(0...$length2)
{
next if ($file2[$j]!~/\>(\S+)/);
$file2[$j]=~/\>(\S+)/;
if($1 eq $contig )
{
$start=$snp[5];
$end=$snp[6];
$s=1 if ($start>$end);
$s=0 if ($start<$end);
@sorted_numbers = sort { $a <=> $b }($start,$end);
$len=length($file2[$j+1]);
print "$name $len $start $end\n";
$sorted_numbers[0] =$stream+1 if $sorted_numbers[0]+1-$stream <0;
$seq = substr ($file2[$j+1],$sorted_numbers[0]+1-$stream,$sorted_numbers[1]-$sorted_numbers[0]+$stream*2);
$seq =  reverse($seq) if $s==1;
$seq =~ tr/atcgATCGRYKMSWrykmsw/tagcTAGCYRMKWSyrmkws/  if $s==1;
$start=$sorted_numbers[0]+1-$stream*2;
$end=$$sorted_numbers[1]+$stream*2;
print OUT ">$snp[0].$contig.$sorted_numbers[0]\n";
print OUT "$seq\n";
last;
}

}
}
