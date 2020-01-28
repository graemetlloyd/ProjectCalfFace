# SCRIPT TO BUILD XML AND MRP FILES AND THEN GENERATE METATREE FILES FROM THEM
# ALSO CLEARS OUT DIRECTORIES FIRST ALLOWING CONTINUOUS UPDATING

# Load metatree library:
library(metatree)

# Build inclusive data list (synapsid appropriate files to use here, from larger graemetlloyd.com database):
InclusiveDataList <- sort(c(GetFilesForClade("matrsyna.html"), "Ezcurra_etal_2014a", "Ford_et_Benson_2019a", "MacDougall_et_Reisz_2012a", "MacDougall_etal_2016a", "Modesto_etal_2009a", "Modesto_etal_2014a", "Modesto_etal_2015a", "Muller_et_Tsuji_2007a", "Reisz_etal_2011b", "Reisz_etal_2014a", "Reisz_etal_2015a", "Tsuji_etal_2010a", "Tsuji_etal_2012a"))

# Copy just inclusive XML data sets from main directory to project one (only need to run once):
#x <- lapply(as.list(InclusiveDataList), function(x) file.copy(from = paste("~/Documents/Homepage/www.graemetlloyd.com/xml/", x, ".xml", sep = ""), to =  paste("~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/XML/", x, ".xml", sep = ""), overwrite = TRUE))

# Copy just inclusive MRP data sets from main directory to project one (only need to run once):
#x <- lapply(as.list(InclusiveDataList), function(x) file.copy(from = paste("~/Documents/Homepage/www.graemetlloyd.com/mrp/", x, "mrp.nex", sep = ""), to =  paste("~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/MRP/", x, "mrp.nex", sep = ""), overwrite = TRUE))

# Standard exclusive data list (supertrees and the like):
ExclusiveDataList <- c("Averianov_2016a", "Bravo_et_Gaete_2015a", "Brocklehurst_etal_2013a", "Brocklehurst_etal_2015aa", "Brocklehurst_etal_2015ab", "Brocklehurst_etal_2015ac", "Brocklehurst_etal_2015ad", "Brocklehurst_etal_2015ae", "Brocklehurst_etal_2015af", "Bronzati_etal_2012a", "Bronzati_etal_2015ab", "Brusatte_etal_2009ba", "Campbell_etal_2016ab", "Carr_et_Williamson_2004a", "Carr_etal_2017ab", "Frederickson_et_Tumarkin-Deratzian_2014aa", "Frederickson_et_Tumarkin-Deratzian_2014ab", "Frederickson_et_Tumarkin-Deratzian_2014ac", "Frederickson_et_Tumarkin-Deratzian_2014ad", "Garcia_etal_2006a", "Gatesy_etal_2004ab", "Grellet-Tinner_2006a", "Grellet-Tinner_et_Chiappe_2004a", "Grellet-Tinner_et_Makovicky_2006a", "Jin_etal_2010a", "Knoll_2008a", "Kurochkin_1996a", "Lopez-Martinez_et_Vicens_2012a", "Lu_etal_2014aa", "Norden_etal_2018a", "Pisani_etal_2002a", "Ruiz-Omenaca_etal_1997a", "Ruta_etal_2003ba", "Ruta_etal_2003bb", "Ruta_etal_2007a", "Schaeffer_etal_inpressa", "Selles_et_Galobart_2016a", "Sereno_1993a", "Sidor_2001a", "Skutschas_etal_2019a", "Tanaka_etal_2011a", "Toljagic_et_Butler_2013a", "Tsuihiji_etal_2011aa", "Varricchio_et_Jackson_2004a", "Vila_etal_2017a", "Wilson_2005aa", "Wilson_2005ab", "Zelenitsky_et_Therrien_2008a")

# Build synpasida metatree:
Synapsida <- metatree::Metatree(MRPDirectory = "~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/MRP", XMLDirectory = "~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/XML", TargetClade = "Synapsida", InclusiveDataList = InclusiveDataList, ExclusiveDataList = ExclusiveDataList, MissingSpecies = "exclude", RelativeWeights = c(0, 100, 10, 1), WeightCombination = "sum", ReportContradictionsToScreen = FALSE)



# Test code for fixing Metatree function!:
MRPDirectory = "~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/MRP"
XMLDirectory = "~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/XML"
InclusiveDataList = InclusiveDataList
ExclusiveDataList = ExclusiveDataList
TargetClade = "Synapsida"
HigherTaxaToCollapse = c()
SpeciesToExclude = c()
MissingSpecies = "exclude"
Interval = NULL
VeilLine = TRUE
IncludeSpecimenLevelOTUs = TRUE
BackboneConstraint = NULL
MonophylyConstraint = NULL
RelativeWeights = c(0, 100, 10, 1)
WeightCombination = "sum"
ReportContradictionsToScreen = FALSE




# Below here is copied from another project and needs editing/deleting




# Build taxonomy tree (for basic checks ahead of building constraint trees):
pdf("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/PDFTrees/TaxonomyTree.pdf", width = 30, height = 50)
plot(Amphibia$TaxonomyTree, cex = 0.3)
nodelabels(Amphibia$TaxonomyTree$node.label, cex = 0.5)
dev.off()

# Build vector of anuran (frog) taxa:
AnuriTaxa <- Amphibia$TaxonomyTree$tip.label[strap::FindDescendants(n = Ntip(Amphibia$TaxonomyTree) + which(Amphibia$TaxonomyTree$node.label == "Anura"), tree = Amphibia$TaxonomyTree)]

# Build vector of cadudatan (salamander) taxa:
CaudataTaxa <- Amphibia$TaxonomyTree$tip.label[strap::FindDescendants(n = Ntip(Amphibia$TaxonomyTree) + which(Amphibia$TaxonomyTree$node.label == "Caudata"), tree = Amphibia$TaxonomyTree)]

