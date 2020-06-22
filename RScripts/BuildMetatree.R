# SCRIPT TO BUILD METATREE FILES

# TO DO:
#
# - Maybe add node names to Sidor and Hopson constraint

# Load metatree library:
library(metatree)

# Set variables:
MRPDirectory <- "~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/MRP"
XMLDirectory <- "~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/XML"
MetatreeDirectory <- "~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/Metatree"
InclusiveDataList <- sort(c(GetFilesForClade("matrsyna.html"), "Ezcurra_etal_2014a", "Ford_et_Benson_2019a", "MacDougall_et_Reisz_2012a", "MacDougall_etal_2016a", "Modesto_etal_2009a", "Modesto_etal_2014a", "Modesto_etal_2015a", "Muller_et_Tsuji_2007a", "Reisz_etal_2011b", "Reisz_etal_2014a", "Reisz_etal_2015a", "Rieppel_et_deBraga_1996a", "Tsuji_etal_2010a", "Tsuji_etal_2012a"))
ExclusiveDataList <- c("Averianov_2016a", "Bravo_et_Gaete_2015a", "Brocklehurst_etal_2013a", "Brocklehurst_etal_2015aa", "Brocklehurst_etal_2015ab", "Brocklehurst_etal_2015ac", "Brocklehurst_etal_2015ad", "Brocklehurst_etal_2015ae", "Brocklehurst_etal_2015af", "Bronzati_etal_2012a", "Bronzati_etal_2015ab", "Brusatte_etal_2009ba", "Campbell_etal_2016ab", "Carr_et_Williamson_2004a", "Carr_etal_2017ab", "Frederickson_et_Tumarkin-Deratzian_2014aa", "Frederickson_et_Tumarkin-Deratzian_2014ab", "Frederickson_et_Tumarkin-Deratzian_2014ac", "Frederickson_et_Tumarkin-Deratzian_2014ad", "Garcia_etal_2006a", "Gatesy_etal_2004ab", "Grellet-Tinner_2006a", "Grellet-Tinner_et_Chiappe_2004a", "Grellet-Tinner_et_Makovicky_2006a", "Jin_etal_2010a", "Knoll_2008a", "Kurochkin_1996a", "Lopez-Martinez_et_Vicens_2012a", "Lu_etal_2014aa", "Norden_etal_2018a", "Pisani_etal_2002a", "Ruiz-Omenaca_etal_1997a", "Ruta_etal_2003ba", "Ruta_etal_2003bb", "Ruta_etal_2007a", "Schaeffer_etal_inpressa", "Selles_et_Galobart_2016a", "Sereno_1993a", "Sidor_2001a","Sidor_2003a", "Skutschas_etal_2019a", "Tanaka_etal_2011a", "Toljagic_et_Butler_2013a", "Tsuihiji_etal_2011aa", "Varricchio_et_Jackson_2004a", "Vila_etal_2017a", "Wilson_2005aa", "Wilson_2005ab", "Zelenitsky_et_Therrien_2008a")
TargetClade = "Synapsida"
MissingSpecies = "exclude"
RelativeWeights = c(0, 100, 10, 1)
WeightCombination = "sum"
ReportContradictionsToScreen = FALSE
SpeciesToExclude = c("Pristerodon_sp_SAM_dash_PK_dash_K09997", "Pristerodon_sp_SAM_dash_PK_dash_K01658", "Pristerodon_sp_SAM_dash_PK_dash_10161", "Pristerodon_sp_SAM_dash_PK_dash_10141", "Pristerodon_sp_SAM_dash_PK_dash_010153", "Pristerodon_sp_SAM_dash_PK_dash_006560", "Pristerodon_sp_SAM_PK_dash_K1658", "Pristerodon_sp_SAM_PK10153", "Pristerodon_whaitsi", "Kannemeyeria_sp_SAM_dash_PK_dash_K04826", "Kannemeyeria_sp_SAM_dash_PK_dash_2771", "Kannemeyeria_sp_SAM_dash_PK_dash_11269", "Kannemeyeria_sp_SAM_PK_11262", "Kannemeyeria_sp_SAM_PK_1073", "Kannemeyeria_sp_BP_dash_1_dash_994", "Kannemeyeria_sp_BP_dash_1_dash_3518", "Kannemeyeria_sp_BP_dash_1_dash_1669", "Kannemeyeria_wilsoni", "Lystrosaurus_robustus", "Lystrosaurus_broomi", "Lystrosaurus_shichanggouensis", "Aelurosaurus_sp_BP_slash_1_slash_216", "Akidnognathidae_indet_USNM_PAL_412421", "Aulacocephalodon_sp_SAM_dash_PK_dash_K06064", "Biarmosuchus_cf_tener_PIN_1758_slash_7_et_18", "Burnetiamorpha_indet_BP_1_7098", "Burnetiamorpha_indet_NHMUK_R871", "Burnetiamorpha_indet_TM_4305", "Cyonosaurus_sp_BP_slash_1_slash_735", "Dicynodon_sp_PIN_4415_dash_1", "Dicynodon_sp_SAM_dash_B88", "Dicynodon_sp_SAM_dash_PK_dash_12002", "Dicynodon_sp_SAM_dash_PK_dash_K00138", "Dicynodon_sp_SAM_dash_PK_dash_K07011", "Dicynodon_sp_SAM_dash_PK_dash_K07482", "Dicynodon_sp_SAM_dash_PK_dash_K1687", "Dicynodon_sp_SAM_dash_PK_dash_K6580", "Dicynodon_sp_SGU_104_slash_3884", "Dicynodontoidea_indet_GSP_AF9683", "Dimetrodon_sp_FMNH_P_12761", "Dimetrodon_sp_FMNH_P_12762", "Dimetrodon_sp_FMNH_UC_1153", "Dimetrodon_sp_FMNH_UC_1174", "Dimetrodon_sp_FMNH_UC_18", "Dimetrodon_sp_FMNH_UC_414", "Dimetrodon_sp_FMNH_UC_49", "Dimetrodon_sp_FMNH_UC_753", "Dimetrodon_sp_FMNH_UC_756", "Edaphosauridae_indet_CM_47699", "Edaphosaurus_sp_KUVP_1425", "Edaphosaurus_sp_MCZ_3417", "Edaphosaurus_sp_SaP_344", "Edaphosaurus_sp_USNM_299844", "Emydopoidea_indet_NHMUK_PV_R12453", "Emydopoidea_indet_NMT_RB230", "Emydops_sp_BP_slash_1_slash_2366", "Emydops_sp_SAM_PK10148", "Emydops_sp_SAM_PK11060", "Emydops_sp_SAM_PK3721", "Galeops_sp_SAM_PK_004005", "Gorgonopsia_indet_BP_slash_1_slash_155", "Heleosaurus_sp_BP_slash_I_slash_5678", "Hipposaurus_sp_CGP_slash_1_slash_66", "Ictidorhinidae_indet_CGP_slash_1_slash_67", "Kannemeyeria_sp_BP_dash_1_dash_1669", "Kannemeyeria_sp_BP_dash_1_dash_3518", "Kannemeyeria_sp_BP_dash_1_dash_994", "Kannemeyeria_sp_SAM_PK_1073", "Kannemeyeria_sp_SAM_PK_11262", "Kannemeyeria_sp_SAM_dash_PK_dash_11269", "Kannemeyeria_sp_SAM_dash_PK_dash_2771", "Kannemeyeria_sp_SAM_dash_PK_dash_K04826", "Lystrosauridae_indet_TSK_2", "Lystrosaurus_sp_CAMZM_T758", "Lystrosaurus_sp_SAM_dash_PK_dash_K01415", "Lystrosaurus_sp_SAM_dash_PK_dash_K1371", "Oligokyphus_sp_MCZ_8845_et_8846_et_8848_et_8851_et_8868_et_8897_et_8843", "Oligokyphus_sp_NSM012GF014_dot_006", "Ophiacodon_sp_FMNH_UC_1156", "Pristerodon_sp_BPI_3024", "Pristerodon_sp_BP_slash_1_slash_2390", "Pristerodon_sp_BP_slash_1_slash_2412", "Pristerodon_sp_BP_slash_1_slash_2642", "Pristerodon_sp_SAM_PK10153", "Pristerodon_sp_SAM_PK_dash_K1658", "Pristerodon_sp_SAM_dash_PK_dash_006560", "Pristerodon_sp_SAM_dash_PK_dash_010153", "Pristerodon_sp_SAM_dash_PK_dash_10141", "Pristerodon_sp_SAM_dash_PK_dash_10161", "Pristerodon_sp_SAM_dash_PK_dash_K01658", "Pristerodon_sp_SAM_dash_PK_dash_K09997", "Regisauridae_indet_UMCZ_T837", "Rhachiocephalus_sp_SAM_PK_K01393", "Rhachiocephalus_sp_UMZC_T1283", "Rhachiocephalus_sp_USNM_410287", "Rhadiodromus_sp_PIN_1579_dash_14", "Trirachodon_sp_JSM_100", "Trirachodontidae_indet_BP_slash_1_slash_4534", "Varanopidae_indet_SAM_dash_PK_dash_K10407", "Gorgodon_minutus", "Dimacrodon_hottoni")
HigherTaxaToCollapse = c()
Interval = NULL
VeilLine = TRUE
IncludeSpecimenLevelOTUs = TRUE
BackboneConstraint = NULL
MonophylyConstraint = NULL
ExcludeTaxonomyMRP = FALSE

