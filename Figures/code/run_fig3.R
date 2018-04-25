## set working directory
setwd('~/Box Sync/Vector-borne disease/code')

## clear existing workspace
rm(list=ls())

## load appropriate packages
if(!require(plotrix)){install.packages('plotrix'); library(plotrix)}
if(!require(RColorBrewer)){install.packages('RColorBrewer'); library(RColorBrewer)}

## declare and initialize necessary variables
temperature.range.10.40 = seq(from = 10, to = 40, by = 0.1)
epidemic.Indices.10.40 = matrix(rep(0, length(temperature.range.10.40)), nrow = length(temperature.range.10.40),ncol = 4)
header = 'output_'
extension = '.txt'

## create progress bar
pb <- txtProgressBar(min = 0, max = length(temperature.range.10.40), style = 3)

## extract data
for(ii in 1:length(temperature.range.10.40)){
  filename = paste(header, temperature.range.10.40[ii], extension, sep = '')
  output = read.csv(paste('~/Box Sync/Vector-borne disease/data/StartTemp/range1040_new//', filename, sep=''), header=FALSE, sep=";")
  epidemic.Indices.10.40[ii,1] = temperature.range.10.40[ii]
  epidemic.Indices.10.40[ii,2] = max(output[,5])
  epidemic.Indices.10.40[ii,3] = max(output[,4])
  if(length(tail(which(output[,4] > 1), n = 1)) > 0){
    epidemic.Indices.10.40[ii,4] = output[tail(which(output[,4] > 1), n = 1), 1]
  }
  else{
    epidemic.Indices.10.40[ii,4] = 0
  }
  
  setTxtProgressBar(pb, ii)
}

## express max number of infected individuals and final epidemic size as a proportion
epidemic.Indices.10.40[,2] = epidemic.Indices.10.40[,2]/10000
epidemic.Indices.10.40[,3] = epidemic.Indices.10.40[,3]/10000

## declare and initalize necessary variables
temperature.range.20.30 = seq(from = 20, to = 30, by = 0.1)
epidemic.Indices.20.30= matrix(rep(0, length(temperature.range.20.30)), nrow = length(temperature.range.20.30),ncol = 4)

## extract data
pb <- txtProgressBar(min = 0, max = length(temperature.range.20.30), style = 3)
for(ii in 1:length(temperature.range.20.30)){
  filename = paste(header, temperature.range.20.30[ii], extension, sep = '')
  output = read.csv(paste('~/Box Sync/Vector-borne disease/data/StartTemp/range2030_new/', filename, sep=''), header=FALSE, sep=";")
  epidemic.Indices.20.30[ii,1] = temperature.range.20.30[ii]
  epidemic.Indices.20.30[ii,2] = max(output[,5])
  epidemic.Indices.20.30[ii,3] = max(output[,4])
  if(length(tail(which(output[,4] > 1), n = 1)) > 0){
    epidemic.Indices.20.30[ii,4] = output[tail(which(output[,4] > 1), n = 1), 1]
  }
  else{
    epidemic.Indices.20.30[ii,4] = 0
  }
  
  setTxtProgressBar(pb, ii)
}

## express max number of infected individuals and final epidemic size as a proportion
epidemic.Indices.20.30[,2] = epidemic.Indices.20.30[,2]/10000
epidemic.Indices.20.30[,3] = epidemic.Indices.20.30[,3]/10000

## calculate temperatures for max values
temperature.range.10.40[which(epidemic.Indices.10.40[,2]==max(epidemic.Indices.10.40[,2]))]
temperature.range.10.40[which(epidemic.Indices.10.40[,3]==max(epidemic.Indices.10.40[,3]))] 
temperature.range.10.40[which(epidemic.Indices.10.40[,4]==max(epidemic.Indices.10.40[,4]))] 

temperature.range.20.30[which(epidemic.Indices.20.30[,2]==max(epidemic.Indices.20.30[,2]))]
temperature.range.20.30[which(epidemic.Indices.20.30[,3]==max(epidemic.Indices.20.30[,3]))]
temperature.range.20.30[which(epidemic.Indices.20.30[,4]==max(epidemic.Indices.20.30[,4]))]

## save output
save(epidemic.Indices.10.40, epidemic.Indices.20.30, file = '~/Box Sync/Vector-borne disease/data/epidemicIndices.RData')