# Build vector of batrachian (frog + salamander) taxa:
BatrachiaTaxa <- Amphibia$TaxonomyTree$tip.label[strap::FindDescendants(n = Ntip(Amphibia$TaxonomyTree) + which(Amphibia$TaxonomyTree$node.label == "Batrachia"), tree = Amphibia$TaxonomyTree)]

# Build vector of gymnophoniann (salamander) taxa:
GymnophionaTaxa <- Amphibia$TaxonomyTree$tip.label[strap::FindDescendants(n = Ntip(Amphibia$TaxonomyTree) + which(Amphibia$TaxonomyTree$node.label == "Gymnophiona"), tree = Amphibia$TaxonomyTree)]

# Update gymnophoniann vector to ensure Eocaecilia is included (above will potnetially fail as Eocaecilia alone won't form a clade):
GymnophionaTaxa <- unique(c(GymnophionaTaxa, "Eocaecilia_micropodia"))

# Build vector of lepospondylian taxa:
LepospondyliTaxa <- Amphibia$TaxonomyTree$tip.label[strap::FindDescendants(n = Ntip(Amphibia$TaxonomyTree) + grep("Lepospondyli", Amphibia$TaxonomyTree$node.label), tree = Amphibia$TaxonomyTree)]

# Build vector of temnospondylian taxa:
TemnospondyliTaxa <- Amphibia$TaxonomyTree$tip.label[strap::FindDescendants(n = Ntip(Amphibia$TaxonomyTree) + grep("Eutemnospondyli", Amphibia$TaxonomyTree$node.label), tree = Amphibia$TaxonomyTree)]

# Build vector of lissamphibian (crown amphibians) taxa:
LissamphibiaTaxa <- Amphibia$TaxonomyTree$tip.label[strap::FindDescendants(n = Ntip(Amphibia$TaxonomyTree) + grep("Lissamphibia", Amphibia$TaxonomyTree$node.label), tree = Amphibia$TaxonomyTree)]

# Update temnospondylian vector by removing lissamphibia:
TemnospondyliTaxa <- setdiff(TemnospondyliTaxa, LissamphibiaTaxa)

# Build vector of amniote taxa:
AmniotaTaxa <- Amphibia$TaxonomyTree$tip.label[strap::FindDescendants(n = Ntip(Amphibia$TaxonomyTree) + grep("Amniota", Amphibia$TaxonomyTree$node.label), tree = Amphibia$TaxonomyTree)]

# HYPOTHESIS CONSTRAINT TREES (From Laurin et al. http://dx.doi.org/10.1101/352609):

# 1. Monophyletic lissamphibia amongst temnospondyls:
MonophyleticLissamphibiaInsideTemnospondyli <- ape::collapse.singles(ape::read.tree(text = paste("(", paste(paste("(", paste(LepospondyliTaxa, collapse = ","), ")", sep = ""), paste("(", paste(paste(TemnospondyliTaxa, collapse = ","), paste("(", paste(LissamphibiaTaxa, collapse = ","), ")", sep = ""), sep = ","), ")", sep = ""), sep = ","), ");", sep = "")))

# 2. Monophyletic lissamphibia amongst lepospondyls:
MonophyleticLissamphibiaInsideLepospondyli <- ape::collapse.singles(ape::read.tree(text = paste("(", paste(paste("(", paste(TemnospondyliTaxa, collapse = ","), ")", sep = ""), paste("(", paste(paste(LepospondyliTaxa, collapse = ","), paste("(", paste(LissamphibiaTaxa, collapse = ","), ")", sep = ""), sep = ","), ")", sep = ""), sep = ","), ");", sep = "")))

# 3. Diphyletic lissamphibia, batrachia amongst temnospondyls and gymniophona amongst lepospondyls:
DiphyleticLissamphibiaBatrachiaInsideTemnospondyliGymnophionaInsideLepospondyli <- ape::collapse.singles(ape::read.tree(text = paste("(", paste(paste("(", paste(paste(LepospondyliTaxa, collapse = ","), paste("(", paste(GymnophionaTaxa, collapse = ","), ")", sep = ""), sep = ","), ")", sep = ""), paste("(", paste(paste(TemnospondyliTaxa, collapse = ","), paste("(", paste(BatrachiaTaxa, collapse = ","), ")", sep = ""), collapse = ","), ")", sep = ""), sep = ","), ");", sep = "")))

# 4. Diphyletic lissamphibia inside temnospondyli, batrachia and gymniophona as sepaarte clades:
DiphyleticLissamphibiaInsideTemnospondyli <- ape::collapse.singles(ape::read.tree(text = paste("(", paste(paste("(", paste(LepospondyliTaxa, collapse = ","), ")", sep = ""), paste("(", paste(paste(TemnospondyliTaxa, collapse = ","), paste("(", paste(BatrachiaTaxa, collapse = ","), ")", sep = ""), paste("(", paste(GymnophionaTaxa, collapse = ","), ")", sep = ""), sep = ","), ")", sep = ""), sep = ","), ");", sep = "")))

# 5. Triphyletic Lissamphibia (Anuri and Caudata inside Temnospondyli,\nGymniophona inside Lepospondyli and Crown Lissamphibia monophyletic):
TriphyleticLissamphibiaAnuriAndCaudataInsideTemnospondyliGymnophionaInsideLepospondyliCrownLissamphibiaMonophyletic <-  ape::collapse.singles(ape::read.tree(text = paste("(", paste(paste("(", paste(paste("(", paste(paste(LepospondyliTaxa, collapse = ","), paste("(", paste(GymnophionaTaxa, collapse = ","), ")", sep = ""), sep = ","), ")", sep = ""), paste("(", paste(paste(TemnospondyliTaxa, collapse = ","), paste("(", paste(AnuriTaxa, collapse = ","), ")", sep = ""), paste("(", paste(CaudataTaxa, collapse = ","), ")", sep = ""), sep = ","), ")", sep = ""), sep = ","), ")", sep = ""), paste("(", paste(AmniotaTaxa, collapse = ","), ")", sep = ""), sep = ","), ");", sep = "")))

