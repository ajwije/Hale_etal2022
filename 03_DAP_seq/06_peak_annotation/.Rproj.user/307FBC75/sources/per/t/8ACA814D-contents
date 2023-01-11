library(GenomicFeatures)
library(ChIPseeker)
library(rtracklayer)
library(ggvenn)
library(tidyverse)
library(dplyr)
library(ggpubr)
theme_set(theme_pubr())
gffFile <- "Gmax_508_Wm82.a4.v1.gene.gff3"
txdb.filename <- "Gmax_508_Wm82.a4.v1.gene.sqlite"
txdb <- makeTxDbFromGFF(file=gffFile)
saveDb(txdb, txdb.filename)
txdb <- loadDb(txdb.filename)
genes(txdb)
extraCols_narrowPeak <- c(FoldChange="numeric", pVal="numeric",
                          qVal="numeric", summit="integer")
M1_peaks <- import.bed("M1_peaks.narrowPeak", extraCols=extraCols_narrowPeak)
M1_peaks <- readPeakFile("M1_peaks.narrowPeak")
M1_peaks
covplot(M1_peaks, weightCol="V5")
M1_peakAnno <- annotatePeak(M1_peaks, tssRegion=c(-3000, 3000),
                         TxDb=txdb)

M1_peakAnnodf <- as.data.frame(M1_peakAnno@anno)
M1_peakAnnodf
peakP1 <- readPeakFile(samplefiles[[3]])
samplefiles <- list.files("data", pattern= ".narrowPeak", full.names=T)
samplefiles <- as.list(samplefiles)
names(samplefiles) <- c("M1", "M4", "P1", "P4", "SRR13197372", "SRR13197373", "W4", "W6")
peakAnnoList <- lapply(samplefiles, annotatePeak, TxDb=txdb, 
                       tssRegion=c(-1000, 1000), verbose=FALSE)
peakAnnoList
P1_bar <- plotAnnoBar(peakAnnoList[["P1"]])

plotDistToTSS(peakAnnoList, title="Distribution of transcription factor-binding loci \n relative to TSS")

M1_annotdf <- data.frame(peakAnnoList[["M1"]]@anno)

sample_names <- c("M1", "M4", "P1", "P4","SRR13197372", "SRR13197373", "W4", "W6")


for(i in (sample_names)){
  anno_df <- paste(i, "_annotdf", sep = "")
  anno_df <- data.frame(peakAnnoList[[i]]@anno)
  out_filename <- paste("20220825",i, "_annotdf.csv", sep = "")
  write.csv(data.frame(anno_df),file=out_filename)
}

#########M1", "P1", "SRR13197372", "SRR13197373" heatmap
promoter <- getPromoters(TxDb=txdb, upstream=1000, downstream=1000)
tagMatrixList <- lapply(samplefiles[c("M1", "P1", "SRR13197372", "SRR13197373")], getTagMatrix, windows=promoter)
plotAvgProf(tagMatrixList, xlim=c(-1000, 1000), conf=0.95,resample=500, facet="row")
png("/Users/aselawijeratne/Documents/Projects/Soy_RNAseq/20210428_RNAseq/GO/Data/fig/20220802_tagHeatmap.jpg", 
    width = 8, height = 12, units = "in", pointsize = 12, res=300)
# 2. Create the plot
tagHeatmap(tagMatrixList, xlim=c(-1000, 1000), color=NULL, 
           title = c("GmWRKY30 Mock", "GmWRKY30 Pathogen", "RAV rep1", "RAV rep2"))
# 3. Close the file
dev.off()


####################W4 and W6 tag heatmap
promoter <- getPromoters(TxDb=txdb, upstream=1000, downstream=1000)
tagMatrixListW4_W6 <- lapply(samplefiles[c("W4", "W6")], getTagMatrix, windows=promoter)
plotAvgProf(tagMatrixListW4_W6, xlim=c(-1000, 1000), conf=0.95,resample=500, facet="row")
png("/Users/aselawijeratne/Documents/Projects/Soy_RNAseq/20210428_RNAseq/GO/Data/fig/20220816_tagHeatmapW4_W6.jpg", 
    width = 8, height = 12, units = "in", pointsize = 12, res=300)
# 2. Create the plot
tagHeatmap(tagMatrixListW4_W6, xlim=c(-1000, 1000), color=NULL, 
           title = c("GmMYB61", "GmWRKY2"))
# 3. Close the file
dev.off()





plotPeakProf2(samplefiles, upstream = rel(0.2), downstream = rel(0.2),
              conf = 0.95, by = "gene", type = "body",
              TxDb = txdb, facet = "row", nbin = 800)
plotAnnoBar(M1_peaks)
gene <- seq2gene(M1_peaks, tssRegion = c(-1000, 1000), flankDistance = 1000, TxDb=txdb)

RAV_listPromoter <- list(
  RAV_name1 = subset(data.frame(peakAnnoList[["SRR13197372"]]), annotation == "Promoter")[, "geneId"], 
  RAV_name2 = subset(data.frame(peakAnnoList[["SRR13197373"]]), annotation == "Promoter")[, "geneId"]
  
)

###Unique RAV promoters
Uniq_RAV_promoters <- unique(unlist(RAV_listPromoter, use.names = FALSE))

