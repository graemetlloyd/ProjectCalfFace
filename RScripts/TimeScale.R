# SCRIPT TO TIMESCALE TREE

# Load metatree library:
library(paleotree)
library(strap)

# Read trees in from GitHub:
Trees <- ape::read.tree("https://raw.githubusercontent.com/graemetlloyd/ProjectCalfFace/master/Trees/MPTs.tre")

# Read in age data from GitHub:
AgeData <- read.table("https://raw.githubusercontent.com/graemetlloyd/ProjectCalfFace/master/Recovered_Age_Data.csv", sep =",", header = TRUE)

# First reformat step for paleotree:
PaleotreeAgeData <- AgeData[!is.na(AgeData[, "FAD.1"]), c("Taxon", "FAD.1", "LAD.1")]

# Second reformat step for paleotree:
PaleotreeAgeData  <- matrix(c(PaleotreeAgeData[, "FAD.1"], PaleotreeAgeData[, "LAD.1"]), ncol = 2, dimnames = list(PaleotreeAgeData[, "Taxon"], c("FAD", "LAD")))

# TImescale just first tree using equal method:
x <- paleotree::timePaleoPhy(tree = Trees[[1]], timeData = PaleotreeAgeData, type = "equal", vartime = 1)

# Plot tree nicely using geoscalePhylo:
strap::geoscalePhylo(ape::ladderize(x), x.lim = c(325, 66), ages = PaleotreeAgeData[x$tip.label, ])

