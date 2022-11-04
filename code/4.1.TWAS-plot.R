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

#delete data
rm(list=ls())

# Load libraries
suppressMessages(library(data.table))
suppressMessages(library(ggrepel))
suppressMessages(library(ggplot2))
suppressMessages(library(cowplot))

# Read in the TWAS data
twas<-data.frame(fread("./result/Joint-conditional-tests/ADHD_clean.GW"))

# Create plotting function
TWAS_manhattan = function(dataframe,
                          title = NULL,
                          ylimit = max(abs(dataframe$TWAS.Z), na.rm = T) + 1,
                          Sig_Z_Thresh = qnorm(1 - (0.05 / length(dataframe$TWAS.Z)) / 2)) {
  d = dataframe[order(dataframe$CHR, dataframe$P0), ]
  d = d[!is.na(d$TWAS.P), ]
  
  d$pos = NA
  ticks = NULL
  lastbase = 0
  numchroms = length(unique(d$CHR))
  
  for (i in unique(d$CHR)) {
    if (i == 1) {
      d[d$CHR == i,]$pos = d[d$CHR == i,]$P0
    }       else {
      lastbase = lastbase + tail(subset(d, CHR == i - 1)$P0, 1)
      d[d$CHR == i,]$pos = d[d$CHR == i,]$P0 + lastbase
    }
    ticks = c(ticks, d[d$CHR == i,]$pos[floor(length(d[d$CHR == i,]$pos) /
                                                2) + 1])
  }
  
  ticklim = c(min(d$pos), max(d$pos))
  
  mycols = rep(c("gray35", "gray72"), 60)
  
  d$Sig_Z_Thresh <- Sig_Z_Thresh
  
  d_sig <- d[which(abs(d$TWAS.Z) > d$Sig_Z_Thresh), ]
  d_sig <- d_sig[rev(order(abs(d_sig$TWAS.Z))), ]
  d_sig <- d_sig[!duplicated(d_sig$ID), ]
  
  if (sum(d_sig$TWAS.Z > 0) > 0) {
    d_sig_pos <- d_sig[d_sig$TWAS.Z > 0, ]
  }
  
  if (sum(d_sig$TWAS.Z < 0) > 0) {
    d_sig_neg <- d_sig[d_sig$TWAS.Z < 0, ]
  }
  
  chr_labs <- as.character(unique(d$CHR))
  chr_labs[chr_labs == '19' | chr_labs == '21'] <- ' '
  
  if (dim(d_sig)[1] == 0) {
    p <- ggplot(d, aes(
      x = pos,
      y = TWAS.Z,
      colour = factor(CHR)
    )) +
      geom_point(size = 0.5) +
      scale_x_continuous(name = "Chromosome",
                         breaks = ticks,
                         labels = chr_labs) +
      scale_y_continuous(name = 'Z score', limits = c(-ylimit, ylimit)) +
      scale_colour_manual(values = mycols, guide = FALSE) +
      geom_hline(yintercept = 0, colour = "black") +
      geom_hline(yintercept = Sig_Z_Thresh, colour = "blue") +
      geom_hline(yintercept = -Sig_Z_Thresh, colour = "blue")
    
  } else {
    p <- ggplot(d, aes(
      x = pos,
      y = TWAS.Z,
      colour = factor(CHR)
    )) +
      geom_point(size = 0.5) +
      scale_x_continuous(name = "Chromosome",
                         breaks = ticks,
                         labels = chr_labs) +
      scale_y_continuous(name = 'Z score', limits = c(-ylimit, ylimit)) +
      scale_colour_manual(values = mycols, guide = FALSE) +
      geom_hline(yintercept = 0, colour = "black") +
      geom_hline(yintercept = Sig_Z_Thresh, colour = "blue") +
      geom_hline(yintercept = -Sig_Z_Thresh, colour = "blue") +
      geom_point(
        data = d_sig,
        aes(x = pos, y = TWAS.Z),
        colour = "red",
        fill = 'red',
        size = 1.5
      )
    
    if (sum(d_sig$TWAS.Z > 0) > 0) {
      p <-
        p + geom_text_repel(
          data = d_sig_pos,
          aes(x = pos, y = TWAS.Z, label = ID),
          colour = 'black',
          nudge_y = 1,
          size = 2.5,
          force = 5,
          segment.alpha = 0.25,
          ylim = c(Sig_Z_Thresh + 0.1, NA)
        )
    }
    
    if (sum(d_sig$TWAS.Z < 0) > 0) {
      p <-
        p + geom_text_repel(
          data = d_sig_neg,
          aes(x = pos, y = TWAS.Z, label = ID),
          colour = 'black',
          nudge_y = -1,
          size = 2.5,
          force = 5,
          segment.alpha = 0.25,
          ylim = c(NA, -Sig_Z_Thresh - 0.1)
        )
    }
  }
  
  p <- p +
    theme_cowplot() +
    theme(axis.text.x = element_text(
      angle = 45,
      size = 8,
      hjust = 1
    ))
  
  p
}


# Make plot
pdf(paste0("./result/Joint-conditional-tests/ADHD_clean_Z_plot",'.pdf'), width=10, height=6)
print(TWAS_manhattan(dataframe=twas))
dev.off()


# if(!is.na(opt$sig_z)){
#   png(paste0(opt$output,'.png'), unit='px', res=opt$res, width = opt$width, height = opt$height)
#   print(TWAS_manhattan(dataframe=twas, Sig_Z_Thresh=opt$sig_z))
#   dev.off()
# }
# if(!is.na(opt$sig_p)){
#   png(paste0(opt$output,'.png'), unit='px', res=opt$res, width = opt$width, height = opt$height)
#   print(TWAS_manhattan(dataframe=twas, Sig_Z_Thresh=qnorm(1 - opt$sig_p)))
#   dev.off()
# }
# if(is.na(opt$sig_p) & is.na(opt$sig_z)){
#   png(paste0(opt$output,'.png'), unit='px', res=opt$res, width = opt$width, height = opt$height)
#   print(TWAS_manhattan(dataframe=twas))
#   dev.off()
# }


      


