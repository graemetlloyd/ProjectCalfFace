#find xml or mrp that's messed up
setwd(XMLDirectory); for(i in list.files()) {cat(i); ReadMetatreeXML(i)}

#find OTU in xml or mrp that's messed up
setwd("~/Desktop/Desktop - Spencer’s MacBook Pro (2)/NSF metatree/ProjectCalfFace")

filename = "Rougier_etal_2012a"
XMLnames <- metatree::ReadMetatreeXML(paste0("XML/", filename, ".xml"))$Source$Taxa$TagContents[, "ListValue"]
MRPnames <- rownames(Claddis::read_nexus_matrix(paste0("MRP/", filename, "mrp.nex"))$matrix_1$matrix)

setdiff(XMLnames, MRPnames)
setdiff(MRPnames, XMLnames)

Muizon_etal_2018a, Rougier_etal_2012a

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

