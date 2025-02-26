
library(terra)
# List of non-cultivated host species as named in the raster files
wild.PSTVd<-c("Argyranthemum frutescens", "Atriplex semilunaris",    
              "Brugmansia ×candida",      "Brugmansia sanguinea",    
              "Brugmansia suaveolens",    "Calibrachoa sp",         
              "Cestrum aurantiacum",      "Cestrum elegans",          
              "Cestrum endlicheri",       "Cestrum nocturnum",        
              "Erigeron bonariensis",     "Dahlia sp",               
              "Datura leichhardtii",      "Diascia sp",              
              "Nicandra physalodes",      "Petunia ×atkinsiana",               
              "Physalis angulata",        "Physalis peruviana",      
              "Chenopodium eremaeum",     "Solanum anguivi",          
              "Solanum betaceum",         "Solanum chacoense",       
              "Solanum coagulans",        "Solanum commersonii",     
              "Solanum dasyphyllum",      "Solanum brevicaule",        
              "Solanum laxum",            "Solanum microdontum",     
              "Solanum multiinterruptum", "Solanum muricatum",       
              "Solanum nigrum",           "Solanum stoloniferum",          
              "Solanum phureja",          "Lycianthes rantonnetii",
              "Solanum verrucosum",       "Streptoglossa sp",       
              "Streptosolen jamesonii")
wild.RSIIB <- c("Anthurium andraeanum",           "Arachis hypogaea",             
                "Capsicum pubescens",            "Casuarina equisetifolia",
                "Cissus verticillata subsp. verticillata",              
                "Arivela viscosa",               "Desmodium incanum",            
                "Emilia sonchifolia",            "Euphorbia hirta",
                "Epipremnum aureum",             "Eucalyptus pellita",
                "Heliconia caribaea",            "Heliconia rostrata",           
                "Hydrangea sp",                 "Solanum pimpinellifolium", 
                "Hydrocotyle ranunculoides",     "Impatiens balsamina",          
                "Impatiens hawkeri",             "Ipomoea trifida",
                "Oxalis latifolia",              "Pandanus sp",                 
                "Pelargonium ×asperum",          "Pelargonium capitatum",        
                "Pelargonium ×hortorum",         "Polygonum pensylvanicum",             
                "Pelargonium zonale",            "Peperomia pellucida",          
                "Piper dilatatum",               "Piper hispidinervum",
                "Portulaca oleracea",            "Solanum americanum",           
                "Solanum dulcamara",             "Solanum nigrum",               
                "Callisia serrulata", "Urtica dioica",  "Xanthosoma sp")
wild.ToBRFV <- c("Amaranthus retroflexus", "Capsicum chinense",      
            "Chenopodiastrum murale", "Convolvulus arvensis",   
            "Erigeron canadensis", "Corchorus olitorius",    
            "Malva parviflora", "Oxalis corniculata",     
            "Polycarpon tetraphyllum", "Portulaca oleracea",     
            "Solanum elaeagnifolium", "Solanum nigrum", 
            "Taraxacum officinale", "Veronica syriaca")
wild.Tuta<-c("Amaranthus spinosus", "Amaranthus viridis",
             "Chenopodium album", "Blitum bonus-henricus",
             "Chenopodiastrum murale", "Chenopodium rubrum",        
             "Convolvulus arvensis",      
             "Datura stramonium", "Jatropha curcas",           
             "Nicotiana tabacum", "Alkekengi officinarum",        
             "Physalis angulata", "Physalis peruviana",        
             "Solanum aculeatissimum", "Solanum aethiopicum",       
             "Solanum americanum", "Solanum betaceum",          
             "Solanum coccineum",         
             "Solanum elaeagnifolium", "Solanum incanum",           
             "Solanum lichtensteinii",  "Solanum muricatum",         
             "Solanum nigrum", "Solanum saponaceum",        
             "Solanum supinum",         
             "Solanum umbellatum", "Solanum villosum",         
             "Vicia faba",  "Xanthium strumarium")

# Loading raster files for each host species
main.raster<-rast(paste0(wild.RSIIB[1],".tif"))
names(main.raster)<-wild.RSIIB[1]

for (i in 1:length(wild.RSIIB)) {
  second.raster<-rast(paste0(wild.RSIIB[i],".tif"))
  names(second.raster)<-wild.RSIIB[i]
  main.raster<-list(main.raster, second.raster)
  main.raster<-rast(main.raster)
}

# List of cultivated host species
crop.PSTVD<-c("Capsicum annuum", "Persea americana", "Solanum lycopersicum", "Solanum tuberosum")
crop.RSIIB<-c("Capsicum annuum", "Cucumis melo",  "Cucumis sativus", "Citrullus lanatus",
              "Cucurbita pepo","Musa acuminata",  "Musa paradisiaca", "Musa sp.",
              "Solanum lycopersicum", "Solanum melongena", "Solanum tuberosum")
crop.ToBRFV<-c("Beta vulgaris","Capsicum annuum","Solanum lycopersicum")
crop.Tuta<-c("Beta vulgaris", "Brassica rapa", "Capsicum annuum", "Citrullus lanatus", 
             "Medicago sativa", "Phaseolus vulgaris", "Solanum lycopersicum", 
             "Solanum melongena", "Solanum tuberosum", "Spinacia oleracea")

# The raster files below need to be downloaded from CROPGRIDS (https://figshare.com/articles/dataset/CROPGRIDS/22491997) and saved on your local directory 
alfalfa<-rast("C:/Users/CROPGRIDSv1.08_alfalfa.nc")
alfalfa<-alfalfa$harvarea
names(alfalfa)<-"Medicago sativa"

