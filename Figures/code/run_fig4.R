## set working directory
setwd('~/Box Sync/Vector-borne disease/code/')

## clear existing workspace
rm(list=ls())

## declare and initialize necessary variables
oscillation.temp = seq(from = 0.0, to = 40.0, by = 0.1)
amplitude = seq(from = 0.0, to = 20.0, by = 0.1)

header = 'output_'
extension = '.txt'

## create necessary data structure
I.cummulative.zero.meantemp = matrix(nrow = length(oscillation.temp), ncol = length(amplitude))
I.cummulative.zero.mintemp = matrix(nrow = length(oscillation.temp), ncol = length(amplitude))
I.cummulative.zero.maxtemp = matrix(nrow = length(oscillation.temp), ncol = length(amplitude))
I.cummulative.twenty = matrix(nrow = length(oscillation.temp), ncol = length(amplitude))
I.cummulative.forty = matrix(nrow = length(oscillation.temp), ncol = length(amplitude))
I.cummulative.sixty = matrix(nrow = length(oscillation.temp), ncol = length(amplitude))
I.cummulative.eighty = matrix(nrow = length(oscillation.temp), ncol = length(amplitude))

## calculate and store the cummulative number of infections for each temperature regime
pb <- txtProgressBar(min = 0, max = length(oscillation.temp), style = 3)
for(ii in 1:length(oscillation.temp)){
  for(jj in 1:length(amplitude)){
    filename = paste(header, round(oscillation.temp[ii],digits=1), extension, sep='')
    output = (read.table(paste('~/Box Sync/Vector-borne disease/data/amplitude_oscillation/zero/mean_starttemp/', filename, sep=''), quote = "\"", comment.char=""))
    I.cummulative.zero.meantemp[ii, jj] = output[jj, 1]
  }
  setTxtProgressBar(pb, ii)
}

pb <- txtProgressBar(min = 0, max = length(oscillation.temp), style = 3)
for(ii in 1:length(oscillation.temp)){
  for(jj in 1:length(amplitude)){
    filename = paste(header, round(oscillation.temp[ii],digits=1), extension, sep='')
    output = (read.table(paste('~/Box Sync/Vector-borne disease/data/amplitude_oscillation/zero/min_starttemp/', filename, sep=''), quote = "\"", comment.char=""))
    I.cummulative.zero.mintemp[ii, jj] = output[jj, 1]
  }
  setTxtProgressBar(pb, ii)
}

pb <- txtProgressBar(min = 0, max = length(oscillation.temp), style = 3)
for(ii in 1:length(oscillation.temp)){
  for(jj in 1:length(amplitude)){
    filename = paste(header, round(oscillation.temp[ii],digits=1), extension, sep='')
    output = read.table(paste('~/Box Sync/Vector-borne disease/data/amplitude_oscillation/zero/max_starttemp/', filename, sep=''), quote = "\"", comment.char="")
    I.cummulative.zero.maxtemp[ii, jj] = output[jj, 1]
  }
  setTxtProgressBar(pb, ii)
}


pb <- txtProgressBar(min = 0, max = length(oscillation.temp), style = 3)
for(ii in 1:length(oscillation.temp)){
  for(jj in 1:length(amplitude)){
    filename = paste(header, round(oscillation.temp[ii],digits=1), extension, sep='')
    output = read.table(paste('~/Box Sync/Vector-borne disease/data/amplitude_oscillation/twenty/', filename, sep=''), quote = "\"", comment.char="")
    I.cummulative.twenty[ii, jj] = output[jj, 1] - 2000
  }
  setTxtProgressBar(pb, ii)
}

pb <- txtProgressBar(min = 0, max = length(oscillation.temp), style = 3)
for(ii in 1:length(oscillation.temp)){
  for(jj in 1:length(amplitude)){
    filename = paste(header, round(oscillation.temp[ii],digits=1), extension, sep='')
    output = read.table(paste('~/Box Sync/Vector-borne disease/data/amplitude_oscillation/forty/', filename, sep=''), quote = "\"", comment.char="")
    I.cummulative.forty[ii, jj] = output[jj, 1] - 4000
  }
  setTxtProgressBar(pb, ii)
}


