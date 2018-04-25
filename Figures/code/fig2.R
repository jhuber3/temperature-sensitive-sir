############################################################################################################ 
##     AUTHOR: John Huber                                                                                 ## 
##     DATE: June 2016                                                                                    ##
##     DESCRIPTION: This is a figure illustrating the four human compartments for Ae. aegypti,            ##
##     Ae. albopictus, and Ae. spp. averages across three temperatures: 20°C, 25°C, and 30°C              ##
############################################################################################################

## set working directory
setwd('~/Box Sync/Vector-borne disease/code')

## clear existing workspace
rm(list=ls())

## load appropriate packages
if(!require(ggplot2)){install.packages('ggplot2'); library(ggplot2)}
if(!require(plotrix)){install.packages('plotrix'); library(plotrix)}
if(!require(rgl)){install.packages('rgl'); library(rgl)}
if(!require(SDMTools)){install.packages('SDMTools'); library(SDMTools)}
if(!require(viridis)){install.packages('viridis'); library(viridis)}

## create appropriate data structures
temp <- seq(from = 10, to = 40, by = 0.1)
times <- seq(from = 0, to = 365, by = 0.01)
times.integer <- seq(from = 0, to = 365, by = 1)
indices.times.integer <- match(times.integer, times)

## load and fill data 
load(file='~/Box Sync/Vector-borne disease/data/modeloutput.RData')
model.output.20 = read.table('~/Box Sync/Vector-borne disease/data/constant temp/output_200.txt')
model.output.25 = read.table('~/Box Sync/Vector-borne disease/data/constant temp/output_250.txt')
model.output.30 = read.table('~/Box Sync/Vector-borne disease/data/constant temp/output_300.txt')
model.output.35 = read.table('~/Box Sync/Vector-borne disease/data/constant temp/output_350.txt')

## plot data
tiff(filename='~/Box Sync/Vector-borne disease/output/Fig2.tiff',width=16.5,height=12.7, units = 'cm', res = 600, compression = 'lzw')
par(mfrow = c(2,2),mar = c(4.1,4.1,2.1,2.1),mai=c(0.7,0.7,0.3,0.3))

plot(times, model.output.20[,5], type = "l", col = 'grey', xlab = "", ylab = "Count",
     xlim=c(0,max(times)),ylim=c(0,10000),xaxs='i',yaxs='i',bty='n',las=1, lty = 1, lwd = 2)
lines(times,model.output.25[,5], col = 'yellow',lty=1, lwd = 2)
lines(times,model.output.30[,5], col = 'orange',lty=1, lwd = 2)
lines(times.integer,model.output.35[indices.times.integer,5], col = 'red', lty=1, lwd = 2)

mtext(expression('S'['H']),side=3,at=0,line=.25,cex=1)

plot(times, model.output.20[,6], type = 'l', col ='grey', xlab = '', ylab = '',
     xlim=c(0,max(times)),ylim=c(0,1600),xaxs='i',yaxs='i',bty='n',las=1,lty=1, lwd = 2)
lines(times, model.output.25[,6], col = 'yellow',lty=1, lwd=2)
lines(times,model.output.30[,6], col = 'orange',lty=1, lwd=2)
lines(times.integer,model.output.35[indices.times.integer,6], col = 'red', lty = 1, lwd = 2)
legend('topright',cex = 0.75,legend = c('20°C','25°C','30°C', '35°C'), bty = 'n', lty = c(1,1,1,1),
       lwd=c(2,2,2,2),col=c('grey','yellow','orange','red'))

mtext(expression('E'['H']),side=3,at=0,line=.25,cex=1)

plot(times, model.output.20[,7], type = 'l', col ='grey', xlab = 'Days', ylab = 'Counts',
     xlim=c(0,max(times)),ylim=c(0,1300),xaxs='i',yaxs='i',bty='n',las=1,lty=1, lwd=2)
lines(times,model.output.25[,7], col = 'yellow',lty=1, lwd=2)
lines(times,model.output.30[,7], col = 'orange',lty=1, lwd=2)
lines(times.integer, model.output.35[indices.times.integer,7], col = 'red', lty = 1, lwd = 2)

mtext(expression('I'['H']),side=3,at=0,line=.25,cex=1)

plot(times, model.output.20[,8], type = 'l', col ='grey', xlab = 'Days', ylab = '',
     xlim=c(0,max(times)),ylim=c(0,1.05* 10000),xaxs='i',yaxs='i',bty='n',las=1,lty=1, lwd=2)
lines(times,model.output.25[,8],col='yellow',lty=1, lwd=2)
lines(times,model.output.30[,8],col='orange',lty=1, lwd=2)
lines(times.integer,model.output.35[indices.times.integer,8], col = 'red', lty = 1, lwd = 2)

mtext(expression('R'['H']),side=3,at=0,line=.25,cex=1)

dev.off()

