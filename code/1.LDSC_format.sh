#!/usr/bin/bash
python2 "/mnt/e/soft/ldsc/munge_sumstats.py" \
--sumstats  /mnt/e/project/ADHD/raw_data/daner_adhd_meta_filtered_NA_iPSYCH23_PGC11_sigPCs_woSEX_2ell6sd_EUR_Neff_70.meta   \
--out /mnt/e/project/ADHD/FUSION/data/ADHD_clean \
--N 53293
 
python2 "/mnt/e/soft/ldsc/munge_sumstats.py" \
--sumstats  /mnt/e/project/ADHD/raw_data/daner_adhd_meta_filtered_NA_iPSYCH23_PGC11_sigPCs_woSEX_2ell6sd_EUR_Neff_70.meta   \
--out /mnt/e/project/ADHD/FUSION/data/ADHD_clean_w_hm3 \
--merge-alleles /mnt/e/soft/ldsc/reference/w_hm3.snplist \
--N 53293 