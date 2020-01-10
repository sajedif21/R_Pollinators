#Adding libraries needed to run the code
library(xlsx)
library(lmerTest)
library(doBy)
library(plyr)
library(bipartite)
library(sjPlot)
library(reshape2)

### set working directory
getwd()

setwd("/Users/fsajedi/Desktop") # update this to the correct path


#Reading in the excel file 
for.net.data  <- read.xlsx("fullRecap.xls", sheetName = "Sheet1")
#Getting information on the data received 
head(for.net.data) ; dim(for.net.data)
# get rid of extra row
for.net.data <- for.net.data[-c(77:nrow(for.net.data)),]
dim(for.net.data)

#Make newtwork
pre.net.dat <- ddply(for.net.data, c("Transect","Date","Bee","Round","Flower"), summarise, num.polls=length(Bee))

complete.network <- dcast(pre.net.dat, Flower~Bee,fun.aggregate=sum,value.var="num.polls")
#getting the whole network
complete.network
dim(complete.network)
#Getting summary data
sum(complete.network$Apidae)
sum(complete.network$Halictidae)
sum(complete.network$Crabronidae)
sum(complete.network$Ichneumonidae)
#Changing the dimensions of the network
complete.network2 <- complete.network[1:5, 2:3] ; dim (complete.network2)
#adding row names to the network  (flowers)
rownames(complete.network2) <- c("Ageratina pseudochilca", "Ageratina sp.", "Dendrophorbium","Gaultheria reticulata", "Ilex")
#adding column names to the network (birds)
all.list <- colnames(complete.network2)
#Getting entire network
complete.network2
#Grqaphing Network
plotweb(complete.network2, text.rot=90, arrow="up.center",method="normal", labsize=1.5,            #code for plotting a network, "normal" means in the order you entered it "cca" means fewest crossings, otherwise "normal", text.rot is to make the text horizontal to the bars
        y.width.low=0.1, y.width.high=0.1, 
        high.lab.dis=0.1, low.lab.dis=0.1,
        y.lim=c(-3,5), #x.lim=c(-1, 4),
        low.lablength=30, high.lablength=30,
        col.high="purple4", col.low="thistle")
#Computing the network level
networklevel(complete.network2)
#Computing the modules for the network
computeModules(complete.network2)