###RAV promoters


###WRKY promoters
M1_P1_listPromoter <- list(
  M1_names = subset(data.frame(peakAnnoList[["M1"]]), annotation == "Promoter")[, "geneId"], 
  P1_names = subset(data.frame(peakAnnoList[["P1"]]), annotation == "Promoter")[, "geneId"]

)


ggvenn(
  M1_P1_listPromoter, 
  fill_color = c("#0073C2FF", "#EFC000FF"),
  stroke_size = 0.5, set_name_size = 4
)

### combine RAV and WRKY promoter lists
combined_WRKY_RAV_promoters <- append(M1_P1_listPromoter, list(Uniq_RAV_promoters))
names(combined_WRKY_RAV_promoters)[3] <- "RAV"


ggvenn(
  combined_WRKY_RAV_promoters, 
  fill_color = c("#0073C2FF", "#EFC000FF", "#868686FF"),
  stroke_size = 0.5, set_name_size = 4
)




###get DE genes
table_path <- "/Users/aselawijeratne/Documents/Projects/Soy_RNAseq/20210428_RNAseq/GO/Data/tables/"

path_to_DE <- "/Users/aselawijeratne/Documents/Projects/Soy_RNAseq/20210428_RNAseq/GO/Data/tables/20220621_DEseq_norm_lin_TF.csv" 
DEseq_norm_lin_TF <- read.csv(path_to_DE, stringsAsFactors=TRUE)
###annotate DE with binding data
row.names(DEseq_norm_lin_TF) <- DEseq_norm_lin_TF$geneId

DEseq_norm_lin_TF_DAP <- DEseq_norm_lin_TF %>%
  
  mutate(WRKY_M1 = if_else(row.names(DEseq_norm_lin_TF) %in% as.character(combined_WRKY_RAV_promoters$M1_names), "yes", "no")) %>%
  mutate(WRKY_P1 = if_else(row.names(DEseq_norm_lin_TF) %in% combined_WRKY_RAV_promoters$P1_names, "yes", "no")) %>%
  mutate(RAV = if_else(row.names(DEseq_norm_lin_TF) %in% combined_WRKY_RAV_promoters$RAV, "yes", "no"))

###write DE tables with WRKY and RAV direct binding
write.csv(DEseq_norm_lin_TF_DAP, paste(table_path, "20220627_DEseq_norm_lin_TF_DAP.csv", sep =""))

###DE promoters

###WRKY promoters
combined_listPromoter <- list(
  M1_DE_genes = subset(DEseq_norm_lin_TF_DAP, WRKY_M1 == "yes")[, "geneId"], 
  P1_DE_genes = subset(DEseq_norm_lin_TF_DAP, WRKY_P1 == "yes")[, "geneId"],
  RAV_DE_genes = subset(DEseq_norm_lin_TF_DAP, RAV == "yes")[, "geneId"]
)

ggvenn(
  combined_listPromoter, 
  fill_color = c("#0073C2FF", "#EFC000FF", "#868686FF"),
  stroke_size = 0.5, set_name_size = 4
)

subset(combined_listPromoter[["P1_DE_genes"]])


####make RAV, P1 and M1 figures
##"SRR13197372", "SRR13197373"
RAV_rep1_bar <- plotAnnoBar(peakAnnoList[["SRR13197372"]])
RAV_rep1_bar <- RAV_rep1_bar + theme(legend.position="none") + labs(title="")
RAV_rep2_bar <- plotAnnoBar(peakAnnoList[["SRR13197373"]])
RAV_rep2_bar <- RAV_rep2_bar + theme(legend.position="bottom") + labs(title="")

P1_bar <- plotAnnoBar(peakAnnoList[["P1"]])
P1_bar <- P1_bar + theme(legend.position="none") + labs(title="")
  
M1_bar <- plotAnnoBar(peakAnnoList[["M1"]])
M1_bar <- M1_bar + theme(legend.position="none") + labs(title="")

P1_M1figure <- ggarrange(M1_bar, P1_bar, RAV_rep1_bar, RAV_rep2_bar,
                    labels = c("GmWRKY30 Mock", "GmWRKY30 Pathogen", "RAV rep1", "RAV rep2"),
                    nrow = 4,  heights = c(1, 1, 1, 1.3))
jpeg("p1_m1_peak_distribution.jpeg", width = 6, height = 12, units = 'in', res = 300)    # starts writing a PDF to file
P1_M1figure                    # makes the actual plot
dev.off()                     # closes the PDF file

W4_bar <- plotAnnoBar(peakAnnoList[["W4"]])
W4_bar <- W4_bar + theme(legend.position="none") + labs(title="")

W6_bar <- plotAnnoBar(peakAnnoList[["W6"]])
W6_bar <- W6_bar + theme(legend.position="none") + labs(title="")


W4_W6_figure <- ggarrange(W4_bar, W6_bar,
                         labels = c("GmMYB61", "GmWRKY2"),
                         nrow = 2,  heights = c(1, 1))
jpeg("W4_W6_peak_distribution.jpeg", width = 6, height = 6, units = 'in', res = 300)    # starts writing a PDF to file
W4_W6_figure                    # makes the actual plot
dev.off()                     # closes the PDF file