# 6. Triphyletic Lissamphibia (Anuri and Caudata inside Temnospondyli,\nGymniophona inside Lepospondyli and Crown Lissamphibia paraphyletic to Amniota):
TriphyleticLissamphibiaAnuriAndCaudataInsideTemnospondyliGymnophionaInsideLepospondyliCrownLissamphibiaParaphyleticWithRespectToAmniota <- ape::collapse.singles(ape::read.tree(text = paste("(", paste(paste("(", paste(paste("(", paste(paste(LepospondyliTaxa, collapse = ","), paste("(", paste(GymnophionaTaxa, collapse = ","), ")", sep = ""), sep = ","), ")", sep = ""), paste("(", paste(AmniotaTaxa, collapse = ","), ")", sep = ""), sep = ","), ")", sep = ""), paste("(", paste(paste(TemnospondyliTaxa, collapse = ","), paste("(", paste(AnuriTaxa, collapse = ","), ")", sep = ""), paste("(", paste(CaudataTaxa, collapse = ","), ")", sep = ""), sep = ","), ")", sep = ""), sep = ","), ");", sep = "")))

# Build PDF of constraint trees for visualisation:
pdf("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/PDFTrees/ConstraintTrees.pdf", width = 10, height = 20)
plot(MonophyleticLissamphibiaInsideTemnospondyli, cex = 0.3, main = "1. Monophyletic Lissamphibia inside Temnospondyli")
plot(MonophyleticLissamphibiaInsideLepospondyli, cex = 0.3, main = "2. Monophyletic Lissamphibia inside Lepospondyli")
plot(DiphyleticLissamphibiaBatrachiaInsideTemnospondyliGymnophionaInsideLepospondyli, cex = 0.3, main = "3. Diphyletic Lissamphibia (Batrachia inside Temnospondyli and Gymnophiona inside Lepospondyli)")
plot(DiphyleticLissamphibiaInsideTemnospondyli, cex = 0.3, main = "4. Diphyletic Lissamphibia inside Temnospondyli (Batrachia and Gymnophiona as separate clades)")
plot(TriphyleticLissamphibiaAnuriAndCaudataInsideTemnospondyliGymnophionaInsideLepospondyliCrownLissamphibiaMonophyletic, cex = 0.3, main = "5. Triphyletic Lissamphibia (Anuri and Caudata inside Temnospondyli,\nGymniophona inside Lepospondyli and Crown Lissamphibia monophyletic)")
plot(TriphyleticLissamphibiaAnuriAndCaudataInsideTemnospondyliGymnophionaInsideLepospondyliCrownLissamphibiaParaphyleticWithRespectToAmniota, cex = 0.3, main = "6. Triphyletic Lissamphibia (Anuri and Caudata inside Temnospondyli,\nGymniophona inside Lepospondyli and Crown Lissamphibia paraphyletic to Amniota)")
dev.off()

# Build hypothees into MRP trees:
HypothesisOneMRP <- Tree2MRP(MonophyleticLissamphibiaInsideTemnospondyli)
HypothesisTwoMRP <- Tree2MRP(MonophyleticLissamphibiaInsideLepospondyli)
HypothesisThreeMRP <- Tree2MRP(DiphyleticLissamphibiaBatrachiaInsideTemnospondyliGymnophionaInsideLepospondyli)
HypothesisFourMRP <- Tree2MRP(DiphyleticLissamphibiaInsideTemnospondyli)
HypothesisFiveMRP <- Tree2MRP(TriphyleticLissamphibiaAnuriAndCaudataInsideTemnospondyliGymnophionaInsideLepospondyliCrownLissamphibiaMonophyletic)
HypothesisSixMRP <- Tree2MRP(TriphyleticLissamphibiaAnuriAndCaudataInsideTemnospondyliGymnophionaInsideLepospondyliCrownLissamphibiaParaphyleticWithRespectToAmniota)

# Update outgroup from allzero to a real tetrapod taxon (Westlothiana_lizziae):
rownames(HypothesisOneMRP$Matrix_1$Matrix) <- gsub("allzero", "Westlothiana_lizziae", rownames(HypothesisOneMRP$Matrix_1$Matrix))
rownames(HypothesisTwoMRP$Matrix_1$Matrix) <- gsub("allzero", "Westlothiana_lizziae", rownames(HypothesisTwoMRP$Matrix_1$Matrix))
rownames(HypothesisThreeMRP$Matrix_1$Matrix) <- gsub("allzero", "Westlothiana_lizziae", rownames(HypothesisThreeMRP$Matrix_1$Matrix))
rownames(HypothesisFourMRP$Matrix_1$Matrix) <- gsub("allzero", "Westlothiana_lizziae", rownames(HypothesisFourMRP$Matrix_1$Matrix))
rownames(HypothesisFiveMRP$Matrix_1$Matrix) <- gsub("allzero", "Westlothiana_lizziae", rownames(HypothesisFiveMRP$Matrix_1$Matrix))
rownames(HypothesisSixMRP$Matrix_1$Matrix) <- gsub("allzero", "Westlothiana_lizziae", rownames(HypothesisSixMRP$Matrix_1$Matrix))

