# SCRIPT TO BUILD METATREE FILES

# TO DO:
#
# - Maybe add node names to Sidor and Hopson constraint

#find xml or mrp that's messed up
setwd(XMLDirectory); for(i in list.files()) {cat(i); ReadMetatreeXML(i)}

#find OTU in xml or mrp that's messed up
setwd("~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace")

filename = "Brocklehurst_2019a"
XMLnames <- metatree::ReadMetatreeXML(paste0("XML/", filename, ".xml"))$Source$Taxa$TagContents[, "ListValue"]
MRPnames <- rownames(Claddis::read_nexus_matrix(paste0("MRP/", filename, "mrp.nex"))$matrix_1$matrix)

setdiff(XMLnames, MRPnames)
setdiff(MRPnames, XMLnames)


# Load metatree library:
library(metatree)

# Set variables:
MRPDirectory <- "~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/MRP"
XMLDirectory <- "~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/XML"
MetatreeDirectory <- "~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/Metatree"
InclusiveDataList <- sort(c(GetFilesForClade("matrsyna.html"), "Ezcurra_etal_2014a", "Ford_et_Benson_2019a", "MacDougall_et_Reisz_2012a", "MacDougall_etal_2016a", "Modesto_etal_2009a", "Modesto_etal_2014a", "Modesto_etal_2015a", "Muller_et_Tsuji_2007a", "Reisz_etal_2011b", "Reisz_etal_2014a", "Reisz_etal_2015a", "Rieppel_et_deBraga_1996a", "Tsuji_etal_2010a", "Tsuji_etal_2012a", "Averianov_etal_2015a", "Bi_etal_2018a", "Bloch_etal_2016a", "Carneiro_2018a", "Constraint_2020a", "Halliday_etal_inpressba", "Han_et_Meng_2016a", "Huttenlocker_etal_2018a", "Krause_etal_inpressb", "Mao_etal_2020a", "Martin_etal_2015aa", "Martin_etal_2015ab", "Muizon_etal_2015a", "Muizon_etal_2018a", "Rougier_etal_2012a", "Wang_etal_2016f", "Wilson_etal_2016a"))
ExclusiveDataList <- c("Averianov_2016a", "Bravo_et_Gaete_2015a", "Brocklehurst_etal_2013a", "Brocklehurst_etal_2015aa", "Brocklehurst_etal_2015ab", "Brocklehurst_etal_2015ac", "Brocklehurst_etal_2015ad", "Brocklehurst_etal_2015ae", "Brocklehurst_etal_2015af", "Bronzati_etal_2012a", "Bronzati_etal_2015ab", "Brusatte_etal_2009ba", "Campbell_etal_2016ab", "Carr_et_Williamson_2004a", "Carr_etal_2017ab", "Frederickson_et_Tumarkin-Deratzian_2014aa", "Frederickson_et_Tumarkin-Deratzian_2014ab", "Frederickson_et_Tumarkin-Deratzian_2014ac", "Frederickson_et_Tumarkin-Deratzian_2014ad", "Garcia_etal_2006a", "Gatesy_etal_2004ab", "Grellet-Tinner_2006a", "Grellet-Tinner_et_Chiappe_2004a", "Grellet-Tinner_et_Makovicky_2006a", "Jin_etal_2010a", "Knoll_2008a", "Kurochkin_1996a", "Lopez-Martinez_et_Vicens_2012a", "Lu_etal_2014aa", "Norden_etal_2018a", "Pisani_etal_2002a", "Ruiz-Omenaca_etal_1997a", "Ruta_etal_2003ba", "Ruta_etal_2003bb", "Ruta_etal_2007a", "Schaeffer_etal_inpressa", "Selles_et_Galobart_2016a", "Sereno_1993a", "Sidor_2001a","Sidor_2003a", "Skutschas_etal_2019a", "Tanaka_etal_2011a", "Toljagic_et_Butler_2013a", "Tsuihiji_etal_2011aa", "Varricchio_et_Jackson_2004a", "Vila_etal_2017a", "Wilson_2005aa", "Wilson_2005ab", "Zelenitsky_et_Therrien_2008a", "Halliday_etal_inpressbb")
TargetClade = "Synapsida"
MissingSpecies = "exclude"
RelativeWeights = c(0, 100, 10, 1)
WeightCombination = "sum"
ReportContradictionsToScreen = FALSE
SpeciesToExclude = c("Pristerodon_whaitsi", "Kannemeyeria_wilsoni", "Lystrosaurus_robustus", "Lystrosaurus_broomi", "Lystrosaurus_shichanggouensis")
HigherTaxaToCollapse = c()
Interval = NULL
VeilLine = TRUE
IncludeSpecimenLevelOTUs = TRUE
BackboneConstraint = NULL
MonophylyConstraint = NULL
ExcludeTaxonomyMRP = FALSE

