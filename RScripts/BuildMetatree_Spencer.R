# SCRIPT TO BUILD METATREE FILES

# Load metatree library:
library(metatree)

# Set variables:
MRPDirectory <- "~/Desktop/Desktop - Spencer’s MacBook Pro (2)/NSF metatree/ProjectCalfFace/MRP"
XMLDirectory <- "~/Desktop/Desktop - Spencer’s MacBook Pro (2)/NSF metatree/ProjectCalfFace/XML"
MetatreeDirectory <- "~/Desktop/Desktop - Spencer’s MacBook Pro (2)/NSF metatree/ProjectCalfFace/Metatree"
InclusiveDataList <- sort(c(GetFilesForClade("matrsyna.html"), "Ezcurra_etal_2014a", "Ford_et_Benson_2019a", "MacDougall_et_Reisz_2012a", "MacDougall_etal_2016a", "Modesto_etal_2009a", "Modesto_etal_2014a", "Modesto_etal_2015a", "Muller_et_Tsuji_2007a", "Reisz_etal_2011b", "Reisz_etal_2014a", "Reisz_etal_2015a", "Rieppel_et_deBraga_1996a", "Tsuji_etal_2010a", "Tsuji_etal_2012a"))
ExclusiveDataList <- c("Averianov_2016a", "Bravo_et_Gaete_2015a", "Brocklehurst_etal_2013a", "Brocklehurst_etal_2015aa", "Brocklehurst_etal_2015ab", "Brocklehurst_etal_2015ac", "Brocklehurst_etal_2015ad", "Brocklehurst_etal_2015ae", "Brocklehurst_etal_2015af", "Bronzati_etal_2012a", "Bronzati_etal_2015ab", "Brusatte_etal_2009ba", "Campbell_etal_2016ab", "Carr_et_Williamson_2004a", "Carr_etal_2017ab", "Frederickson_et_Tumarkin-Deratzian_2014aa", "Frederickson_et_Tumarkin-Deratzian_2014ab", "Frederickson_et_Tumarkin-Deratzian_2014ac", "Frederickson_et_Tumarkin-Deratzian_2014ad", "Garcia_etal_2006a", "Gatesy_etal_2004ab", "Grellet-Tinner_2006a", "Grellet-Tinner_et_Chiappe_2004a", "Grellet-Tinner_et_Makovicky_2006a", "Jin_etal_2010a", "Knoll_2008a", "Kurochkin_1996a", "Lopez-Martinez_et_Vicens_2012a", "Lu_etal_2014aa", "Norden_etal_2018a", "Pisani_etal_2002a", "Ruiz-Omenaca_etal_1997a", "Ruta_etal_2003ba", "Ruta_etal_2003bb", "Ruta_etal_2007a", "Schaeffer_etal_inpressa", "Selles_et_Galobart_2016a", "Sereno_1993a", "Sidor_2001a","Sidor_2003a", "Skutschas_etal_2019a", "Tanaka_etal_2011a", "Toljagic_et_Butler_2013a", "Tsuihiji_etal_2011aa", "Varricchio_et_Jackson_2004a", "Vila_etal_2017a", "Wilson_2005aa", "Wilson_2005ab", "Zelenitsky_et_Therrien_2008a")
TargetClade = "Synapsida"
#MissingSpecies = "all"
MissingSpecies = "exclude"
RelativeWeights = c(0, 100, 10, 1)
WeightCombination = "sum"
ReportContradictionsToScreen = FALSE
SpeciesToExclude = c("Pristerodon_whaitsi", "Kannemeyeria_wilsoni", "Lystrosaurus_robustus", "Lystrosaurus_broomi", "Lystrosaurus_shichanggouensis")
# "Arctocephalus_forsteri","Blarinoides_aliciae","Hapalops_crassissimus","Marlu_kutjamarpensis","Namilamadeta_snideri","Swaindelphys_johansoni"
#HigherTaxaToCollapse = "Mammalia"
HigherTaxaToCollapse = c()
Interval = NULL
VeilLine = TRUE
IncludeSpecimenLevelOTUs = FALSE
BackboneConstraint = NULL
MonophylyConstraint = NULL
ExcludeTaxonomyMRP = FALSE