# Get vector of indeterminate OTUs:
IndeterminateOTUs <- rownames(Amphibia$FullMRPMatrix$Matrix_1$Matrix)[unlist(lapply(as.list(rownames(Amphibia$FullMRPMatrix$Matrix_1$Matrix)), function(x) length(strsplit(x, "_")[[1]]))) > 2]

# Get vector of OTUs with subgenera in them:
SubgeneraOTUs <- setdiff(unique(c(rownames(HypothesisOneMRP$Matrix_1$Matrix), rownames(HypothesisTwoMRP$Matrix_1$Matrix), rownames(HypothesisThreeMRP$Matrix_1$Matrix), rownames(HypothesisFourMRP$Matrix_1$Matrix), rownames(HypothesisFiveMRP$Matrix_1$Matrix), rownames(HypothesisSixMRP$Matrix_1$Matrix))), IndeterminateOTUs)[unlist(lapply(as.list(setdiff(rownames(HypothesisOneMRP$Matrix_1$Matrix), IndeterminateOTUs)), function(x) nchar(gsub("[:a-z:]|_", "", x)))) > 1]

# Get correctly formatted version of subgenus names:
FormattedSubgeneraOTUNames <- unlist(lapply(as.list(SubgeneraOTUs), function(x) {SplitName <- strsplit(x, "")[[1]]; SubgenusPosition <- grep("[:A-Z:]", SplitName)[2]; SplitName[SubgenusPosition] <- paste("_(", SplitName[SubgenusPosition], sep = ""); SpeciesPosition <- which(SplitName == "_"); SplitName[SpeciesPosition] <- ")_"; paste(SplitName, collapse = "")}))

# Get vector of all other (regular) OTUs:
RegularOTUs <- sort(setdiff(unique(c(rownames(HypothesisOneMRP$Matrix_1$Matrix), rownames(HypothesisTwoMRP$Matrix_1$Matrix), rownames(HypothesisThreeMRP$Matrix_1$Matrix), rownames(HypothesisFourMRP$Matrix_1$Matrix), rownames(HypothesisFiveMRP$Matrix_1$Matrix), rownames(HypothesisSixMRP$Matrix_1$Matrix))), c(IndeterminateOTUs, SubgeneraOTUs)))

