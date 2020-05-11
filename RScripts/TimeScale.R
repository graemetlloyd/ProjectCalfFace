# SCRIPT TO TIMESCALE TREE

# Load metatree library:
library(paleotree)
library(strap)

# Read trees in from GitHub:
Trees <- ape::read.tree("https://raw.githubusercontent.com/graemetlloyd/ProjectCalfFace/master/Trees/MPTs.tre")

# Read in age data from GitHub:
AgeData <- read.table("https://raw.githubusercontent.com/graemetlloyd/ProjectCalfFace/master/Recovered_Age_Data.csv", sep =",", header = TRUE)

# First reformat step for paleotree:
PaleotreeAgeData <- AgeData[!is.na(AgeData[, "FAD"]), c("X...Taxon", "FAD", "LAD")]

# Second reformat step for paleotree:
PaleotreeAgeData  <- matrix(c(PaleotreeAgeData[, "FAD"], PaleotreeAgeData[, "LAD"]), ncol = 2, dimnames = list(PaleotreeAgeData[, "X...Taxon"], c("FAD", "LAD")))

tree = Trees[[1]]

NodeListWithDates <- read.table("https://raw.githubusercontent.com/graemetlloyd/ProjectCalfFace/master/min_node_dates_for_r.csv", header = TRUE)





# TImescale just first tree using equal method:
x <- paleotree::timePaleoPhy(tree, timeData = PaleotreeAgeData, type = "equal", vartime = 1,node.mins=NodeListWithDates[[1]])

node.mins=NodeListWithDates[[1]]

# Plot tree nicely using geoscalePhylo:
strap::geoscalePhylo(ape::ladderize(x), x.lim = c(325, 66), cex.tip=0.15,label.offset=.5,ages = PaleotreeAgeData[x$tip.label, ])

#Write dated tree to a nexus file that can be opened in FigTree
ape::write.nexus(x,file="~/Desktop/Dated_Metatree2.nex")


#length(rep(0, Trees[[1]]$Nnode))

#Claddis::FindAncestor(descs = c("Patranomodon_nyaphulii", "Dicynodon_lacerticeps"), tree = Trees[[1]]) - Ntip(Trees[[1]])



#usq<-0
#for(i in 1:429) {
 # usq[i]<-Claddis::FindAncestor(descs = c(t(NodeData1)[,i]), tree = Trees[[1]]) - Ntip(Trees[[1]])
 # print(usq[i])}
#length(usq)

NodeListWithDates <- read.table("~/Desktop/min_node_dates_for_r.csv", header = TRUE)
#length(NodeListWithDates[[1]])


#usq<-0
#for(i in 1:429) {
#  usq[i]<-Claddis::FindAncestor(descs = c(t(NodeData1)[,i]), tree = x) - Ntip(x)
#  print(usq[i])}
#length(usq)

#tree<-drop.tip(tree, "Shaanbeikannemeyeria_xilougouensi")
#tree<-drop.tip(tree, "Moschops_koupensis")
#tree<-drop.tip(tree, "Cerdorhinus_parvidens")
#tree<-drop.tip(tree, "allzero")