# Build synpasida metatree:

Synapsida <- metatree::Metatree(MRPDirectory = MRPDirectory, XMLDirectory = XMLDirectory, TargetClade = TargetClade, InclusiveDataList = InclusiveDataList, ExclusiveDataList = ExclusiveDataList, MissingSpecies = MissingSpecies, IncludeSpecimenLevelOTUs = FALSE, SpeciesToExclude = SpeciesToExclude, RelativeWeights = RelativeWeights, WeightCombination = WeightCombination, ReportContradictionsToScreen = ReportContradictionsToScreen)

# Enter constraint string (from Sidor and Hopson 1998, their Figure 2):
Sidor_et_Hopson_1998_Figure_2_Newick <- "(Ophiacodontidae,(Edaphosauridae,(Haptodus,(Sphenacodontidae,(Biarmosuchia,((Anteosauridae,Estemmenosuchidae),(Anomodontia,(Gorgonopidae,(Therocephalia,(Dvinia,(Procynosuchus,(Galesauridae,(Thrinaxodon,(Cynognathus_et_Gomphodontia,(Chiniquodon,(Probainognathus,(Tritheledontidae,(Sinoconodon,Morganucodon))))))))))))))))));"

# The following taxonomic changes were made to make this work with the current PBDB taxonomy:
#
# 1. Gorgonopsidae -> Gorgonopidae
# 2. Morgaucodontidae -> Morganucodon
# 3. Probelesodon -> Chiniquodon
# 4. Cynognathia -> Cynognathus_et_Gomphodontia
# 5. Eotitanosuchus is just removed (now in Biarmosuchia)

# For each OTU:
for(i in ape::read.tree(text = Sidor_et_Hopson_1998_Figure_2_Newick)$tip.label) {
  
  # Create empty tip vector:
  AllTips <- vector(mode = "character")
  
  # For each sub-tip found:
  for(j in strsplit(i, "_et_")[[1]]) {
    
    # Find tips assigned to the OTU in the metatree:
    TipsFound <- Synapsida$TaxonomyTree$tip.label[FindDescendants(ape::Ntip(Synapsida$TaxonomyTree) + which(unlist(lapply(strsplit(Synapsida$TaxonomyTree$node.label, split = "_"), function(x) any(x == j)))), Synapsida$TaxonomyTree)]
    
    # If no descendant found check if there is just a single tip:
    if(length(TipsFound) == 0) TipsFound <- Synapsida$TaxonomyTree$tip.label[unlist(lapply(strsplit(Synapsida$TaxonomyTree$tip.label, split = "_"), function(x) x[1] == j))]
    
    # If nothing found at all stop and warn user:
    if(length(TipsFound) == 0) stop(paste(i, "breaks things."))
    
    # Add tips found to all tips vector:
    AllTips <- sort(c(AllTips, TipsFound))
    
  }

  # If not monotypic then form clade from tips as Newick string:
  if(length(AllTips) > 1) AllTips <- paste("(", paste(AllTips, collapse = ","), ")", sep = "")
  
  # Overwrite OTU name with species assigned to it:
  Sidor_et_Hopson_1998_Figure_2_Newick <- gsub(i, AllTips, Sidor_et_Hopson_1998_Figure_2_Newick)
  
}

# Convert Newick string to ape formatted tree:
ConstraintTree <- ape::read.tree(text = Sidor_et_Hopson_1998_Figure_2_Newick)

