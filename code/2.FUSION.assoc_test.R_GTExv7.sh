#!/bin/bash
for chr in $(seq 1 22); do
  for weights in Brain_Amygdala	Brain_Anterior_cingulate_cortex_BA24	Brain_Caudate_basal_ganglia	Brain_Cerebellar_Hemisphere	Brain_Cerebellum	Brain_Cortex	Brain_Frontal_Cortex_BA9	Brain_Hippocampus	Brain_Hypothalamus	Brain_Nucleus_accumbens_basal_ganglia	Brain_Putamen_basal_ganglia	Brain_Spinal_cord_cervical_c-1	Brain_Substantia_nigra	CMC.BRAIN.RNASEQ2	CMC.BRAIN.RNASEQ_SPLICING2 ;do
Rscript /mnt/e/soft/fusion_twas-master/FUSION.assoc_test.R \
--sumstats "/mnt/e/project/ADHD/FUSION/data/ADHD_clean.sumstats.gz" \
--weights /mnt/e/soft/fusion_twas-master/reference/GTExv7.ALL/WEIGHTS/${weights}.pos \
--weights_dir /mnt/e/soft/fusion_twas-master/reference/GTExv7.ALL/WEIGHTS/ \
--ref_ld_chr /mnt/e/soft/fusion_twas-master/reference/LDREF/1000G.EUR. \
--chr $chr \
--coloc_P 0.05 \
--GWASN 53293 \
--perm 100000 \
--out /mnt/e/project/ADHD/FUSION/result_GTExv7/ADHD_clean.${weights}.chr$chr.dat;
  done
done
