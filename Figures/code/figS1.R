## set working directory
setwd('~/Box Sync/Vector-borne disease/code')

## clear existing workspace
rm(list=ls())

## load appropriate packages
if(!require(plotrix)){install.packages('plotrix'); library(plotrix)}
if(!require(RColorBrewer)){install.packages('RColorBrewer'); library(RColorBrewer)}

## declare and initialize necessary variables
N = 10000
temperature.range.10.40 = seq(from = 10, to = 40, by = 0.1)
epidemic.Indices.10.40 = array(dim = c(length(temperature.range.10.40), 3, 50))
header = 'file_'
extension = '.txt'

## extract data
for(ii in 0:49){
  filename = paste(header, ii, extension, sep = '')
  output = matrix(unlist(read.table(paste('~/Box Sync/Vector-borne disease/data/StartTemp/range1040_new/uncertainty/', filename, sep=''))), nrow = length(temperature.range.10.40))
  output[,1:2] = output[,1:2] / N
  epidemic.Indices.10.40[,,ii+1] = output
}

min.quantile.10.40 = apply(epidemic.Indices.10.40, c(1,2), quantile, 0.025)
median.quantile.10.40 = apply(epidemic.Indices.10.40, c(1,2), quantile, 0.50)
max.quantile.10.40 = apply(epidemic.Indices.10.40, c(1,2), quantile, 0.975)

# repeat for 20-30 regime
temperature.range.20.30 = seq(from = 20, to = 30, by = 0.1)
epidemic.Indices.20.30 = array(dim = c(length(temperature.range.20.30), 3, 50))
header = 'file_'
extension = '.txt'

## extract data
for(ii in 0:49){
  filename = paste(header, ii, extension, sep = '')
  output = matrix(unlist(read.table(paste('~/Box Sync/Vector-borne disease/data/StartTemp/range2030_new/uncertainty/', filename, sep=''))), nrow = length(temperature.range.20.30))
  output[,1:2] = output[,1:2] / N
  epidemic.Indices.20.30[,,ii+1] = output
}

min.quantile.20.30 = apply(epidemic.Indices.20.30, c(1,2), quantile, 0.025)
median.quantile.20.30 = apply(epidemic.Indices.20.30, c(1,2), quantile, 0.50)
max.quantile.20.30 = apply(epidemic.Indices.20.30, c(1,2), quantile, 0.975)


tiff(filename='~/Box Sync/Vector-borne disease/output/S1 Fig.tiff', width = 16.5, height = 12.7, units = 'cm', res = 600, compression = 'lzw')
par(oma=c(0, 5, 0, 0), mar = c(3.1,4.1,1.1,1.1), mfrow = c(2,1))

plot(temperature.range.10.40, median.quantile.10.40[,2], type='n', lty=1, col='red', bty='n', lwd=2, xlab='', ylab='',
     ylim=c(min(min.quantile.10.40[,2]), max(max.quantile.10.40[,2])), axes=F,cex=0.8)
polygon(c(temperature.range.10.40, rev(temperature.range.10.40)), c(max.quantile.10.40[,2], rev(min.quantile.10.40[,2])), col = rgb(1,0,0,0.25), border = NA)
lines(temperature.range.10.40, median.quantile.10.40[,2], lty = 1, col = 'red', lwd = 2)
axis(side=1, yaxs='i', xaxs='i', cex.axis=0.7)
mtext("Starting Temperature (°C)",1,cex=0.8,line=2)
axis(side=2, line=0, yaxs='i', xaxs='i', las =1, tcl=-.25, mgp=c(.5,.5,0),cex.axis=.7,col='red', col.axis='red')
mtext("Maximum Number of Infections",2,col='red',cex=.8,line=1.75)


par(new=T)
plot(temperature.range.10.40, median.quantile.10.40[,1], type='n', lty=1, lwd=2, col='blue', axes=F, xlab='', ylab='',
     ylim=c(min(min.quantile.10.40[,1]), max(max.quantile.10.40[,1])))
