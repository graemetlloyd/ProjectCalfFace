# SCRIPT TO TIMESCALE TREE

# TO DO:
# - Spencer to add root age from https://onlinelibrary.wiley.com/doi/full/10.1002/spp2.1316 to Ken's node list.
# - Graeme to add this to github https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0218791.

# Load metatree library:
library(paleotree)
library(strap)
library(beepr)

# Read trees in from GitHub:
Trees <- ape::read.tree("~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/Trees/MPTs.tre")

# Read in age data from GitHub:
AgeData <- read.table("~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/Recovered_Age_Data_Ken_plus_Angielczyk_plus_additional_taxa.csv", sep = ",", header = TRUE)

########
NewAgeData<- read.table("~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/Grossnickle_OnlineSheet_recovered_age_data.csv", sep = ",", header = TRUE)

AgeData[, "Taxon"]
NewAgeData[, "TAXON"]

GenusNodeData<- read.table("~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/Genus_FAD_LAD_Grossnickle.csv", sep = ",", header = TRUE)

genus.node.names<-c()
for(i in (1:370)){
  genus.node.names[i]<-strsplit(toString(GenusNodeData[, "Genus_species"][i]),split = "_")[[1]][1]
}
genus.node.name<-unique(genus.node.names)

TaxonomyTree<-read.nexus("~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/Metatree/TaxonomyTree.nex")
TaxonomyTree.split.names<- strsplit(TaxonomyTree$tip.label,split = "_")
TaxonomyTree.genus.names<-unlist(lapply(TaxonomyTree.split.names, `[[`, 1))

genus.node.name<-intersect(TaxonomyTree.genus.names,genus.node.name)

pos.in.tax.tree<-c()
for(i in 1:length(genus.node.name)){
    pos.in.tax.tree[[i]]<-which(TaxonomyTree.genus.names==genus.node.name[i])
}

sort(GenusNodeData[, "Genus_species"][1:370])

Taxon1.Taxon2<-c()
for(i in 1:length(pos.in.tax.tree)){
  if(length(pos.in.tax.tree[[i]])>1){
   # Taxon1.Taxon2[[i]][1]<-TaxonomyTree$tip.label[pos.in.tax.tree[[i]]][[1]]
    #Taxon1.Taxon2[[i]][2]<-TaxonomyTree$tip.label[pos.in.tax.tree[[i]]][[2]]
    Taxon1.Taxon2[[i]]<-c(TaxonomyTree$tip.label[pos.in.tax.tree[[i]]][[1]],TaxonomyTree$tip.label[pos.in.tax.tree[[i]]][[2]])
  }
}

Taxon1.Taxon2<-Taxon1.Taxon2[setdiff((1:length(Taxon1.Taxon2)),which(Taxon1.Taxon2=="NULL"))]

Taxon1.Taxon2.genus<-c()
for(i in 1:length(Taxon1.Taxon2)){
  Taxon1.Taxon2.genus[i]<-Taxon1.Taxon2[[i]][1]
}

Taxon1.Taxon2.genus.list<-c()
Taxon1.Taxon2.genus<-strsplit(Taxon1.Taxon2.genus,split = "_")
for(i in 1:length(Taxon1.Taxon2.genus)){
  Taxon1.Taxon2.genus.list[i]<-Taxon1.Taxon2.genus[[i]][1]
}

pos.in.new.node.data<-c()
for(i in 1:length(Taxon1.Taxon2.genus.list)){
  pos.in.new.node.data[[i]]<-which(genus.node.names==Taxon1.Taxon2.genus.list[i])
}

for(i in 1:length(pos.in.new.node.data)){
  for(j in 1:length(pos.in.new.node.data[[i]])){
    GenusNodeData$Taxon_1[pos.in.new.node.data[[i]][j]]<-Taxon1.Taxon2[[i]][[1]]
    GenusNodeData$Taxon_2[pos.in.new.node.data[[i]][j]]<-Taxon1.Taxon2[[i]][[2]]
  }
}

library(tidyverse)
GenusNodeData<-GenusNodeData %>% 
  rename(
    Original_Node_Name = Genus_species,
    Min_Date = Genus_FAD
  )

NodeAgePairs<-rbind(NodeAgePairs,GenusNodeData[unlist(pos.in.new.node.data), ][1:4])

########

# First reformat step for paleotree:
PaleotreeAgeData <- AgeData[!is.na(AgeData[, "FAD"]), c("Taxon", "FAD", "LAD")]
#PaleotreeAgeData <- AgeData[!is.na(AgeData[, "FAD"]), c("X...Taxon", "FAD", "LAD")]

