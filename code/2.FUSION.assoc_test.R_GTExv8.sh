#!/bin/bash
for chr in $(seq 1 22); do
  for weights in CMC.BRAIN.RNASEQ2  CMC.BRAIN.RNASEQ_SPLICING2  GTExv8.ALL.Brain_Amygdala	GTExv8.ALL.Brain_Anterior_cingulate_cortex_BA24	GTExv8.ALL.Brain_Caudate_basal_ganglia	GTExv8.ALL.Brain_Cerebellar_Hemisphere	GTExv8.ALL.Brain_Cerebellum	GTExv8.ALL.Brain_Cortex	GTExv8.ALL.Brain_Frontal_Cortex_BA9	GTExv8.ALL.Brain_Hippocampus	GTExv8.ALL.Brain_Hypothalamus	GTExv8.ALL.Brain_Nucleus_accumbens_basal_ganglia	GTExv8.ALL.Brain_Putamen_basal_ganglia	GTExv8.ALL.Brain_Spinal_cord_cervical_c-1	GTExv8.ALL.Brain_Substantia_nigra;do
Rscript /mnt/e/soft/fusion_twas-master/FUSION.assoc_test.R \
--sumstats "/mnt/e/project/ADHD/FUSION/data/ADHD_clean.sumstats.gz" \
--weights /mnt/e/soft/fusion_twas-master/reference/GTExv8.ALL/${weights}.pos \
--weights_dir /mnt/e/soft/fusion_twas-master/reference/GTExv8.ALL/ \
--ref_ld_chr /mnt/e/soft/fusion_twas-master/reference/LDREF/1000G.EUR. \
--chr $chr \
--coloc_P 0.05 \
--GWASN 53293 \
--perm 100000 \
--out /mnt/e/project/ADHD/FUSION/result/ADHD_clean.${weights}.chr$chr.dat;
  done
done