avocado<-rast("C:/Users/CROPGRIDSv1.08_avocado.nc")
avocado<-avocado$harvarea
names(avocado)<-"Persea americana"

banana<-rast("C:/Users/CROPGRIDSv1.08_banana.nc")
banana<-banana$harvarea
names(banana)<-"Musa sapientum"

bean<-rast("C:/Users/CROPGRIDSv1.08_bean.nc")
bean<-bean$harvarea
names(bean)<-"Phaseolus vulgaris"

beets<-rast("C:/Users/CROPGRIDSv1.08_beetfor.nc")
beets<-beets$harvarea
names(beets)<-"Beta vulgaris"

cucumber<-rast("C:/Users/CROPGRIDSv1.08_cucumberetc.nc")
cucumber<-cucumber$harvarea
names(cucumber)<-"Cucumis sativus"

eggplant<-rast("C:/Users/CROPGRIDSv1.08_eggplant.nc")
eggplant<-eggplant$harvarea
names(eggplant)<-"Solanum melongena"

melon<-rast("C:/Users/CROPGRIDSv1.08_melonetc.nc")
melon<-melon$harvarea
names(melon)<-"Cucumis melo"

mustard<-rast("C:/Users/CROPGRIDSv1.08_mustard.nc")
mustard<-mustard$harvarea
names(mustard)<-"Brassica rapa"

peppers<-rast("C:/Users/CROPGRIDSv1.08_pepper.nc")
peppers<-peppers$harvarea
names(peppers)<-"Capsicum annuum"

plantain<-rast("C:/Users/CROPGRIDSv1.08_plantain.nc")
plantain<-plantain$harvarea
names(plantain)<-"Musa paradisiaca"

potato<-rast("C:/Users/CROPGRIDSv1.08_potato.nc")
potato<-potato$harvarea
names(potato)<-"Solanum tuberosum"

pumpkin<-rast("C:/Users/CROPGRIDSv1.08_pumpkinetc.nc")
pumpkin<-pumpkin$harvarea
names(pumpkin)<-"Cucurbita pepo"

spinach<-rast("C:/Users/CROPGRIDSv1.08_spinach.nc")
spinach<-spinach$harvarea
names(spinach)<-"Spinacia oleracea"

tomato<-rast("C:/Users/CROPGRIDSv1.08_tomato.nc")
tomato<-tomato$harvarea
names(tomato)<-"Solanum lycopersicum"

watermelon<-rast("C:/Users/CROPGRIDSv1.08_watermelon.nc")
watermelon<-watermelon$harvarea
names(watermelon)<-"Citrullus lanatus"

#crop.rast<-list(alfalfa, bean, beets, eggplant, mustard, peppers, potato, 
#                spinach, tomato, watermelon) # List of cultivated species for Tuta absoluta
#crop.rast<-list(avocado, peppers, potato, tomato) # List of cultivated species for PSTVd
crop.rast<-list(banana,cucumber,eggplant,melon,peppers,plantain,
                potato,pumpkin,tomato,watermelon) # List of cultivated species for RSIIB-1

crop.rast<-rast(crop.rast)
values(crop.rast)<-ifelse(values(crop.rast)>3, 
                          values(crop.rast), NaN)
ha.fact<-10000 / 5500 / 5500 #factor to convert hectares to host density
crop.rast<-crop.rast * ha.fact
plot(crop.rast)

shared.res<-res(main.raster[[1]])/res(crop.rast)
crop.rast<-aggregate(crop.rast, fact = 10, 
                     fun = mean, na.rm=TRUE)

small.ext<-ext(main.raster[[1]])
crop.rast<-crop(crop.rast, small.ext)

nlyr(main.raster)
names(main.raster)
second.raster<-list(main.raster[[2:37]], crop.rast)
second.raster<-rast(second.raster)
layer.names<-names(second.raster)

# Below is a list of major host species for the target pest
major.RSIIB1<-c("Solanum tuberosum","Solanum lycopersicum","Solanum dulcamara") #maybe also geranium for RSIIB-1

# The code below multiply by 10% if the species are only a minor host
for (i in 1:nlyr(second.raster)) {
  if (!layer.names[i] %in% major.RSIIB1) {
    second.raster[[i]] <- second.raster[[i]] * 0.1
  }
}

names(second.raster)

# Generating rasters for cummulative host density and richness
cum.density<-sum(second.raster, na.rm = TRUE)
alt.density<-sum(second.raster[[c(1:31,33:42,44,46)]], na.rm = TRUE)
wild.density<-sum(second.raster[[1:36]], na.rm = TRUE)
par(mfrow=c(2,2))
plot(cum.density, main="Cumulative host density")
plot(second.raster$`Solanum tuberosum`, main="Only potato")
plot(alt.density, main="Alternative hosts")
plot(alt.density, main="Wild alternative hosts")

count.species <- function(x) {
  return(sum(!is.na(x)))  
}
host.richness<-app(second.raster, count.species)
values(host.richness)<-ifelse(values(host.richness)>0,
                              values(host.richness), NaN)

host.rast<-list(cum.density, alt.density, wild.density,
                second.raster$`Solanum tuberosum`,host.richness)
host.rast<-rast(host.rast)
names(host.rast)<-c("Total density","Alternative host density",
                    "Wild host density", "Potato density","Host richness")
plot(host.rast)
writeRaster(host.rast, "RSIIB-hosts.tif", overwrite=TRUE)