# Build MRP matrix from full constraint tree:
MRP <- metatree::Tree2MRP(ConstraintTree)

# Write MRP to file:
Claddis::write_nexus_matrix(MRP, "~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/MRP/Constraint_2020amrp.nex")

# Get first set of reconciled names:
ReconciledNames <- rbind(cbind(unlist(lapply(apply(metatree::PaleobiologyDBTaxaQuerier("1", rownames(MRP$matrix_1$matrix)[unlist(lapply(strsplit(rownames(MRP$matrix_1$matrix), split = "_"), length)) == 2]), 1, as.list), function(x) {x <- unlist(x)[1:2]; unname(gsub("txn:|var:", "", x[!is.na(x)][1]))})), rownames(MRP$matrix_1$matrix)[unlist(lapply(strsplit(rownames(MRP$matrix_1$matrix), split = "_"), length)) == 2]), if(any(unlist(lapply(strsplit(rownames(MRP$matrix_1$matrix), split = "_"), length)) > 3)){ cbind(unlist(lapply(apply(metatree::PaleobiologyDBTaxaQuerier("1", unlist(lapply(strsplit(rownames(MRP$matrix_1$matrix)[unlist(lapply(strsplit(rownames(MRP$matrix_1$matrix), split = "_"), length)) > 2], split = "_"), function(x) x[1]))), 1, as.list), function(x) {x <- unlist(x)[1:2]; unname(gsub("txn:|var:", "", x[!is.na(x)][1]))})), rownames(MRP$matrix_1$matrix)[unlist(lapply(strsplit(rownames(MRP$matrix_1$matrix), split = "_"), length)) > 2]) } else {matrix(nrow = 0, ncol = 2)})

# Read in constraint XML:
XML <- ReadMetatreeXML("~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/XML/Constraint_2020a.xml")

# Update constraint XML taxon count:
XML$SourceTree$Taxa$TagSupplement[, "Value"] <- as.character(nrow(MRP$matrix_1$matrix))

# Update constraint XML (MRP) character count:
XML$SourceTree$Characters$Other$TagSupplement[, "Value"] <- as.character(ncol(MRP$matrix_1$matrix))

# Update taxonomic reconciliation for constraint tree:
XML$SourceTree$Taxa$TagContents <- matrix(unname(matrix(c(c("DELETE", ReconciledNames[, 2]), c("0", ReconciledNames[, 1]), c("allzero", ReconciledNames[, 2])), ncol = 3, dimnames = list(c("allzero", ReconciledNames[, 2]), c("recon_name", "recon_no", "ListValue")))[rownames(MRP$matrix_1$matrix), ]), ncol = 3, dimnames = list(c(), c("recon_name", "recon_no", "ListValue")))

# Write XML to file:
WriteMetatreeXML(XML, "~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/XML/Constraint_2020a.xml")

# Add constraint to inclusive data list:
InclusiveDataList <- c(InclusiveDataList, "Constraint_2020a")

# Build updated synpasida metatree with constraint included:
Synapsida <- metatree::Metatree(MRPDirectory = MRPDirectory, XMLDirectory = XMLDirectory, TargetClade = TargetClade, InclusiveDataList = InclusiveDataList, ExclusiveDataList = ExclusiveDataList, MissingSpecies = MissingSpecies, SpeciesToExclude = SpeciesToExclude, RelativeWeights = RelativeWeights, WeightCombination = WeightCombination, IncludeSpecimenLevelOTUs = FALSE, ReportContradictionsToScreen = ReportContradictionsToScreen, BackboneConstraint = "Constraint_2020a")

# Build constraint tree (for basic checks ahead of building constraint trees):
pdf("~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/Metatree/ConstraintTree.pdf", width = 30, height = 50)
plot(ConstraintTree, cex = 0.3)
#nodelabels(ConstraintTree$node.label, cex = 0.5)
dev.off()

# Build taxonomy tree (for basic checks ahead of building constraint trees):
pdf("~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/Metatree/TaxonomyTree.pdf", width = 30, height = 150)
plot(Synapsida$TaxonomyTree, cex = 0.3)
nodelabels(Synapsida$TaxonomyTree$node.label, cex = 0.5)
dev.off()

