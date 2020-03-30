# SCRIPT TO BUILD METATREE FILES

# Load metatree library:
library(Claddis)
library(metatree)

# Reformat  TNT STR Output as proper Newick trees and save:
AllSTRMPTs <- readLines("~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/TNTTrees/AllSTRMPTs.nex", warn = FALSE)
AllSTRMPTs <- AllSTRMPTs[grep("\\(allzero", AllSTRMPTs)]
write(gsub(" ", "", AllSTRMPTs), "~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/TNTTrees/AllSTRMPTs.tre")

# Safely reinsert taxa and write out to file:
Claddis::SafeTaxonomicReinsertion(treefile.in = "~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/TNTTrees/AllSTRMPTs.tre", treefile.out = "~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/Trees/MPTs.tre", str.list = read.table("~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/Metatree/STR.txt", header = TRUE, stringsAsFactors = FALSE), multi.placements = "random")

# Get strict consensuss and write to file:
AllMPTs <- ape::read.tree("~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/Trees/MPTs.tre")
AllSCC <- ape::consensus(AllMPTs)
ape::write.tree(AllSCC, "~/Documents/Publications/in prep/Synapsid metatree - Spencer/ProjectCalfFace/Trees/SCC.tre")
