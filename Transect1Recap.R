

library(xlsx)
library(lmerTest)
library(doBy)
library(plyr)
library(bipartite)
library(sjPlot)

### set working directory
getwd()

setwd("/Users/fsajedi/Desktop") # update this to the correct path



for.net.data  <- read.xlsx("final data.xls", sheetName = "Transect1")
datas <- read.csv("Transect1.csv",header = TRUE)
datas
head(for.net.data) ; dim(for.net.data)
dim(for.net.data)

library(reshape2)
pre.net.dat <- ddply(for.net.data, c("Transect","Date","Bee","Round","Flower"), summarise, num.polls=length(Bee))

complete.network <- dcast(pre.net.dat, Flower~Bee,fun.aggregate=sum,value.var="num.polls")
complete.network
dim(complete.network)
sum(complete.network$Apidae)
sum(complete.network$Halictidae)
sum(complete.network$Crabronidae)
sum(complete.network$Ichneumonidae)
complete.network2 <- complete.network[1:3, 1:2] ; dim (complete.network2)
complete.network2
rownames(datas) <- c("Ageratina pseudochilca", "Dendrophorbium","Gaultheria reticulata")
all.list <- colnames(complete.network2)
all.list <- colnames(datas)
all.list
complete.network2

plotweb(datas, text.rot=90, arrow="up.center",method="normal", labsize=1.5,            #code for plotting a network, "normal" means in the order you entered it "cca" means fewest crossings, otherwise "normal", text.rot is to make the text horizontal to the bars
        y.width.low=0.1, y.width.high=0.1, 
        high.lab.dis=0.1, low.lab.dis=0.1,
        y.lim=c(-3,5), #x.lim=c(-1, 4),
        low.lablength=30, high.lablength=30,
        col.high="purple4", col.low="thistle")