# Build matrix of all taxonomic reconciliation from XML:
AllXML <- do.call(rbind, lapply(as.list(InclusiveDataList), function(x) metatree::ReadMetatreeXML(paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/XML/", x, ".xml", sep = ""))$SourceTree$Taxa$TagContents))

# Get vector of recon numbers for OTU names:
IndeterminateOTUReconNumbers <- AllXML[match(IndeterminateOTUs, AllXML[, "recon_name"]), "recon_no"]

# Perform a database query to get the recon numbers for the non-indeterminate taxa:
DatabaseQuery <- PaleobiologyDBTaxaQuerier("1", c(RegularOTUs, FormattedSubgeneraOTUNames))

# Build recon table to draw from in building constraint tree XMLs:
ReconTable <- cbind(c(RegularOTUs, SubgeneraOTUs, IndeterminateOTUs), c(unlist(lapply(apply(DatabaseQuery[, 1:2], 1, as.list), function(x) {x <- gsub("txn:|var:", "", unlist(x)); unname(x[!is.na(x)][1])})), IndeterminateOTUReconNumbers), c(RegularOTUs, FormattedSubgeneraOTUNames, IndeterminateOTUs))

# Add column names to table:
colnames(ReconTable) <- c("OTUName", "ReconNumber", "ReconName")

# Set working directory to XMLs:
setwd("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/XML")

# Read in first XML to use as template:
EmptyXML <- metatree::ReadMetatreeXML(list.files()[1])

# Make an empty XML by deleting most of the existing information:
EmptyXML$SourceTree$Source$Author <- list(TagContents = matrix("NA", nrow = 1, ncol = 1, dimnames = list(c(), c("ListValue"))), TagSupplement = list(NULL))
EmptyXML$SourceTree$Source$Year <- list(NULL)
EmptyXML$SourceTree$Source$Title <- list(NULL)
EmptyXML$SourceTree$Source$Journal <- list(NULL)
EmptyXML$SourceTree$Source$Volume <- list(NULL)
EmptyXML$SourceTree$Source$Pages <- list(NULL)
EmptyXML$SourceTree$Source$Booktitle <- list(NULL)
EmptyXML$SourceTree$Source$Publisher <- list(NULL)
EmptyXML$SourceTree$Source$City <- list(NULL)
EmptyXML$SourceTree$Source$Editor <- list(NULL)
EmptyXML$SourceTree$Characters$Molecular <- list(NULL)
EmptyXML$SourceTree$Characters$Morphological <- list(NULL)
EmptyXML$SourceTree$Characters$Behavioural <- list(NULL)
EmptyXML$SourceTree$Characters$Other <- list(TagContents = matrix("MRP", nrow = 1, ncol = 1, dimnames = list(c(), c("TypeValue"))), TagSupplement = matrix(c("Measure", "1"), nrow = 1, ncol = 2, dimnames = list(c(), c("Measure", "Value"))))
EmptyXML$SourceTree$Notes <- list(TagContents = "Constraint tree.", TagSupplement = list(NULL))
EmptyXML$SourceTree$Parent <- list(NULL)
EmptyXML$SourceTree$Sibling <- list(NULL)

# Copy empty XML to create each hypothesis XML:
HypothesisOneXML <- HypothesisTwoXML <- HypothesisThreeXML <- HypothesisFourXML <- HypothesisFiveXML <- HypothesisSixXML <- EmptyXML

# Build XMLs for every hypothesis:
HypothesisOneXML$SourceTree$Taxa <- list(TagContents = matrix(as.vector(ReconTable[match(rownames(HypothesisOneMRP$Matrix_1$Matrix), ReconTable[, "OTUName"]), c("ReconName", "ReconNumber", "OTUName")]), ncol = 3, byrow = FALSE, dimnames = list(c(), c("recon_name", "recon_no", "ListValue"))), TagSupplement = matrix(c("number", as.character(nrow(HypothesisOneMRP$Matrix_1$Matrix))), nrow = 1, ncol = 2, dimnames = list(c(), c("Measure", "Value"))))
HypothesisTwoXML$SourceTree$Taxa <- list(TagContents = matrix(as.vector(ReconTable[match(rownames(HypothesisTwoMRP$Matrix_1$Matrix), ReconTable[, "OTUName"]), c("ReconName", "ReconNumber", "OTUName")]), ncol = 3, byrow = FALSE, dimnames = list(c(), c("recon_name", "recon_no", "ListValue"))), TagSupplement = matrix(c("number", as.character(nrow(HypothesisTwoMRP$Matrix_1$Matrix))), nrow = 1, ncol = 2, dimnames = list(c(), c("Measure", "Value"))))
HypothesisThreeXML$SourceTree$Taxa <- list(TagContents = matrix(as.vector(ReconTable[match(rownames(HypothesisThreeMRP$Matrix_1$Matrix), ReconTable[, "OTUName"]), c("ReconName", "ReconNumber", "OTUName")]), ncol = 3, byrow = FALSE, dimnames = list(c(), c("recon_name", "recon_no", "ListValue"))), TagSupplement = matrix(c("number", as.character(nrow(HypothesisThreeMRP$Matrix_1$Matrix))), nrow = 1, ncol = 2, dimnames = list(c(), c("Measure", "Value"))))
HypothesisFourXML$SourceTree$Taxa <- list(TagContents = matrix(as.vector(ReconTable[match(rownames(HypothesisFourMRP$Matrix_1$Matrix), ReconTable[, "OTUName"]), c("ReconName", "ReconNumber", "OTUName")]), ncol = 3, byrow = FALSE, dimnames = list(c(), c("recon_name", "recon_no", "ListValue"))), TagSupplement = matrix(c("number", as.character(nrow(HypothesisFourMRP$Matrix_1$Matrix))), nrow = 1, ncol = 2, dimnames = list(c(), c("Measure", "Value"))))
HypothesisFiveXML$SourceTree$Taxa <- list(TagContents = matrix(as.vector(ReconTable[match(rownames(HypothesisFiveMRP$Matrix_1$Matrix), ReconTable[, "OTUName"]), c("ReconName", "ReconNumber", "OTUName")]), ncol = 3, byrow = FALSE, dimnames = list(c(), c("recon_name", "recon_no", "ListValue"))), TagSupplement = matrix(c("number", as.character(nrow(HypothesisFiveMRP$Matrix_1$Matrix))), nrow = 1, ncol = 2, dimnames = list(c(), c("Measure", "Value"))))
HypothesisSixXML$SourceTree$Taxa <- list(TagContents = matrix(as.vector(ReconTable[match(rownames(HypothesisSixMRP$Matrix_1$Matrix), ReconTable[, "OTUName"]), c("ReconName", "ReconNumber", "OTUName")]), ncol = 3, byrow = FALSE, dimnames = list(c(), c("recon_name", "recon_no", "ListValue"))), TagSupplement = matrix(c("number", as.character(nrow(HypothesisSixMRP$Matrix_1$Matrix))), nrow = 1, ncol = 2, dimnames = list(c(), c("Measure", "Value"))))

# Update character number in XMLs:
HypothesisOneXML$SourceTree$Characters$Other$TagSupplement[, "Value"] <- as.character(ncol(HypothesisOneMRP$Matrix_1$Matrix))
HypothesisTwoXML$SourceTree$Characters$Other$TagSupplement[, "Value"] <- as.character(ncol(HypothesisTwoMRP$Matrix_1$Matrix))
HypothesisThreeXML$SourceTree$Characters$Other$TagSupplement[, "Value"] <- as.character(ncol(HypothesisThreeMRP$Matrix_1$Matrix))
HypothesisFourXML$SourceTree$Characters$Other$TagSupplement[, "Value"] <- as.character(ncol(HypothesisFourMRP$Matrix_1$Matrix))
HypothesisFiveXML$SourceTree$Characters$Other$TagSupplement[, "Value"] <- as.character(ncol(HypothesisFiveMRP$Matrix_1$Matrix))
HypothesisSixXML$SourceTree$Characters$Other$TagSupplement[, "Value"] <- as.character(ncol(HypothesisSixMRP$Matrix_1$Matrix))

# Update file names in XMLs:
HypothesisOneXML$SourceTree$Filename <- HypothesisTwoXML$SourceTree$Filename <- HypothesisThreeXML$SourceTree$Filename <- HypothesisFourXML$SourceTree$Filename <- HypothesisFiveXML$SourceTree$Filename <- HypothesisSixXML$SourceTree$Filename <- list(TagContents = paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""), TagSupplements = list(NULL))

# Create copies of XML files to each hypothesis folder:
x <- lapply(as.list(InclusiveDataList), function(x) file.copy(from = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/XML/", x, ".xml", sep = ""), to =  paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisOne/XML/", x, ".xml", sep = "")))
x <- lapply(as.list(InclusiveDataList), function(x) file.copy(from = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/XML/", x, ".xml", sep = ""), to =  paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisTwo/XML/", x, ".xml", sep = "")))
x <- lapply(as.list(InclusiveDataList), function(x) file.copy(from = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/XML/", x, ".xml", sep = ""), to =  paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisThree/XML/", x, ".xml", sep = "")))
x <- lapply(as.list(InclusiveDataList), function(x) file.copy(from = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/XML/", x, ".xml", sep = ""), to =  paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFour/XML/", x, ".xml", sep = "")))
x <- lapply(as.list(InclusiveDataList), function(x) file.copy(from = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/XML/", x, ".xml", sep = ""), to =  paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFive/XML/", x, ".xml", sep = "")))
x <- lapply(as.list(InclusiveDataList), function(x) file.copy(from = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/XML/", x, ".xml", sep = ""), to =  paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisSix/XML/", x, ".xml", sep = "")))

