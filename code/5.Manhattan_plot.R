#设置路径
setwd("/mnt/e/project/ADHD/FUSION/")
getwd()
#设置包的安装路径
.libPaths()
#.libPaths("/home/ps/R/x86_64-pc-linux-gnu-library/4.2")

#设置镜像
options()$repos  ## 查看使用install.packages安装时的默认镜像
options()$BioC_mirror ##查看使用bioconductor的默认镜像
options(BioC_mirror="https://mirrors.ustc.edu.cn/bioc/") ##指定镜像，这个是中国科技大学镜像
options("repos" = c(CRAN="https://mirrors.tuna.tsinghua.edu.cn/CRAN/")) ##指定install.packages安装镜像，这个是清华镜像


#设置包的安装路径
.libPaths()
.libPaths("/home/ps/R/x86_64-pc-linux-gnu-library/4.2/")

#LoadPackage
library(qqman)
library("RColorBrewer")
library(gridGraphics)

#Setting the Color
chr_col<-c(rep(brewer.pal(8, "Dark2"),3))
colorset <- c('#FF0000', '#FFD700', '#2E8B57', '#7FFFAA', '#6495ED', '#0000FF', '#FF00FF')


# TWAS-Manhattan----------------------------------------------------------------
#Read in data
mydata <- read.table("./result/Joint-conditional-tests/GWAS_UKB_finn_Multiple_Sclerosis_metal_final_cleand.GTExv8.ALL.GW", header = T,stringsAsFactor=F,fill=TRUE)

#plotting
#pdf("colorectal_cancer_PP_GWAS.pdf", width=8, height=4)
manhattan(
  mydata,
  chr = "CHR",
  bp = "P0",
  p = "TWAS.P",
  col = chr_col,
  # col=colorset,
  snp = "ID",
  #main = "Manhattan Plot",
  ylab = '-log10(P-value)',
  ylim = c(0, 200),
  genomewideline = -log10(7.114298e-07),
  suggestiveline = -log10(7.114298e-07),
  #annotatePval = 7.114298e-07,
  annotateTop = FALSE,
  logp = TRUE
)

# Zoom in on gene name
grid.echo()
labels <- grid.grep("text", grep=TRUE)
grid.edit(labels, gp=gpar(cex=.8))
#dev.off()

#Z-score_plot
#Calculate power.Z
mydata$power.Z <- as.numeric(10^(-mydata$TWAS.Z))
head(mydata) 

#plotting
#pdf("colorectal_cancer_PP_Z-score.pdf", width=8, height=4)
manhattan(
  mydata,
  chr = "CHR",
  bp = "P0",
  p = "power.Z",
  col = chr_col,
  # col=colorset,
  snp = "ID",
  main = "Manhattan Plot",
  ylab = 'Z-score',
  ylim = c(-10, 10),
  genomewideline = 4.86,
  suggestiveline = -4.86,
  annotatePval = 1.37521E-05,
  annotateTop = T,
  logp = TRUE
)

# Zoom in on gene name
grid.echo()
labels <- grid.grep("text", grep=TRUE)
grid.edit(labels, gp=gpar(cex=.8))
#dev.off()






#设置包的安装路径
.libPaths()
.libPaths("/home/ps/R/x86_64-pc-linux-gnu-library/4.2/")

#Setting the path
setwd("/home/ps/data1/axdty/FUSION/")
getwd()

#LoadPackage
library(qqman)
library("RColorBrewer")
library(gridGraphics)

#Setting the Color
chr_col<-c(rep(brewer.pal(8, "Dark2"),3))
colorset <- c('#FF0000', '#FFD700', '#2E8B57', '#7FFFAA', '#6495ED', '#0000FF', '#FF00FF')


# TWAS-Manhattan----------------------------------------------------------------
#Read in data
mydata <- read.table("./result/Joint-conditional-tests/GWAS_UKB_finn_Multiple_Sclerosis_metal_final_cleand.GTExv8.ALL.GW", header = T,stringsAsFactor=F,fill=TRUE)

#plotting
#pdf("colorectal_cancer_PP_GWAS.pdf", width=8, height=4)
manhattan(
  mydata,
  chr = "CHR",
  bp = "P0",
  p = "TWAS.P",
  col = chr_col,
  # col=colorset,
  snp = "ID",
  #main = "Manhattan Plot",
  ylab = '-log10(P-value)',
  ylim = c(0, 200),
  genomewideline = -log10(7.114298e-07),
  suggestiveline = -log10(7.114298e-07),
  #annotatePval = 7.114298e-07,
  annotateTop = FALSE,
  logp = TRUE
)

# Zoom in on gene name
grid.echo()
labels <- grid.grep("text", grep=TRUE)
grid.edit(labels, gp=gpar(cex=.8))
#dev.off()

#Z-score_plot
#Calculate power.Z
mydata$power.Z <- as.numeric(10^(-mydata$TWAS.Z))
head(mydata) 

#plotting
#pdf("colorectal_cancer_PP_Z-score.pdf", width=8, height=4)
manhattan(
  mydata,
  chr = "CHR",
  bp = "P0",
  p = "power.Z",
  col = chr_col,
  # col=colorset,
  snp = "ID",
  main = "Manhattan Plot",
  ylab = 'Z-score',
  ylim = c(-10, 10),
  genomewideline = 4.86,
  suggestiveline = -4.86,
  annotatePval = 1.37521E-05,
  annotateTop = T,
  logp = TRUE
)

# Zoom in on gene name
grid.echo()
labels <- grid.grep("text", grep=TRUE)
grid.edit(labels, gp=gpar(cex=.8))
#dev.off()





