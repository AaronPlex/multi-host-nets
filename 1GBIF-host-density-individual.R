
library(terra)
library(viridis)
vir.pal<-viridis(n=100, option = "viridis")

hostOccGBIF<-read.csv("Xanthosoma.csv", header = TRUE, sep = "\t") #This is the csv file downloaded manually from GBIF.
unique(hostOccGBIF$species)
length(hostOccGBIF$species)

# Cleaning dataset
hostOccGBIF<-hostOccGBIF[hostOccGBIF$countryCode != "",]
hostOccGBIF<-hostOccGBIF[hostOccGBIF$countryCode != "ZZ",]
hostOccGBIF<-hostOccGBIF[hostOccGBIF$occurrenceStatus == "PRESENT",]
hostOccGBIF<-hostOccGBIF[hostOccGBIF$year >= 1944,]
hostOccGBIF$Lon <- as.numeric(hostOccGBIF$decimalLongitude)
hostOccGBIF$Lat <- as.numeric(hostOccGBIF$decimalLatitude)
hostOccGBIF<-hostOccGBIF[hostOccGBIF$decimalLatitude != hostOccGBIF$decimalLongitude,]
hostOccGBIF<-hostOccGBIF[hostOccGBIF$decimalLatitude != 0 & hostOccGBIF$decimalLongitude != 0,]
hostOccGBIF<-hostOccGBIF[,colnames(hostOccGBIF) %in% 
                           c("species", "Lon", "Lat")]
hostOccGBIF<-hostOccGBIF[is.na(hostOccGBIF$Lon)==FALSE, ]
hostOccGBIF<-hostOccGBIF[is.na(hostOccGBIF$Lat)==FALSE, ]
length(hostOccGBIF$species)

# Generating a spatRaster
g.ext <- ext(-180, 180, -60, 90) #left, right, bottom, top
empty.rast <- rast(res=1/48, ext=g.ext) #an empty raster

vectorHost<-vect(hostOccGBIF, 
                 crs="+proj=longlat", geom=c("Lon","Lat"))
vectorHost<-crop(vectorHost, g.ext)
rasterHost<-rasterize(vectorHost, empty.rast, fun=length)
rasterHost<-sqrt(rasterHost)
plot(rasterHost)
rasterHost
#to convert into host density maps
f<-24
##rasterHost <- focal(rasterHost, 3, mean, na.policy="all", na.rm=TRUE) #This step is optional.
values(rasterHost)<-ifelse(values(rasterHost)>=10, 10, values(rasterHost))
ag.rast<-aggregate(rasterHost, fact = f, fun = sum, na.rm=TRUE)/(4*f^2)
plot(ag.rast, col = vir.pal)

writeRaster(ag.rast, "Xanthosoma sp.tif", overwrite = TRUE)
