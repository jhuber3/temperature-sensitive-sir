## set working directory
setwd('~/Box Sync/Vector-borne disease/code')

## clear existing workspace
rm(list=ls())

## load data
load(file = '~/Box Sync/Vector-borne disease/data/epidemicIndices.RData')

## plot data
tiff(filename = '~/Box Sync/Vector-borne disease/output/Fig3.tiff', width=16.5, height = 12.7, units = 'cm', res = 600, compression = 'lzw')

par(oma=c(0, 5, 0, 0), mar = c(3.1,4.1,1.1,1.1), mfrow = c(2,1))

plot(epidemic.Indices.10.40[,1], epidemic.Indices.10.40[,3], type='l', lty=1, col='red', bty='n', lwd=2, xlab='', ylab='',
     ylim=c(min(epidemic.Indices.10.40[,3]), max(epidemic.Indices.10.40[,3])), axes=F,cex=0.8)
axis(side=1, yaxs='i', xaxs='i', cex.axis=0.7)
mtext("Starting Temperature (°C)",1,cex=0.8,line=2)
axis(side=2, line=0, yaxs='i', xaxs='i', las =1, tcl=-.25, mgp=c(.5,.5,0),cex.axis=.7,col='red', col.axis='red')
mtext("Maximum Number of Infections",2,col='red',cex=.8,line=1.75)


par(new=T)
plot(epidemic.Indices.10.40[,1], epidemic.Indices.10.40[,2], type='l', lty=1, lwd=2, col='blue', axes=F, xlab='', ylab='',
     ylim=c(min(epidemic.Indices.10.40[,2]), max(epidemic.Indices.10.40[,2])))
axis(2, col='blue',  col.axis='blue', las=1,line=3.25, tcl=-.25, mgp=c(.5,.5,0),cex.axis=.7)
mtext('Final Epidemic Size',2,col='blue',cex=.8,line=5.0)

par(new=T)
plot(epidemic.Indices.10.40[,1], epidemic.Indices.10.40[,4], type='l', lty=1, lwd=2, col='dark green', axes=F, xlab='', ylab='',
     ylim=c(min(epidemic.Indices.10.40[,4]), max(epidemic.Indices.10.40[,4])))
axis(2, las=1, col.axis='dark green', col='dark green', line=6.5, tcl=-.25, mgp=c(.5,.5,0),cex.axis=.7)
mtext('Epidemic Length (Days)',2,col='dark green',cex=.8,line=8.25)
mtext('A', side = 3, at = 10)


plot(epidemic.Indices.20.30[,1], epidemic.Indices.20.30[,3], type='l', lty=1, col='red', bty='n', lwd=2, xlab='', ylab='',
     ylim=c(0, max(epidemic.Indices.20.30[,3])), axes=F,cex=0.8)
axis(side=1, yaxs='i', xaxs='i', cex.axis=0.7)
mtext("Starting Temperature (°C)",1,cex=0.8,line=2)
axis(side=2, line=0, yaxs='i', xaxs='i', las =1, tcl=-.25, mgp=c(.5,.5,0),cex.axis=.7,col='red', col.axis='red')
mtext("Maximum Number of Infections",2,col='red',cex=.8,line=1.75)


par(new=T)
plot(epidemic.Indices.20.30[,1], epidemic.Indices.20.30[,2], type='l', lty=1, lwd=2, col='blue', axes=F, xlab='', ylab='',
     ylim=c(0, max(epidemic.Indices.20.30[,2])))
axis(2, col='blue',  col.axis='blue', las=1,line=3.25, tcl=-.25, mgp=c(.5,.5,0),cex.axis=.7)
mtext('Final Epidemic Size',2,col='blue',cex=.8,line=5.0)

par(new=T)
plot(epidemic.Indices.20.30[,1], epidemic.Indices.20.30[,4], type='l', lty=1, lwd=2, col='dark green', axes=F, xlab='', ylab='',
     ylim=c(0, max(epidemic.Indices.20.30[,4])))
axis(2, las=1, col.axis='dark green', col='dark green', line=6.5, tcl=-.25, mgp=c(.5,.5,0),cex.axis=.7)
mtext('Epidemic Length (Days)',2,col='dark green',cex=.8,line=8.25)
mtext('B', side = 3, at = 20)
dev.off()

