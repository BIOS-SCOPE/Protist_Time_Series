#Linux version
#Using mothur v.1.43.0
#make contigs with the file created according to mothur instructions; no need to trim overlaps, since these are preprocessed files and F & R are identical, assembled using MeFit
make.contigs(file=protist.time, deltaq=10, insert=30, trimoverlap=F)
summary.seqs(fasta=current)
#remove short reads, or those with any ambiguity or excess of homopolymers - in two steps
screen.seqs(fasta=current, group=current, maxambig=0, maxhomop=10, contigsreport=current)
summary.seqs(fasta=current)
screen.seqs(fasta=current, group=current, minlength=300)
summary.seqs(fasta=current)
#align to the V4-trimmed PR2 database
align.seqs(candidate=current, template=/home/CAM/leocadio/BIOSSCOPE/protist/V4/V4.fas)
#after checking the alingment, cutting those sequences with bases beyond the end of V4 (likely sequencing errors)
pcr.seqs(fasta=current, group=current, keepdots=false, start=0, end=8576)
#removing all sequences that do not reach the end of V4
screen.seqs(fasta=current, group=current, end=8576)
#removing all sequences that do not start at the beginning of V4
screen.seqs(fasta=current, group=current, start=1)
summary.seqs(fasta=current)
#removing sequences that after the process got shorter than 300 bp (if any)
screen.seqs(fasta=current, group=current, minlength=300)
#create unique
unique.seqs(fasta=current)
#once unique are created, it is important to keep the name command now on
summary.seqs(fasta=current, name=current)
#save all current files - intermediate point
get(current)
#remove chimeras with vsearch
chimera.vsearch(fasta=current, name=current, group=current, dereplicate=f)
remove.seqs(fasta=current, accnos=current, group=current, name=current, dups=t)
summary.seqs(fasta=current, name=current)
#pre.cluster with uniose as implemented in mothur to remove PCR errors - results are Single variants
pre.cluster(fasta=current,  name=current, group=current, diffs=1, method=unoise)
#inflate the count file - be sure mothur is picking the precluster.count file
count.seqs(count=current, compress=f)
#degap sequences fromt the precluster originated fasta, and classify them using the PR2 database trimmed to V4
degap.seqs(fasta=current)
classify.seqs(fasta=current, template=/home/CAM/leocadio/BIOSSCOPE/protist/V4/V4.ng.fasta, taxonomy=/home/CAM/leocadio/BIOSSCOPE/protist/V4/TaxV4.tax)
quit()