# Build synpasida metatree:
Synapsida <- metatree::Metatree(MRPDirectory = MRPDirectory, XMLDirectory = XMLDirectory, TargetClade = TargetClade, InclusiveDataList = InclusiveDataList, ExclusiveDataList = ExclusiveDataList, MissingSpecies = MissingSpecies, SpeciesToExclude = SpeciesToExclude, RelativeWeights = RelativeWeights, WeightCombination = WeightCombination, ReportContradictionsToScreen = ReportContradictionsToScreen)

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
WriteMorphNexus(MRP, "~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/MRP/Constraint_2020amrp.nex")

# Get first set of reconciled names:
ReconciledNames <- rbind(cbind(unlist(lapply(apply(metatree::PaleobiologyDBTaxaQuerier("1", rownames(MRP$Matrix_1$Matrix)[unlist(lapply(strsplit(rownames(MRP$Matrix_1$Matrix), split = "_"), length)) == 2]), 1, as.list), function(x) {x <- unlist(x)[1:2]; unname(gsub("txn:|var:", "", x[!is.na(x)][1]))})), rownames(MRP$Matrix_1$Matrix)[unlist(lapply(strsplit(rownames(MRP$Matrix_1$Matrix), split = "_"), length)) == 2]), if(any(unlist(lapply(strsplit(rownames(MRP$Matrix_1$Matrix), split = "_"), length)) > 3)){ cbind(unlist(lapply(apply(metatree::PaleobiologyDBTaxaQuerier("1", unlist(lapply(strsplit(rownames(MRP$Matrix_1$Matrix)[unlist(lapply(strsplit(rownames(MRP$Matrix_1$Matrix), split = "_"), length)) > 2], split = "_"), function(x) x[1]))), 1, as.list), function(x) {x <- unlist(x)[1:2]; unname(gsub("txn:|var:", "", x[!is.na(x)][1]))})), rownames(MRP$Matrix_1$Matrix)[unlist(lapply(strsplit(rownames(MRP$Matrix_1$Matrix), split = "_"), length)) > 2]) } else {matrix(nrow = 0, ncol = 2)})

