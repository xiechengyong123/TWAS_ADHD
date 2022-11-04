#!/bin/bash
# Combine per chromomsome TWAS results
head -1 /mnt/e/project/ADHD/FUSION/result/ADHD_clean.CMC.BRAIN.RNASEQ2.chr1.dat > /mnt/e/project/ADHD/FUSION/result/Joint-conditional-tests/ADHD_clean.GW
tail -n +2 -q /mnt/e/project/ADHD/FUSION/result/ADHD_clean.* >>  /mnt/e/project/ADHD/FUSION/result/Joint-conditional-tests/ADHD_clean.GW

x=4.97e-07
cat /mnt/e/project/ADHD/FUSION/result/Joint-conditional-tests/ADHD_clean.GW | awk -v var="${x}" 'NR == 1 || $20 < var' > /mnt/e/project/ADHD/FUSION/result/Joint-conditional-tests/ADHD_clean.GW.Sig

for chr in $(seq 1 22); do
    status=$(awk -v var="${chr}" '$4 == var {print "Present";exit;}' /mnt/e/project/ADHD/FUSION/result/Joint-conditional-tests/ADHD_clean.GW.Sig)
    if [ "$status" == "Present" ]; then
       Rscript "/mnt/e/soft/fusion_twas-master/FUSION.post_process.R"  \
            --input /mnt/e/project/ADHD/FUSION/result/Joint-conditional-tests/ADHD_clean.GW.Sig \
            --sumstats "/mnt/e/project/ADHD/FUSION/data/ADHD_clean.sumstats.gz" \
            --ref_ld_chr /mnt/e/soft/fusion_twas-master/reference/LDREF/1000G.EUR. \
            --out /mnt/e/project/ADHD/FUSION/result/Joint-conditional-tests/ADHD_clean.GW.Sig.${chr} \
            --chr ${chr} \
            --save_loci \
            --plot \
            --report \
            --plot_legend all \
            --locus_win 1000000
    fi
done