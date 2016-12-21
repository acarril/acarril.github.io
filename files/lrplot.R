#Create single plot for graph----
power <- seq(0.01,1,0.01)
alpha <- seq(0.01,1,0.01)
pH0 <- 0.5
tp<-((1-pH0)*power)
fp<-((pH0)*alpha)
likelihood_ratio<-outer(tp, fp, "/")

#Create color shading
nrz<-nrow (likelihood_ratio)
ncz<-ncol(likelihood_ratio)
jet.colors<-colorRampPalette(c("green","yellow"))
nbcol<-100
color<-jet.colors(nbcol)
zfacet<-likelihood_ratio[-1, -1]+likelihood_ratio[-1,-ncz]+likelihood_ratio[-nrz,-1]+likelihood_ratio[-nrz,-ncz]
facetcol<-cut(zfacet,nbcol)

#Save plot----
png(file = "lrplot.png", width = 4000, height = 4000, res = 300)
persp(x=power, y=alpha, z=likelihood_ratio, theta = 130, phi = 0, col = color[facetcol], ticktype = "detailed", lwd=0.2)
dev.off()