# Second reformat step for paleotree:
PaleotreeAgeData <- matrix(c(PaleotreeAgeData[, "FAD"], PaleotreeAgeData[, "LAD"]), ncol = 2, dimnames = list(PaleotreeAgeData[, "Taxon"], c("FAD", "LAD")))
#PaleotreeAgeData <- matrix(c(PaleotreeAgeData[, "FAD"], PaleotreeAgeData[, "LAD"]), ncol = 2, dimnames = list(PaleotreeAgeData[, "X...Taxon"], c("FAD", "LAD")))

# Read in node age pairs:
NodeAgePairs <- read.table("~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/node_dates_from_ken.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)

# Silly fudgy deleting bits required for now to make things work:
NodeAgePairs <- NodeAgePairs[-28, ]
PaleotreeAgeData <- PaleotreeAgeData[-match(setdiff(rownames(PaleotreeAgeData), sort(Trees[[1]]$tip.label)), rownames(PaleotreeAgeData)), ]

# # For each tree in turn:
# for(i in 1:length(Trees)) {
#   
#   # Isolate ith tree:
#   tree <- Trees[[i]]
#   
#   # Prunes taxa with no ages:
#   tree <- paleotree::timePaleoPhy(tree, timeData = PaleotreeAgeData, type = "equal", vartime = 1)
#   
#   # Get number of tips in tree (after pruning)
#   NTips <- ape::Ntip(tree)
#   
#   # Crwate node minimum age vector:
#   nodeminima <- rep(NA, tree$Nnode)
#   
#   # For each minimum node age pair:
#   for(j in 1:nrow(NodeAgePairs)) {
#     
#     # Fidn node number and store minimum age in vector:
#     nodeminima[(Claddis::find_mrca(
#       descendant_names = NodeAgePairs[j, c("Taxon_1", "Taxon_2")], tree = tree) - NTips)] <- NodeAgePairs[j, "Min_Date"]
#     
#   }
#   
#   # Time-scale tree and store in Trees list:
#   Trees[[i]] <- paleotree::timePaleoPhy(tree, timeData = PaleotreeAgeData, type = "equal", vartime = 1, node.mins = nodeminima)
#   
# }
# 
# beep(3)

# GRAEME HAS NOT LOOKED BELOW HERE

# Make Strict Consensus Tree
  consTree<-consensus(Trees,p=0.5,check.labels = FALSE)
  tree <-consTree
  
  # Prunes taxa with no ages:
  tree <- paleotree::timePaleoPhy(tree, timeData = PaleotreeAgeData, type = "equal", vartime = 1)
  
  # Get number of tips in tree (after pruning)
  NTips <- ape::Ntip(tree)
  
  # Crwate node minimum age vector:
  nodeminima <- rep(NA, tree$Nnode)
  
  # For each minimum node age pair:
  for(j in 1:nrow(NodeAgePairs)) {
    
    # Fidn node number and store minimum age in vector:
    nodeminima[(Claddis::find_mrca(
      descendant_names = NodeAgePairs[j, c("Taxon_1", "Taxon_2")], tree = tree) - NTips)] <- NodeAgePairs[j, "Min_Date"]
    
  }
  
# Time-scale strict consensus tree:
  DatedConsTree <- paleotree::timePaleoPhy(tree, timeData = PaleotreeAgeData, type = "equal", vartime = 1, node.mins = nodeminima)
  
# Plot Tree[[1]] nicely using geoscalePhylo:
x=Trees[[1]]
strap::geoscalePhylo(ape::ladderize(x), x.lim = c(325, 0), cex.tip=0.15,label.offset=.5, width=1, ages = PaleotreeAgeData[x$tip.label, ])
  
# Plot strict consensus nicely using geoscalePhylo
x=DatedConsTree
strap::geoscalePhylo(ape::ladderize(x), x.lim = c(325, 0), cex.tip=0.15,label.offset=.5, width=1, ages = PaleotreeAgeData[x$tip.label, ])
  
# for-loop to turn Trees (class multiphylo) into a list of trees (each of class phylo), called TreeList
#TreeList<-c()
#for(i in 1:length(Trees)) {
#  TreeList[i] <- Trees[i]
#}

# Make consensus tree 
consTree<-consensus(Trees,p=1,check.labels = FALSE)




###########
# TImescale just first tree using equal method:
x <- paleotree::timePaleoPhy(tree, timeData = PaleotreeAgeData, type = "equal", vartime = 1, node.mins = NodeListWithDates[[1]])

node.mins = NodeListWithDates[[1]]

# Plot tree nicely using geoscalePhylo:
strap::geoscalePhylo(ape::ladderize(x), x.lim = c(325, 66), cex.tip = 0.15, label.offset = .5, ages = PaleotreeAgeData[x$tip.label, ])

#Write dated tree to a nexus file that can be opened in FigTree
ape::write.nexus(x, file = "~/Desktop/Dated_Metatree2.nex")

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