# Read in constraint XML:
XML <- ReadMetatreeXML("~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/XML/Constraint_2020a.xml")

# Update constraint XML taxon count:
XML$SourceTree$Taxa$TagSupplement[, "Value"] <- as.character(nrow(MRP$Matrix_1$Matrix))

# Update constraint XML (MRP) character count:
XML$SourceTree$Characters$Other$TagSupplement[, "Value"] <- as.character(ncol(MRP$Matrix_1$Matrix))

# Update taxonomic reconciliation for constraint tree:
XML$SourceTree$Taxa$TagContents <- matrix(unname(matrix(c(c("DELETE", ReconciledNames[, 2]), c("0", ReconciledNames[, 1]), c("allzero", ReconciledNames[, 2])), ncol = 3, dimnames = list(c("allzero", ReconciledNames[, 2]), c("recon_name", "recon_no", "ListValue")))[rownames(MRP$Matrix_1$Matrix), ]), ncol = 3, dimnames = list(c(), c("recon_name", "recon_no", "ListValue")))

# Write XML to file:
WriteMetatreeXML(XML, "~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/XML/Constraint_2020a.xml")

# Add constraint to inclusive data list:
InclusiveDataList <- c(InclusiveDataList, "Constraint_2020a")

# Build updated synpasida metatree with constraint included:
Synapsida <- metatree::Metatree(MRPDirectory = MRPDirectory, XMLDirectory = XMLDirectory, TargetClade = TargetClade, InclusiveDataList = InclusiveDataList, ExclusiveDataList = ExclusiveDataList, MissingSpecies = MissingSpecies, SpeciesToExclude = SpeciesToExclude, RelativeWeights = RelativeWeights, WeightCombination = WeightCombination, ReportContradictionsToScreen = ReportContradictionsToScreen, BackboneConstraint = "Constraint_2020a")

# Build constraint tree (for basic checks ahead of building constraint trees):
pdf("~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/Metatree/ConstraintTree.pdf", width = 30, height = 50)
plot(ConstraintTree, cex = 0.3)
#nodelabels(ConstraintTree$node.label, cex = 0.5)
dev.off()

# Build taxonomy tree (for basic checks ahead of building constraint trees):
pdf("~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/Metatree/TaxonomyTree.pdf", width = 30, height = 50)
plot(Synapsida$TaxonomyTree, cex = 0.3)
nodelabels(Synapsida$TaxonomyTree$node.label, cex = 0.5)
dev.off()

# Write out metatree files:
WriteMorphNexus(Synapsida$FullMRPMatrix, paste(MetatreeDirectory, "/SynapsidaFULL.nex", sep = ""))
WriteMorphNexus(Synapsida$STRMRPMatrix, paste(MetatreeDirectory, "/SynapsidaSTR.nex", sep = ""))
WriteMorphTNT(Synapsida$FullMRPMatrix, paste(MetatreeDirectory, "/SynapsidaFULL.tnt", sep = ""))
WriteMorphTNT(Synapsida$STRMRPMatrix, paste(MetatreeDirectory, "/SynapsidaSTR.tnt", sep = ""))
write.table(Synapsida$SafelyRemovedTaxa, "~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/Metatree/STR.txt", row.names = FALSE)

# Add analysis block to STR TNT:
STRTNT <- readLines(paste(MetatreeDirectory, "/SynapsidaSTR.tnt", sep = ""))
STRTNT <- gsub("proc/;", "rseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nhold 1000;\nshortread scratch3.tre;\nbbreak=tbr;\nexport -AllSTRMPTs.nex;\nproc/;", STRTNT)
write(STRTNT, paste(MetatreeDirectory, "/SynapsidaSTR.tnt", sep = ""))