pb <- txtProgressBar(min = 0, max = length(oscillation.temp), style = 3)
for(ii in 1:length(oscillation.temp)){
  for(jj in 1:length(amplitude)){
    filename = paste(header, round(oscillation.temp[ii],digits=1), extension, sep='')
    output = read.table(paste('~/Box Sync/Vector-borne disease/data/amplitude_oscillation/sixty/', filename, sep=''), quote = "\"", comment.char="")
    I.cummulative.sixty[ii, jj] = output[jj, 1] - 6000
  }
  setTxtProgressBar(pb, ii)
}

pb <- txtProgressBar(min = 0, max = length(oscillation.temp), style = 3)
for(ii in 1:length(oscillation.temp)){
  for(jj in 1:length(amplitude)){
    filename = paste(header, round(oscillation.temp[ii],digits=1), extension, sep='')
    output = read.table(paste('~/Box Sync/Vector-borne disease/data/amplitude_oscillation/eighty/', filename, sep=''), quote = "\"", comment.char="")
    I.cummulative.eighty[ii, jj] = output[jj, 1] - 8000
  }
  setTxtProgressBar(pb, ii)
}


## handle missing values as the mean of its adjacent values
nan.indices = which(is.na(I.cummulative.zero.mintemp), arr.ind = TRUE)
for(ii in 1:length(nan.indices)){
  row = nan.indices[ii, "row"]
  col = nan.indices[ii, "col"]
  if(oscillation.temp[row] < 10){
    I.cummulative.zero.mintemp[row, col] = 1
  }
}
I.cummulative.zero.mintemp[nan.indices]=1

nan.indices = which(is.na(I.cummulative.twenty), arr.ind = TRUE)
for(ii in 1:length(nan.indices)){
  row = nan.indices[ii, "row"]
  col = nan.indices[ii, "col"]
  if(oscillation.temp[row] < 10){
    I.cummulative.twenty[row, col] = 1
  }
}
I.cummulative.twenty[nan.indices]=1

nan.indices = which(is.na(I.cummulative.forty), arr.ind = TRUE)
for(ii in 1:length(nan.indices)){
  row = nan.indices[ii, "row"]
  col = nan.indices[ii, "col"]
  if(oscillation.temp[row] < 10){
    I.cummulative.forty[row, col] = 1
  }
}
I.cummulative.forty[nan.indices]=1


nan.indices = which(is.na(I.cummulative.sixty), arr.ind = TRUE)
for(ii in 1:length(nan.indices)){
  row = nan.indices[ii, "row"]
  col = nan.indices[ii, "col"]
  if(oscillation.temp[row] < 10){
    I.cummulative.sixty[row, col] = 1
  }
}
I.cummulative.sixty[nan.indices]=1

nan.indices = which(is.na(I.cummulative.eighty), arr.ind = TRUE)
for(ii in 1:length(nan.indices)){
  row = nan.indices[ii, "row"]
  col = nan.indices[ii, "col"]
  if(oscillation.temp[row] < 10){
    I.cummulative.eighty[row, col] = 1
  }
}
I.cummulative.eighty[nan.indices]=1

## save output
save(oscillation.temp, amplitude, I.cummulative.zero.meantemp, I.cummulative.zero.mintemp, I.cummulative.zero.maxtemp, file = '~/Box Sync/Vector-borne disease/data/amplitude_oscilation_zero.RData')
save(oscillation.temp, amplitude, I.cummulative.twenty, file = '~/Box Sync/Vector-borne disease/data/amplitude_oscilation_twenty.RData')
save(oscillation.temp, amplitude, I.cummulative.forty, file = '~/Box Sync/Vector-borne disease/data/amplitude_oscilation_forty.RData')
save(oscillation.temp, amplitude, I.cummulative.sixty, file = '~/Box Sync/Vector-borne disease/data/amplitude_oscilation_sixty.RData')
save(oscillation.temp, amplitude, I.cummulative.eighty, file = '~/Box Sync/Vector-borne disease/data/amplitude_oscilation_eighty.RData')