# Create copies of MRP files to each hypothesis folder:
x <- lapply(as.list(InclusiveDataList), function(x) file.copy(from = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/MRP/", x, "mrp.nex", sep = ""), to = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisOne/MRP/", x, "mrp.nex", sep = "")))
x <- lapply(as.list(InclusiveDataList), function(x) file.copy(from = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/MRP/", x, "mrp.nex", sep = ""), to = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisTwo/MRP/", x, "mrp.nex", sep = "")))
x <- lapply(as.list(InclusiveDataList), function(x) file.copy(from = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/MRP/", x, "mrp.nex", sep = ""), to = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisThree/MRP/", x, "mrp.nex", sep = "")))
x <- lapply(as.list(InclusiveDataList), function(x) file.copy(from = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/MRP/", x, "mrp.nex", sep = ""), to = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFour/MRP/", x, "mrp.nex", sep = "")))
x <- lapply(as.list(InclusiveDataList), function(x) file.copy(from = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/MRP/", x, "mrp.nex", sep = ""), to = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFive/MRP/", x, "mrp.nex", sep = "")))
x <- lapply(as.list(InclusiveDataList), function(x) file.copy(from = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/MRP/", x, "mrp.nex", sep = ""), to = paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisSix/MRP/", x, "mrp.nex", sep = "")))