# Build synpasida metatree:
Synapsida <- metatree::Metatree(MRPDirectory = MRPDirectory, XMLDirectory = XMLDirectory, TargetClade = TargetClade, InclusiveDataList = InclusiveDataList, ExclusiveDataList = ExclusiveDataList, MissingSpecies = MissingSpecies, SpeciesToExclude = SpeciesToExclude, RelativeWeights = RelativeWeights, WeightCombination = WeightCombination, IncludeSpecimenLevelOTUs = FALSE, ReportContradictionsToScreen = ReportContradictionsToScreen)

# Enter constraint string (from Sidor and Hopson 1998, their Figure 2):
Sidor_et_Hopson_1998_Figure_2_Newick <- "(Ophiacodontidae,(Edaphosauridae,(Haptodus,(Sphenacodontidae,(Biarmosuchia,((Anteosauridae,Estemmenosuchidae),(Anomodontia,(Gorgonopidae,(Therocephalia,(Dvinia,(Procynosuchus,(Galesauridae,(Thrinaxodon,(Cynognathus,(Chiniquodon,(Probainognathus,(Tritheledontidae,(Sinoconodon,Morganucodon))))))))))))))))));"

# The following taxonomic changes were made to make this work with the current PBDB taxonomy:
#
# 1. Gorgonopsidae -> Gorgonopidae
# 2. Morgaucodontidae -> Morganucodon
# 3. Probelesodon -> Chiniquodon
# 4. Cynognathia -> Cynognathus
# 5. Eotitanosuchus is just removed (now in Bairmosuchia)

# For each OTU:
for(i in ape::read.tree(text = Sidor_et_Hopson_1998_Figure_2_Newick)$tip.label) {
  
  # Find tips assigned to the OTU in the metatree:
  TipsFound <- Synapsida$TaxonomyTree$tip.label[FindDescendants(ape::Ntip(Synapsida$TaxonomyTree) + which(unlist(lapply(strsplit(Synapsida$TaxonomyTree$node.label, split = "_"), function(x) any(x == i)))), Synapsida$TaxonomyTree)]
  
  # If no descendant found check if there is just a single tip:
  if(length(TipsFound) == 0) TipsFound <- Synapsida$TaxonomyTree$tip.label[unlist(lapply(strsplit(Synapsida$TaxonomyTree$tip.label, split = "_"), function(x) x[1] == i))]
  
  # If nothing found at all stop and warn user:
  if(length(TipsFound) == 0) stop(paste(i, "breaks things."))
  
  # If not monotypic then form clade from tips as Newick string:
  if(length(TipsFound) > 1) TipsFound <- paste("(", paste(TipsFound, collapse = ","), ")", sep = "")
  
  # Overwrite OTU name with species assigned to it:
  Sidor_et_Hopson_1998_Figure_2_Newick <- gsub(i, TipsFound, Sidor_et_Hopson_1998_Figure_2_Newick)
  
}

# COnvert Newick string to ape formatted tree:
ConstraintTree <- ape::read.tree(text = Sidor_et_Hopson_1998_Figure_2_Newick)

# Build MRP matrix from full constraint tree:
MRP <- metatree::Tree2MRP(ConstraintTree)

# Write MRP to file:
WriteMatrixNEXUS(MRP, "~/Desktop/Desktop - Spencer’s MacBook Pro (2)/NSF metatree/ProjectCalfFace/MRP/Constraint_2020amrp.nex")

# Get first set of reconciled names:
ReconciledNames <- rbind(cbind(unlist(lapply(apply(metatree::PaleobiologyDBTaxaQuerier("1", rownames(MRP$Matrix_1$Matrix)[unlist(lapply(strsplit(rownames(MRP$Matrix_1$Matrix), split = "_"), length)) == 2]), 1, as.list), function(x) {x <- unlist(x)[1:2]; unname(gsub("txn:|var:", "", x[!is.na(x)][1]))})), rownames(MRP$Matrix_1$Matrix)[unlist(lapply(strsplit(rownames(MRP$Matrix_1$Matrix), split = "_"), length)) == 2]), if(any(unlist(lapply(strsplit(rownames(MRP$Matrix_1$Matrix), split = "_"), length)) > 3)){ cbind(unlist(lapply(apply(metatree::PaleobiologyDBTaxaQuerier("1", unlist(lapply(strsplit(rownames(MRP$Matrix_1$Matrix)[unlist(lapply(strsplit(rownames(MRP$Matrix_1$Matrix), split = "_"), length)) > 2], split = "_"), function(x) x[1]))), 1, as.list), function(x) {x <- unlist(x)[1:2]; unname(gsub("txn:|var:", "", x[!is.na(x)][1]))})), rownames(MRP$Matrix_1$Matrix)[unlist(lapply(strsplit(rownames(MRP$Matrix_1$Matrix), split = "_"), length)) > 2]) } else {matrix(nrow = 0, ncol = 2)})

