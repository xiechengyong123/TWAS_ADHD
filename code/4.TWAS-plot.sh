#!/bin/bash
#Creates locus plots for TWAS-Z
Rscript  "/mnt/e/soft/TWAS-plotter/TWAS-plotter.V1.0.r"   \
--twas /mnt/e/project/ADHD/FUSION/result/Joint-conditional-tests/ADHD_clean.GW  \
--output /mnt/e/project/ADHD/FUSION/result/Joint-conditional-tests/ADHD_clean.GW_TWAS_Z_plot \
--sig_p 4.97e-07

#Creates locus plots for TWAS loci
# Run TWAS-locus-plotter for all chromomsomes with significant features
for chr in $(seq 1 22); do
  for weights in  CMC.BRAIN.RNASEQ2  CMC.BRAIN.RNASEQ_SPLICING2  GTExv8.ALL.Brain_Amygdala	GTExv8.ALL.Brain_Anterior_cingulate_cortex_BA24	GTExv8.ALL.Brain_Caudate_basal_ganglia	GTExv8.ALL.Brain_Cerebellar_Hemisphere	GTExv8.ALL.Brain_Cerebellum	GTExv8.ALL.Brain_Cortex	GTExv8.ALL.Brain_Frontal_Cortex_BA9	GTExv8.ALL.Brain_Hippocampus	GTExv8.ALL.Brain_Hypothalamus	GTExv8.ALL.Brain_Nucleus_accumbens_basal_ganglia	GTExv8.ALL.Brain_Putamen_basal_ganglia	GTExv8.ALL.Brain_Spinal_cord_cervical_c-1	GTExv8.ALL.Brain_Substantia_nigra ; do
    status=$(awk -v var="${chr}" '$4 == var {print "Present";exit;}' /mnt/e/project/ADHD/FUSION/result/Joint-conditional-tests/ADHD_clean.GW.Sig)
    if [ "$status" == "Present" ]; then
         Rscript "/mnt/e/soft/TWAS-plotter/TWAS-locus-plotter.V1.0.r" \
            --twas /mnt/e/project/ADHD/FUSION/result/Joint-conditional-tests/ADHD_clean.GW.Sig \
            --pos /mnt/e/soft/fusion_twas-master/reference/GTExv8.ALL/${weights}.pos \
            --post_proc_prefix /mnt/e/project/ADHD/FUSION/result/Joint-conditional-tests/ADHD_clean.GW.Sig.${chr} \
            --window 0.5e6 \
            --gene_loc "/mnt/e/soft/fusion_twas-master/glist-hg19"
    fi
  done
done          