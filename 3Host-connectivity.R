
library(terra)
all.hosts<-rast("Tabsoluta-hosts.tif")
host.density<-all.hosts$`Total density`
host.density<-host.density^(1/2)

library(geohabnet)
global_maxsize <- options("future.globals.maxSize")
options(future.globals.maxSize = 4000 * 1024^2)

west.ext<-c(-180, -25, -60, 90)
east.ext<-c(-25, 180, -60, 90)
global.ext<-c(-180,180,-60,90)

host.net<-msean(host.density,
                  global = FALSE,
                  geoscale = west.ext,
                  agg_methods = c("mean"),
                  dist_method = "geodesic",
                  link_threshold = 0.0001,
                  hd_threshold = 0.02,
                  res = 1,
                  inv_pl = inv_powerlaw(NULL, betas = c(0.9, 1.5, 1.7, 2.1), 
                                        mets = c("betweeness"),we=c(100),linkcutoff = -1),
                  neg_exp = neg_expo(NULL, gammas = c(0.02, 0.08, 0.36, 0.24),
                                     mets = c("betweeness"),we=c(100),linkcutoff = -1))

out.net<-list(host.net@me_rast, host.net@var_rast, host.net@diff_rast)
out.net<-rast(out.net)
names(out.net)<-c("mean.net","var.net","diff.net")
writeRaster(out.net, "Tuta-betweeness-west.tif", overwrite=TRUE)
options(future.globals.maxSize = global_maxsize)

#PSVTd.hdensity<-0.02
#RSIIB.hdensity<-0.02
#ToBRFV.hdensity<-0.02
#Tuta.hdensity<-0.03


#"eigenvector_centrality", "sum_of_nearest_neighbors", "page_rank"
#"node_strength", "betweeness", "closeness"