# Read in constraint XML:
XML <- ReadMetatreeXML("~/Desktop/Desktop - Spencer’s MacBook Pro (2)/NSF metatree/ProjectCalfFace/XML/Constraint_2020a.xml")

# Update constraint XML taxon count:
XML$SourceTree$Taxa$TagSupplement[, "Value"] <- as.character(nrow(MRP$Matrix_1$Matrix))

# Update constraint XML (MRP) character count:
XML$SourceTree$Characters$Other$TagSupplement[, "Value"] <- as.character(ncol(MRP$Matrix_1$Matrix))

# Update taxonomic reconciliation for constraint tree:
XML$SourceTree$Taxa$TagContents <- matrix(unname(matrix(c(c("DELETE", ReconciledNames[, 2]), c("0", ReconciledNames[, 1]), c("allzero", ReconciledNames[, 2])), ncol = 3, dimnames = list(c("allzero", ReconciledNames[, 2]), c("recon_name", "recon_no", "ListValue")))[rownames(MRP$Matrix_1$Matrix), ]), ncol = 3, dimnames = list(c(), c("recon_name", "recon_no", "ListValue")))

# Write XML to file:
WriteMetatreeXML(XML, "~/Desktop/Desktop - Spencer’s MacBook Pro (2)/NSF metatree/ProjectCalfFace/XML/Constraint_2020a.xml")

# Add constraint to inclusive data list:
InclusiveDataList <- c(InclusiveDataList, "Constraint_2020a")

# Build updated synpasida metatree with constraint included:
Synapsida <- metatree::Metatree(MRPDirectory = MRPDirectory, XMLDirectory = XMLDirectory, TargetClade = TargetClade, InclusiveDataList = InclusiveDataList, ExclusiveDataList = ExclusiveDataList, MissingSpecies = MissingSpecies, SpeciesToExclude = SpeciesToExclude, RelativeWeights = RelativeWeights, WeightCombination = WeightCombination, IncludeSpecimenLevelOTUs = FALSE, ReportContradictionsToScreen = ReportContradictionsToScreen, BackboneConstraint = "Constraint_2020a")

# Build constraint tree (for basic checks ahead of building constraint trees):
pdf("~/Desktop/Desktop - Spencer’s MacBook Pro (2)/NSF metatree/ProjectCalfFace/Metatree/ConstraintTree.pdf", width = 30, height = 50)
plot(ConstraintTree, cex = 0.3)
#nodelabels(ConstraintTree$node.label, cex = 0.5)
dev.off()

# Build taxonomy tree (for basic checks ahead of building constraint trees):
pdf("~/Desktop/Desktop - Spencer’s MacBook Pro (2)/NSF metatree/ProjectCalfFace/Metatree/TaxonomyTree.pdf", width = 30, height = 50)
plot(Synapsida$TaxonomyTree, cex = 0.3)
nodelabels(Synapsida$TaxonomyTree$node.label, cex = 0.5)
dev.off()

# Write out metatree files:
WriteMatrixNEXUS(Synapsida$FullMRPMatrix, paste(MetatreeDirectory, "/SynapsidaFULL.nex", sep = ""))
WriteMatrixNEXUS(Synapsida$STRMRPMatrix, paste(MetatreeDirectory, "/SynapsidaSTR.nex", sep = ""))
WriteMatrixTNT(Synapsida$FullMRPMatrix, paste(MetatreeDirectory, "/SynapsidaFULL.tnt", sep = ""))
WriteMatrixTNT(Synapsida$STRMRPMatrix, paste(MetatreeDirectory, "/SynapsidaSTR.tnt", sep = ""))
write.table(Synapsida$SafelyRemovedTaxa, "~/Desktop/Desktop - Spencer’s MacBook Pro (2)/NSF metatree/ProjectCalfFace/Metatree/STR.txt", row.names = FALSE)

# Add analysis block to STR TNT:
STRTNT <- readLines(paste(MetatreeDirectory, "/SynapsidaSTR.tnt", sep = ""))
STRTNT <- gsub("proc/;", "rseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nhold 1000;\nshortread scratch3.tre;\nbbreak=tbr;\nexport -AllSTRMPTs.nex;\nproc/;", STRTNT)
write(STRTNT, paste(MetatreeDirectory, "/SynapsidaSTR.tnt", sep = ""))
