# ====================分割线=========================
# 感谢您使用Fast2TWAS
# 如有任何关于该包安装和使用方面的疑问请您务必联系我！(⑅˃◡˂⑅)
# 如果您有关于该包的任何意见和建议请毫不犹豫的联系我！(⑅˃◡˂⑅)
# 1.邮箱：xiechengyong@yeah.net
# 2.b站：https://space.bilibili.com/397473016?spm_id_from=..0.0
# 3.微信号：shengxindazhaxie
# 4.公众号：生信蟹道人
# 5.简书：生信蟹道人
# ====================分割线==========================


#设置当前工作路径
setwd("D:/myproject/mylesson/3.MR_drug_target/06.pre_data/")

#清除一切变量
rm(list=ls())
#释放不再使用的内存
gc()
#显式路径
getwd()
#显示R包安装位置
.libPaths()

#安装包
if (!requireNamespace(c("BiocManager","devtools"),quietly = TRUE)) install.packages("BiocManager","devtools")
if (!requireNamespace("VariantAnnotation", quietly = TRUE))BiocManager::install("VariantAnnotation")
#加载包
library(VariantAnnotation)
library(gwasglue)
library(data.table)
library(Fast2TWAS)
library(TwoSampleMR)

#输入参数
# trait1="BMI"
# inputFile1="ieu-b-40.vcf.gz"

# trait1="LDL"
# inputFile1="ieu-a-300.vcf.gz"

trait1="ENSG00000015520"
inputFile1="eqtl-a-ENSG00000015520.vcf.gz"

#body mass index----------------------------------------------------------------
#输入文件(根据下载暴露数据的文件名称进行修改)
inputFile=inputFile1

#读取输入文件, 并对输入文件进行格式转换
vcfRT <- readVcf(inputFile)
data=gwasvcf_to_TwoSampleMR(vcf=vcfRT, type="exposure")
data=data[,c("chr.exposure",
             "pos.exposure",
             "SNP",
             "effect_allele.exposure",
             "other_allele.exposure",
             "eaf.exposure",
             "beta.exposure",
             "se.exposure",
             "pval.exposure",
             "samplesize.exposure")]
colnames(data)=colnames(show_demo_gwas())
head(data)

#删除maf<0.001
data=subset(data,eaf>0.001&eaf<0.999)

#保存数据
fwrite(data,
       file = paste0(trait1,"_maf0.001.txt"),
       sep = "\t")


 
# #Schizophrenia------------------------------------------------------------------
# inputFile=inputFile2     
# 
# #读取输入文件, 并对输入文件进行格式转换
# vcfRT <- readVcf(inputFile)
# data=gwasvcf_to_TwoSampleMR(vcf=vcfRT, type="exposure")
# data=data[,c("chr.exposure",
#              "pos.exposure",
#              "SNP", 
#              "effect_allele.exposure",
#              "other_allele.exposure",
#              "eaf.exposure",
#              "beta.exposure",
#              "se.exposure",
#              "pval.exposure",
#              "samplesize.exposure")]
# colnames(data)=colnames(show_demo_gwas())
# head(data)
# 
# #删除maf<0.001
# data=subset(data,eaf>0.001&eaf<0.999)
# 
# #保存数据
# fwrite(data,
#        file = paste0(trait2,"_maf0.001.txt"),
#        sep = "\t")
# 

# ====================分割线=========================
# 感谢您使用Fast2TWAS
# 如有任何关于该包安装和使用方面的疑问请您务必联系我！(⑅˃◡˂⑅)
# 如果您有关于该包的任何意见和建议请毫不犹豫的联系我！(⑅˃◡˂⑅)
# 1.邮箱：xiechengyong@yeah.net
# 2.b站：https://space.bilibili.com/397473016?spm_id_from=..0.0
# 3.微信号：shengxindazhaxie
# 4.公众号：生信蟹道人
# 5.简书：生信蟹道人
# ====================分割线==========================


library(vcfR)

trait1="ukb-b-14699"
inputFile1="ukb-b-14699.vcf.gz"


data=read.vcfR(inputFile1)
mergedata=as.data.frame(cbind(data@fix,data@gt))

# 使用separate函数按冒号分割数据
df_new <- separate(mergedata, "UKB-b-14699", into = c("beta","se","LP","eaf","sample_size","ID"), sep = ":")
df_new$pval=10^(-as.numeric(df_new$LP))
df_new=df_new[,c("CHROM","POS","ID","ALT","REF","eaf","beta","se","pval","sample_size")]
colnames(df_new)=colnames(Fast2TWAS::show_demo_gwas())

#保存数据
fwrite(df_new,
       file = paste0(trait1,"_vcfR.maf0.001.txt"),
       sep = "\t")