# Write out constraint MRPs:
Claddis::WriteMorphNexus(HypothesisOneMRP, paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisOne/MRP/", paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""), "mrp.nex", sep = ""))
Claddis::WriteMorphNexus(HypothesisTwoMRP, paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisTwo/MRP/", paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""), "mrp.nex", sep = ""))
Claddis::WriteMorphNexus(HypothesisThreeMRP, paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisThree/MRP/", paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""), "mrp.nex", sep = ""))
Claddis::WriteMorphNexus(HypothesisFourMRP, paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFour/MRP/", paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""), "mrp.nex", sep = ""))
Claddis::WriteMorphNexus(HypothesisFiveMRP, paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFive/MRP/", paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""), "mrp.nex", sep = ""))
Claddis::WriteMorphNexus(HypothesisSixMRP, paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisSix/MRP/", paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""), "mrp.nex", sep = ""))

# Write out XML files for each hypthesis:
metatree::WriteMetatreeXML(HypothesisOneXML, paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisOne/XML/", paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""), ".xml", sep = ""))
metatree::WriteMetatreeXML(HypothesisTwoXML, paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisTwo/XML/", paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""), ".xml", sep = ""))
metatree::WriteMetatreeXML(HypothesisThreeXML, paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisThree/XML/", paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""), ".xml", sep = ""))
metatree::WriteMetatreeXML(HypothesisFourXML, paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFour/XML/", paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""), ".xml", sep = ""))
metatree::WriteMetatreeXML(HypothesisFiveXML, paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFive/XML/", paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""), ".xml", sep = ""))
metatree::WriteMetatreeXML(HypothesisSixXML, paste("~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisSix/XML/", paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""), ".xml", sep = ""))

# Build meattree datasets for each hypothesis:
HypothesisOne <- metatree::Metatree(MRPDirectory = "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisOne/MRP", XMLDirectory = "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisOne/XML", TargetClade = "Tetrapoda", InclusiveDataList = c(), ExclusiveDataList = ExclusiveDataList, MissingSpecies = "exclude", RelativeWeights = c(0, 100, 10, 1), WeightCombination = "sum", ReportContradictionsToScreen = FALSE, BackboneConstraint = paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""))
HypothesisTwo <- metatree::Metatree(MRPDirectory = "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisTwo/MRP", XMLDirectory = "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisTwo/XML", TargetClade = "Tetrapoda", InclusiveDataList = c(), ExclusiveDataList = ExclusiveDataList, MissingSpecies = "exclude", RelativeWeights = c(0, 100, 10, 1), WeightCombination = "sum", ReportContradictionsToScreen = FALSE, BackboneConstraint = paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""))
HypothesisThree <- metatree::Metatree(MRPDirectory = "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisThree/MRP", XMLDirectory = "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisThree/XML", TargetClade = "Tetrapoda", InclusiveDataList = c(), ExclusiveDataList = ExclusiveDataList, MissingSpecies = "exclude", RelativeWeights = c(0, 100, 10, 1), WeightCombination = "sum", ReportContradictionsToScreen = FALSE, BackboneConstraint = paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""))
HypothesisFour <- metatree::Metatree(MRPDirectory = "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFour/MRP", XMLDirectory = "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFour/XML", TargetClade = "Tetrapoda", InclusiveDataList = c(), ExclusiveDataList = ExclusiveDataList, MissingSpecies = "exclude", RelativeWeights = c(0, 100, 10, 1), WeightCombination = "sum", ReportContradictionsToScreen = FALSE, BackboneConstraint = paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""))
HypothesisFive <- metatree::Metatree(MRPDirectory = "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFive/MRP", XMLDirectory = "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFive/XML", TargetClade = "Tetrapoda", InclusiveDataList = c(), ExclusiveDataList = ExclusiveDataList, MissingSpecies = "exclude", RelativeWeights = c(0, 100, 10, 1), WeightCombination = "sum", ReportContradictionsToScreen = FALSE, BackboneConstraint = paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""))
HypothesisSix <- metatree::Metatree(MRPDirectory = "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisSix/MRP", XMLDirectory = "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisSix/XML", TargetClade = "Tetrapoda", InclusiveDataList = c(), ExclusiveDataList = ExclusiveDataList, MissingSpecies = "exclude", RelativeWeights = c(0, 100, 10, 1), WeightCombination = "sum", ReportContradictionsToScreen = FALSE, BackboneConstraint = paste("Constraint_", strsplit(as.character(Sys.Date()), split = "-")[[1]][1], "a", sep = ""))

# Write out full matrix as NEXUS:
Claddis::WriteMorphNexus(HypothesisOne$FullMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisOne/MetatreeFiles/TetrapodaFull.nex")
Claddis::WriteMorphNexus(HypothesisTwo$FullMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisTwo/MetatreeFiles/TetrapodaFull.nex")
Claddis::WriteMorphNexus(HypothesisThree$FullMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisThree/MetatreeFiles/TetrapodaFull.nex")
Claddis::WriteMorphNexus(HypothesisFour$FullMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFour/MetatreeFiles/TetrapodaFull.nex")
Claddis::WriteMorphNexus(HypothesisFive$FullMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFive/MetatreeFiles/TetrapodaFull.nex")
Claddis::WriteMorphNexus(HypothesisSix$FullMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisSix/MetatreeFiles/TetrapodaFull.nex")

# Write out full matrix as TNT:
Claddis::WriteMorphTNT(HypothesisOne$FullMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisOne/MetatreeFiles/TetrapodaFull.tnt")
Claddis::WriteMorphTNT(HypothesisTwo$FullMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisTwo/MetatreeFiles/TetrapodaFull.tnt")
Claddis::WriteMorphTNT(HypothesisThree$FullMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisThree/MetatreeFiles/TetrapodaFull.tnt")
Claddis::WriteMorphTNT(HypothesisFour$FullMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFour/MetatreeFiles/TetrapodaFull.tnt")
Claddis::WriteMorphTNT(HypothesisFive$FullMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFive/MetatreeFiles/TetrapodaFull.tnt")
Claddis::WriteMorphTNT(HypothesisSix$FullMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisSix/MetatreeFiles/TetrapodaFull.tnt")

# Write out STR matrix as NEXUS:
Claddis::WriteMorphNexus(HypothesisOne$STRMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisOne/MetatreeFiles/TetrapodaSTR.nex")
Claddis::WriteMorphNexus(HypothesisTwo$STRMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisTwo/MetatreeFiles/TetrapodaSTR.nex")
Claddis::WriteMorphNexus(HypothesisThree$STRMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisThree/MetatreeFiles/TetrapodaSTR.nex")
Claddis::WriteMorphNexus(HypothesisFour$STRMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFour/MetatreeFiles/TetrapodaSTR.nex")
Claddis::WriteMorphNexus(HypothesisFive$STRMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFive/MetatreeFiles/TetrapodaSTR.nex")
Claddis::WriteMorphNexus(HypothesisSix$STRMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisSix/MetatreeFiles/TetrapodaSTR.nex")

# Write out STR matrix as TNT:
Claddis::WriteMorphTNT(HypothesisOne$STRMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisOne/MetatreeFiles/TetrapodaSTR.tnt")
Claddis::WriteMorphTNT(HypothesisTwo$STRMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisTwo/MetatreeFiles/TetrapodaSTR.tnt")
Claddis::WriteMorphTNT(HypothesisThree$STRMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisThree/MetatreeFiles/TetrapodaSTR.tnt")
Claddis::WriteMorphTNT(HypothesisFour$STRMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFour/MetatreeFiles/TetrapodaSTR.tnt")
Claddis::WriteMorphTNT(HypothesisFive$STRMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFive/MetatreeFiles/TetrapodaSTR.tnt")
Claddis::WriteMorphTNT(HypothesisSix$STRMRPMatrix, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisSix/MetatreeFiles/TetrapodaSTR.tnt")

# Write out taxonomy trees:
ape::write.tree(HypothesisOne$TaxonomyTree, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisOne/MetatreeFiles/Taxonomy.tre")
ape::write.tree(HypothesisTwo$TaxonomyTree, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisTwo/MetatreeFiles/Taxonomy.tre")
ape::write.tree(HypothesisThree$TaxonomyTree, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisThree/MetatreeFiles/Taxonomy.tre")
ape::write.tree(HypothesisFour$TaxonomyTree, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFour/MetatreeFiles/Taxonomy.tre")
ape::write.tree(HypothesisFive$TaxonomyTree, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFive/MetatreeFiles/Taxonomy.tre")
ape::write.tree(HypothesisSix$TaxonomyTree, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisSix/MetatreeFiles/Taxonomy.tre")

# Write out STR data:
write.table(HypothesisOne$SafelyRemovedTaxa, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisOne/MetatreeFiles/STR.txt", row.names = FALSE)
write.table(HypothesisTwo$SafelyRemovedTaxa, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisTwo/MetatreeFiles/STR.txt", row.names = FALSE)
write.table(HypothesisThree$SafelyRemovedTaxa, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisThree/MetatreeFiles/STR.txt", row.names = FALSE)
write.table(HypothesisFour$SafelyRemovedTaxa, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFour/MetatreeFiles/STR.txt", row.names = FALSE)
write.table(HypothesisFive$SafelyRemovedTaxa, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFive/MetatreeFiles/STR.txt", row.names = FALSE)
write.table(HypothesisSix$SafelyRemovedTaxa, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisSix/MetatreeFiles/STR.txt", row.names = FALSE)

# Write out removed data sets:
write(HypothesisOne$RemovedSourceData, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisOne/MetatreeFiles/RemovedSourceData.txt")
write(HypothesisTwo$RemovedSourceData, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisTwo/MetatreeFiles/RemovedSourceData.txt")
write(HypothesisThree$RemovedSourceData, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisThree/MetatreeFiles/RemovedSourceData.txt")
write(HypothesisFour$RemovedSourceData, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFour/MetatreeFiles/RemovedSourceData.txt")
write(HypothesisFive$RemovedSourceData, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFive/MetatreeFiles/RemovedSourceData.txt")
write(HypothesisSix$RemovedSourceData, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisSix/MetatreeFiles/RemovedSourceData.txt")

# Write out veil years:
write(HypothesisOne$CurrentVeilYear, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisOne/MetatreeFiles/VeilYear.txt")
write(HypothesisTwo$CurrentVeilYear, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisTwo/MetatreeFiles/VeilYear.txt")
write(HypothesisThree$CurrentVeilYear, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisThree/MetatreeFiles/VeilYear.txt")
write(HypothesisFour$CurrentVeilYear, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFour/MetatreeFiles/VeilYear.txt")
write(HypothesisFive$CurrentVeilYear, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisFive/MetatreeFiles/VeilYear.txt")
write(HypothesisSix$CurrentVeilYear, "~/Documents/Publications/in prep/Temnospondyl Supertree 2 - Dan/ProjectHardhead/HypothesisSix/MetatreeFiles/VeilYear.txt")

# Write out STR matrix as TNT:
Claddis::WriteMorphTNT(HypothesisOne$STRMRPMatrix, "~/HypothesisOneSTR.tnt", add.analysis.block = FALSE)
Claddis::WriteMorphTNT(HypothesisTwo$STRMRPMatrix, "~/HypothesisTwoSTR.tnt", add.analysis.block = FALSE)
Claddis::WriteMorphTNT(HypothesisThree$STRMRPMatrix, "~/HypothesisThreeSTR.tnt", add.analysis.block = FALSE)
Claddis::WriteMorphTNT(HypothesisFour$STRMRPMatrix, "~/HypothesisFourSTR.tnt", add.analysis.block = FALSE)
Claddis::WriteMorphTNT(HypothesisFive$STRMRPMatrix, "~/HypothesisFiveSTR.tnt", add.analysis.block = FALSE)
Claddis::WriteMorphTNT(HypothesisSix$STRMRPMatrix, "~/HypothesisSixSTR.tnt", add.analysis.block = FALSE)

# Read in raw text of TNT files:
HypothesisOneSTR <- readLines("~/HypothesisOneSTR.tnt")
HypothesisTwoSTR <- readLines("~/HypothesisTwoSTR.tnt")
HypothesisThreeSTR <- readLines("~/HypothesisThreeSTR.tnt")
HypothesisFourSTR <- readLines("~/HypothesisFourSTR.tnt")
HypothesisFiveSTR <- readLines("~/HypothesisFiveSTR.tnt")
HypothesisSixSTR <- readLines("~/HypothesisSixSTR.tnt")

# Add analysis block to TNT text:
HypothesisOneSTR <- gsub("proc/;", "rseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch1.tre;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch1.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch1.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch1.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch1.tre +;\nsave;\ntsave /;\nhold 1000;\nshortread scratch1.tre;\nbbreak=tbr;\nexport -HypothesisOneSTRMPTs.nex;\nproc/;", HypothesisOneSTR)
HypothesisTwoSTR <- gsub("proc/;", "rseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch2.tre;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch2.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch2.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch2.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch2.tre +;\nsave;\ntsave /;\nhold 1000;\nshortread scratch2.tre;\nbbreak=tbr;\nexport -HypothesisTwoSTRMPTs.nex;\nproc/;", HypothesisTwoSTR)
HypothesisThreeSTR <- gsub("proc/;", "rseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nhold 1000;\nshortread scratch3.tre;\nbbreak=tbr;\nexport -HypothesisThreeSTRMPTs.nex;\nproc/;", HypothesisThreeSTR)
HypothesisFourSTR <- gsub("proc/;", "rseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch4.tre;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch4.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch4.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch4.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch4.tre +;\nsave;\ntsave /;\nhold 1000;\nshortread scratch4.tre;\nbbreak=tbr;\nexport -HypothesisFourSTRMPTs.nex;\nproc/;", HypothesisFourSTR)
HypothesisFiveSTR <- gsub("proc/;", "rseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch5.tre;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch5.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch5.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch5.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch5.tre +;\nsave;\ntsave /;\nhold 1000;\nshortread scratch5.tre;\nbbreak=tbr;\nexport -HypothesisFiveSTRMPTs.nex;\nproc/;", HypothesisFiveSTR)
HypothesisSixSTR <- gsub("proc/;", "rseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch6.tre;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch6.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch6.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch6.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch6.tre +;\nsave;\ntsave /;\nhold 1000;\nshortread scratch6.tre;\nbbreak=tbr;\nexport -HypothesisSixSTRMPTs.nex;\nproc/;", HypothesisSixSTR)

# Write TNT back out to file:
write(HypothesisOneSTR, "~/HypothesisOneSTR.tnt")
write(HypothesisTwoSTR, "~/HypothesisTwoSTR.tnt")
write(HypothesisThreeSTR, "~/HypothesisThreeSTR.tnt")
write(HypothesisFourSTR, "~/HypothesisFourSTR.tnt")
write(HypothesisFiveSTR, "~/HypothesisFiveSTR.tnt")
write(HypothesisSixSTR, "~/HypothesisSixSTR.tnt")

