##From a file with columns ASV id, fasta, abundances per sample (each sample a column) named phylogenetic.txt


##sepparate the file, creating one for each sample, each containing the ASVid, the fasta and the abundances for the sample (3 columns)
awk 'BEGIN{FS=OFS="\t"}{for(i=3;i<=NF;i++){name=i".file";print $1, $2, $i> name}}' phylogenetic.txt

#for each file, extract the sequences from those ASV with abundances >0, and convert them into a fasta file.
for f in *.file; do
awk '$3>0 {print $2 >> "short"FILENAME}' $f
awk '{print ">seq " ++count ORS $0 >> FILENAME".fasta"}'  short$f
done

#for each fasta, use megacc to get the average distance for each sample; you would need to create the mao file in windows using MEGAX.

for f in *.fasta; do
megacc -a  -f Fasta -d $f -o $f.avedist.txt
done