# Write out metatree files:
Claddis::write_nexus_matrix(Synapsida$FullMRPMatrix, paste(MetatreeDirectory, "/SynapsidaFULL.nex", sep = ""))
Claddis::write_nexus_matrix(Synapsida$STRMRPMatrix, paste(MetatreeDirectory, "/SynapsidaSTR.nex", sep = ""))
Claddis::write_tnt_matrix(Synapsida$FullMRPMatrix, paste(MetatreeDirectory, "/SynapsidaFULL.tnt", sep = ""))
Claddis::write_tnt_matrix(Synapsida$STRMRPMatrix, paste(MetatreeDirectory, "/SynapsidaSTR.tnt", sep = ""))
write.table(Synapsida$SafelyRemovedTaxa, "~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/Metatree/STR.txt", row.names = FALSE)

# Add analysis block to STR TNT:
STRTNT <- readLines(paste(MetatreeDirectory, "/SynapsidaSTR.tnt", sep = ""))
STRTNT <- gsub("proc/;", "rseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nhold 1000;\nshortread scratch3.tre;\nbbreak=tbr;\nexport -AllSTRMPTs.nex;\nproc/;", STRTNT)
write(STRTNT, paste(MetatreeDirectory, "/SynapsidaSTR.tnt", sep = ""))

#Find out how many tips the taxonomy tree has:
length(Synapsida$TaxonomyTree$tip.label)
#1560 on 1/12/2021

########
#Trying to get the names of all the extra taxon that we have more than 1 of per genus of so that I can plug them in as tips to drop from the taxonomy tree (and later from the full metatree). First though I need a list of the first species of each unique genera, and to do that I need a list of the positions in the tipnames where that occurs.

#making taxonomy nexus file
library(phytools)
writeNexus(Synapsida$TaxonomyTree, "~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/Metatree/TaxonomyTree.nex")

#test is the genus part of all the taxon names for all the tips of the taxonomy tree, testt is making a new list of just the genus names, newtest is a list of all the unique genera
newtest <- c()
test<- strsplit(Synapsida$TaxonomyTree$tip.label,split = "_")
testt<-unlist(lapply(test, `[[`, 1))
for (i in 1:length(test)){
  newtest[i]<-test[[i]][1]
}
unique.genera<-unique(newtest)

#list of positions of each unique genus in the list of full tip names
test.postion <- NULL;
for (i in 1:length(unique.genera))
{ 
  tmp <- match(unique.genera[i],testt)
  test.postion <- cbind(test.postion, tmp)
}

#making sure the above list a regular list, not a data frame
test4<-unlist(test.postion)
pos.list<-as.vector(test4)

#making list of taxon tip names that includes only the first taxon of each genus
unique.taxonlist<-c()
for(i in 1:length(pos.list)){
  unique.taxonlist[i] <- Synapsida$TaxonomyTree$tip.label[pos.list[i]]
}
length(unique.taxonlist)
#890

#geting a list of positions that complimentary to the list of taxon tip names above
exclude.pos<-setdiff(c(1:length(test)), pos.list)

#1501 making list of taxon tip names that correspond to the list of positions in the line above
exclude.taxonlist<-c()
for(i in 1:length(exclude.pos)){
  exclude.taxonlist[i] <- Synapsida$TaxonomyTree$tip.label[exclude.pos[i]]
}

#create taxon tree with only unique genera
TaxonomyTree.dropped<-drop.tip(Synapsida$TaxonomyTree,exclude.taxonlist)
writeNexus(TaxonomyTree.dropped, "~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/Metatree/TaxonomyTreeTipsDropped.nex")
pdf("~/Desktop/Desktop_Spencers_MacBook_Pro_2/NSF metatree/ProjectCalfFace/Metatree/TaxonomyTreeTipsDropped.pdf", width = 30, height = 100)
plot(TaxonomyTree.dropped, cex = 0.5)
nodelabels(TaxonomyTree.dropped$node.label, cex = 0.3)
dev.off()