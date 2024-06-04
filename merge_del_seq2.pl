open (input_file,"$ARGV[0]");
my @file2 =<input_file> ;
my $length2 = $#file2;
close input_file;
open (OUT,">$ARGV[1].simple.out");
open (OUT2,">$ARGV[1].fa");
open (input_file2,"test1");
$i=1;
$m=1;
$n=1;
$spe=$ARGV[2];
print OUT "species\tgene\tcontig\tstart\tend\tqstart\tqend\tlength\tnumber of fragment\tcount in the contig\n";
while($line2=<input_file2>)
{
@snp=split(/\s+/,$line2);
#$i=1 if ($snp[1] ne $name);
if($snp[1] eq $name && $snp[0] eq $copy && $name )
{
if($snp[9]-$snp[8]>0)
{
#print OUT"$spe\t$copy\t$name\t$snp[6] $end $snp[8] $qend\tdebug\n";
if (($snp[6]-$end>1000  || abs($snp[8] -$qend) >10000 ||$end-$snp[6]>50)&& (abs($snp[8] -$qend)>10 ))
{
$length= abs($qend -$qstart)  ;
print OUT"$spe\t$copy\t$name\t$start\t$end\t$qstart\t$qend\t$length\t$m\t$i\n"  ;
$s=1 if ($qstart>$qend);
$s=0 if ($qstart<$qend);
$seq =  reverse($seq) if $s==1;
$seq =~ tr/atcgATCGRYKMSWrykmsw/tagcTAGCYRMKWSyrmkws/  if $s==1;
print OUT2"$seq";
$seq ="";
print OUT2 "\n\>$spe.$snp[1].$i\n"  ;
$i++;

$start=$snp[6]; 
$end=$snp[7];
$qstart=$snp[8];
$qend=$snp[9];
$copy=$snp[0];
$name=$snp[1];
$m=1;
for $j(0...$length2)
{
next if ($file2[$j]!~/\>(\S+)/);
$file2[$j]=~/\>(\S+)/;
if($1 eq $snp[1] )
{
@sorted_numbers = sort { $a <=> $b }($snp[8],$snp[9]);
$len=length($file2[$j+1]);
$seq = $seq . substr ($file2[$j+1],$sorted_numbers[0]-1,$sorted_numbers[1]-$sorted_numbers[0]+1);
last;
}
}
}
else {
$qend=$snp[9];
$end=$snp[7]; 
$m++;
for $j(0...$length2)
{
next if ($file2[$j]!~/\>(\S+)/);

$file2[$j]=~/\>(\S+)/;
if($1 eq $snp[1] )
{
@sorted_numbers = sort { $a <=> $b }($snp[8],$snp[9]);
$len=length($file2[$j+1]);
$seq = $seq . substr ($file2[$j+1],$sorted_numbers[0]-1,$sorted_numbers[1]-$sorted_numbers[0]+1);
last;
}
}
}
}
elsif($snp[9]-$snp[8]<0 )
{
if (($start-$snp[7]>1000 || abs($snp[9] -$qstart) >10000 ||$snp[7]-$start>50)&& abs($snp[9] -$qstart)>10)
{
$length= abs($qend -$qstart) ;
print OUT"$spe\t$copy\t$name\t$start\t$end\t$qstart\t$qend\t$length\t$m\t$i\n" ;
$s=1 if ($qstart>$qend);
$s=0 if ($qstart<$qend);
$seq =  reverse($seq) if $s==1;
$seq =~ tr/atcgATCGRYKMSWrykmsw/tagcTAGCYRMKWSyrmkws/  if $s==1;
print OUT2"$seq";
$seq ="";
print OUT2 "\n\>$spe.$snp[1].$i\n"  ;
$i++;

$start=$snp[6]; 
$end=$snp[7];
$qstart=$snp[8];
$qend=$snp[9];
$n++;
$m=1;
for $j(0...$length2)
{
next if ($file2[$j]!~/\>(\S+)/);

$file2[$j]=~/\>(\S+)/;
if($1 eq $snp[1] )
{
@sorted_numbers = sort { $a <=> $b }($snp[8],$snp[9]);
$len=length($file2[$j+1]);
$seq = $seq . substr ($file2[$j+1],$sorted_numbers[0]-1,$sorted_numbers[1]-$sorted_numbers[0]+1);
last;
}
}
}
else {
$qstart=$snp[8];
$start=$snp[6]; 
$m++;
for $j(0...$length2)
{
next if ($file2[$j]!~/\>(\S+)/);

$file2[$j]=~/\>(\S+)/;
if($1 eq $snp[1] )
{
@sorted_numbers = sort { $a <=> $b }($snp[8],$snp[9]);
$len=length($file2[$j+1]);
$seq = $seq . substr ($file2[$j+1],$sorted_numbers[0]-1,$sorted_numbers[1]-$sorted_numbers[0]+1);
last;
}
}
}
}

}
elsif ($name) {
$length= abs($qend -$qstart) ;
print OUT"$spe\t$copy\t$name\t$start\t$end\t$qstart\t$qend\t$length\t$m\t$i\n";
$s=1 if ($qstart>$qend);
$s=0 if ($qstart<$qend);
$seq =  reverse($seq) if $s==1;
$seq =~ tr/atcgATCGRYKMSWrykmsw/tagcTAGCYRMKWSyrmkws/  if $s==1;
print OUT2"$seq";
$seq ="";
print OUT2 "\n\>$spe.$snp[1].$i\n"  ;
$i=1;

$start=$snp[6]; 
$end=$snp[7];
$qstart=$snp[8];
$qend=$snp[9];
$copy=$snp[0];
$name=$snp[1];
$m=1;
for $j(0...$length2)
{
next if ($file2[$j]!~/\>(\S+)/);

$file2[$j]=~/\>(\S+)/;
if($1 eq $snp[1] )
{
@sorted_numbers = sort { $a <=> $b }($snp[8],$snp[9]);
$len=length($file2[$j+1]);
$seq = $seq . substr ($file2[$j+1],$sorted_numbers[0]-1,$sorted_numbers[1]-$sorted_numbers[0]+1);
last;
}
}
}
#=cut
if ($n==1)
{

$start=$snp[6];
$end=$snp[7];
$qstart=$snp[8];
$qend=$snp[9];
$copy=$snp[0];
$name=$snp[1];
for $j(0...$length2)
{
next if ($file2[$j]!~/\>(\S+)/);

$file2[$j]=~/\>(\S+)/;
if($1 eq $snp[1] )
{
@sorted_numbers = sort { $a <=> $b }($snp[8],$snp[9]);
$len=length($file2[$j+1]);
$seq = $seq . substr ($file2[$j+1],$sorted_numbers[0]-1,$sorted_numbers[1]-$sorted_numbers[0]+1);
print OUT2 "\>$spe.$snp[1].$i\n"  ;
$i++ if $n >1;
$n++;
last;
}
}
}
if (eof)
{
$length= abs($qend -$qstart) ;
print OUT"$spe\t$copy\t$name\t$start\t$end\t$qstart\t$qend\t$length\t$m\t$i\n";
$s=1 if ($qstart>$qend);
$s=0 if ($qstart<$qend);
$seq =  reverse($seq) if $s==1;
$seq =~ tr/atcgATCGRYKMSWrykmsw/tagcTAGCYRMKWSyrmkws/  if $s==1;
print OUT2"$seq";
$seq ="";
print OUT2 "\n"  ;
last;
}
#=cut
$name=$snp[1];
$copy=$snp[0];
}