polygon(c(temperature.range.10.40, rev(temperature.range.10.40)), c(max.quantile.10.40[,1], rev(min.quantile.10.40[,1])), col = rgb(0,0,1,0.25), border = NA)
lines(temperature.range.10.40, median.quantile.10.40[,1], lty = 1, col = 'blue', lwd = 2)
axis(2, col='blue',  col.axis='blue', las=1,line=3.25, tcl=-.25, mgp=c(.5,.5,0),cex.axis=.7)
mtext('Final Epidemic Size',2,col='blue',cex=.8,line=5.0)

par(new=T)
plot(temperature.range.10.40, median.quantile.10.40[,3], type='n', lty=1, lwd=2, col='dark green', axes=F, xlab='', ylab='',
     ylim=c(min(min.quantile.10.40[,3]), max(max.quantile.10.40[,3])))
polygon(c(temperature.range.10.40, rev(temperature.range.10.40)), c(max.quantile.10.40[,3], rev(min.quantile.10.40[,3])), col = rgb(0,1,0,0.25), border = NA)
lines(temperature.range.10.40, median.quantile.10.40[,3], lty = 1, col = 'dark green', lwd = 2)
axis(2, las=1, col.axis='dark green', col='dark green', line=6.5, tcl=-.25, mgp=c(.5,.5,0),cex.axis=.7)
mtext('Epidemic Length (Days)',2,col='dark green',cex=.8,line=8.25)
mtext('A', side = 3, at = 10)


plot(temperature.range.20.30, median.quantile.20.30[,2], type='n', lty=1, col='red', bty='n', lwd=2, xlab='', ylab='',
     ylim=c(0, max(max.quantile.20.30[,2])), axes=F,cex=0.8)
polygon(c(temperature.range.20.30, rev(temperature.range.20.30)), c(max.quantile.20.30[,2], rev(min.quantile.20.30[,2])), col = rgb(1,0,0,0.25), border = NA)
lines(temperature.range.20.30, median.quantile.20.30[,2], lty = 1, col = 'red', lwd = 2)
axis(side=1, yaxs='i', xaxs='i', cex.axis=0.7)
mtext("Starting Temperature (°C)",1,cex=0.8,line=2)
axis(side=2, line=0, yaxs='i', xaxs='i', las =1, tcl=-.25, mgp=c(.5,.5,0),cex.axis=.7,col='red', col.axis='red')
mtext("Maximum Number of Infections",2,col='red',cex=.8,line=1.75)


par(new=T)
plot(temperature.range.20.30, median.quantile.20.30[,1], type='n', lty=1, lwd=2, col='blue', axes=F, xlab='', ylab='',
     ylim=c(0, max(max.quantile.20.30[,1])))
polygon(c(temperature.range.20.30, rev(temperature.range.20.30)), c(max.quantile.20.30[,1], rev(min.quantile.20.30[,1])), col = rgb(0,0,1,0.25), border = NA)
lines(temperature.range.20.30, median.quantile.20.30[,1], lty = 1, col = 'blue', lwd = 2)
axis(2, col='blue',  col.axis='blue', las=1,line=3.25, tcl=-.25, mgp=c(.5,.5,0),cex.axis=.7)
mtext('Final Epidemic Size',2,col='blue',cex=.8,line=5.0)

par(new=T)
plot(temperature.range.20.30, median.quantile.20.30[,3], type='n', lty=1, lwd=2, col='dark green', axes=F, xlab='', ylab='',
     ylim=c(0, max(max.quantile.20.30[,3])))
polygon(c(temperature.range.20.30, rev(temperature.range.20.30)), c(max.quantile.20.30[,3], rev(min.quantile.20.30[,3])), col = rgb(0,1,0,0.25), border = NA)
lines(temperature.range.20.30, median.quantile.20.30[,3], lty = 1, col = 'dark green', lwd = 2)
axis(2, las=1, col.axis='dark green', col='dark green', line=6.5, tcl=-.25, mgp=c(.5,.5,0),cex.axis=.7)
mtext('Epidemic Length (Days)',2,col='dark green',cex=.8,line=8.25)
mtext('B', side = 3, at = 20)
dev.off()

