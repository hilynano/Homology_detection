open (input_file,"$ARGV[0]");
open (OUT,">test1");
$name=$ARGV[1];
$species=$ARGV[2];
$ortho=0;
while($line=<input_file>)
{
chomp($line);
@value=split(/\s+/,$line);
if ($value[10] eq $name)
{
print OUT "$value[0]\t$value[1]\t$value[2]\n" ;
$ortho++;
}
}
close OUT;
`sort -n test1 | uniq -c | sed 's/^ \\+//' >> $name.summary.out`;
`echo "0\t$species\t$name\tNA" >> $name.summary.out` if ($ortho ==0);
