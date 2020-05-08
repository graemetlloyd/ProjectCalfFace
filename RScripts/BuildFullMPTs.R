# SCRIPT TO BUILD METATREE FILES

# Load metatree library:
library(Claddis)
library(metatree)

# Reformat  TNT STR Output as proper Newick trees and save:
AllSTRMPTs <- readLines("~/Desktop/Desktop - Spencer???s MacBook Pro (2)/NSF metatree/ProjectCalfFace/TNTTrees/AllSTRMPTs.nex", warn = FALSE)
AllSTRMPTs <- AllSTRMPTs[grep("\\(allzero", AllSTRMPTs)]
write(gsub(" ", "", AllSTRMPTs), "~/Desktop/Desktop - Spencer???s MacBook Pro (2)/NSF metatree/ProjectCalfFace/TNTTrees/AllSTRMPTs.tre")

# Safely reinsert taxa and write out to file:
Claddis::SafeTaxonomicReinsertion(treefile.in = "~/Desktop/Desktop - Spencer???s MacBook Pro (2)/NSF metatree/ProjectCalfFace/TNTTrees/AllSTRMPTs.tre", treefile.out = "~/Desktop/Desktop - Spencer???s MacBook Pro (2)/NSF metatree/ProjectCalfFace/Trees/MPTs.tre", str.list = read.table("~/Desktop/Desktop - Spencer???s MacBook Pro (2)/NSF metatree/ProjectCalfFace/Metatree/STR.txt", header = TRUE, stringsAsFactors = FALSE), multi.placements = "random")

# Get strict consensuss and write to file:
AllMPTs <- ape::read.tree("~/Desktop/Desktop - Spencer???s MacBook Pro (2)/NSF metatree/ProjectCalfFace/Trees/MPTs.tre")
AllSCC <- ape::consensus(AllMPTs)
ape::write.tree(AllSCC, "~/Desktop/Desktop - Spencer???s MacBook Pro (2)/NSF metatree/ProjectCalfFace/Trees/SCC.tre")
