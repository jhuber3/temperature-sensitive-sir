## set working directory
setwd('~/Box Sync/Vector-borne disease/code')

## clear existing workspace
rm(list=ls())

## load appropriate packages
if(!require(fields)){install.packages('fields'); library(fields)}
if(!require(calibrate)){install.packages('calibrate'); library(calibrate)}

## load appropriate data
load(file = '~/Box Sync/Vector-borne disease/data/amplitude_oscilation_zero.RData')
load(file = '~/Box Sync/Vector-borne disease/data/amplitude_oscilation_twenty.RData')
load(file = '~/Box Sync/Vector-borne disease/data/amplitude_oscilation_forty.RData')
load(file = '~/Box Sync/Vector-borne disease/data/amplitude_oscilation_sixty.RData')
load(file = '~/Box Sync/Vector-borne disease/data/amplitude_oscilation_eighty.RData')
load(file = '~/Box Sync/Vector-borne disease/data/weather.RData')

## scale data
N.Initial = 10000
I.cummulative.zero.meantemp = I.cummulative.zero.meantemp/N.Initial
I.cummulative.zero.mintemp = I.cummulative.zero.mintemp/N.Initial
I.cummulative.zero.maxtemp = I.cummulative.zero.maxtemp/N.Initial
I.cummulative.twenty = I.cummulative.twenty/N.Initial
I.cummulative.forty = I.cummulative.forty/N.Initial
I.cummulative.sixty = I.cummulative.sixty/N.Initial 
I.cummulative.eighty = I.cummulative.eighty/N.Initial 

## select desired indices
oscillation.indices= seq(from = which(oscillation.temp == 10), to = which(oscillation.temp == 38), by = 1)
amplitude.indices = seq(from = 1, to = which(amplitude == 17), by = 1)

## plot data
tiff(filename = '~/Box Sync/Vector-borne disease/output/Fig4.tiff', width = 16.5, height = 12.7, units = 'cm', res = 600, compression = 'lzw')
par(mar = c(4.1,4.1,1.1,2.1))
image.plot(oscillation.temp[oscillation.indices], amplitude[amplitude.indices], I.cummulative.zero.meantemp[oscillation.indices, amplitude.indices],
           xlab = 'Oscillation Mean Temperature (°C)', ylab = 'Amplitude (°C)', legend.lab = 'Epidemic Suitability', zlim = c(0,1.0))

points(mean.SaoPaulo,range.SaoPaulo, pch = 20, col = 'white')
textxy(mean.SaoPaulo - 4.75,range.SaoPaulo, 'Sao Paulo', col = 'white', cex = 0.7)

points(mean.Rio, range.Rio, pch = 20, col = 'white')
textxy(mean.Rio - 0.75, range.Rio, 'Rio de Janeiro', col = 'white', cex = 0.7)

points(mean.Salvador, range.Salvador, pch = 20, col = 'white')
textxy(mean.Salvador-0.75, range.Salvador, 'Salvador', col = 'white', cex = 0.7)

points(mean.Fortaleza, range.Fortaleza, pch = 20, col = 'white')
textxy(mean.Fortaleza - 0.75, range.Fortaleza - 0.1, 'Fortaleza', cex = 0.7, col = 'white')

points(mean.BeloHorizonte, range.BeloHorizonte, pch = 20, col = 'white')
textxy(mean.BeloHorizonte - 0.75, range.BeloHorizonte, 'Belo Horizonte', col = 'white', cex = 0.7)

points(mean.Recife, range.Recife, pch = 20, col = 'white')
lines(c(mean.Recife, 22.5), c(range.Recife, 1), col = 'white')
textxy(22.5 - 2.75, 1 - 0.2, 'Recife', col = 'white', cex = 0.7)

points(mean.Bogota, range.Bogota, pch = 20, col = 'white')
textxy(mean.Bogota-2, range.Bogota+0.1, 'Bogota', col = 'white', cex = 0.7)

points(mean.Medellin, range.Medellin, pch = 20, col = 'white')
textxy(mean.Medellin-2, range.Medellin + 0.1, 'Medellin', col = 'white', cex = 0.7)

points(mean.Cali, range.Cali, pch = 20, col = 'white')
textxy(mean.Cali - 2, range.Cali, 'Cali', col = 'white', cex = 0.7)

points(mean.Barranquilla, range.Barranquilla, pch = 20, col = 'white')
lines(c(mean.Barranquilla, 32), c(range.Barranquilla, 2), col = 'white')
textxy(31,2, 'Barranquilla', col = 'white', cex = 0.7)

points(mean.Cartagena, range.Cartagena, pch = 20, col = 'white')
lines(c(mean.Cartagena, 25), c(range.Cartagena, 0.5), col = 'white')
textxy(20, 0.3, 'Cartagena', col = 'white', cex = 0.7)

points(mean.Tokyo,range.Tokyo, pch = 20, col='white')
textxy(mean.Tokyo - 2.75,range.Tokyo, "Tokyo", col='white', cex = 0.7)

points(mean.Delhi, range.Delhi, pch = 20, col = 'white')
textxy(mean.Delhi - 0.25, range.Delhi, "Delhi", col = 'white', cex = 0.7)

points(mean.Manila, range.Manila, pch = 20, col = 'white')
textxy(mean.Manila - 1.4, range.Manila+0.05, "Manila", col = 'white', cex = 0.7)

points(mean.Shanghai, range.Shanghai, pch = 20, col = 'white')
textxy(mean.Shanghai-0.75, range.Shanghai, "Shanghai", col = 'white', cex = 0.7)

points(mean.Beijing, range.Beijing, pch = 20, col = 'white')
textxy(mean.Beijing, range.Beijing, "Beijing", col = 'white', cex = 0.7)

points(mean.NY, range.NY, pch = 20, col = 'white')
textxy(mean.NY - 0.75, range.NY, "New York", col = 'white', cex = 0.7)

points(mean.Guangzhou, range.Guangzhou, pch = 20, col = 'white')
textxy(mean.Guangzhou - 0.75, range.Guangzhou, "Guangzhou", col = 'white', cex = 0.7)

points(mean.Kobe, range.Kobe, pch = 20, col = 'white')
textxy(mean.Kobe - 0.4, range.Kobe, "Kobe", col = 'white', cex = 0.7)

points(mean.BuenosAires, range.BuenosAires, pch = 20, col = 'white')
textxy(mean.BuenosAires - 0.75, range.BuenosAires, "Buenos Aires", col = 'white', cex = 0.7)

dev.off()

tiff(filename = '~/Box Sync/Vector-borne disease/output/S2 Fig.tiff', width = 16.5, height = 12.7, units = 'cm', res = 600, compression = 'lzw')
par(mar = c(4.1,4.1,1.1,2.1))
image.plot(oscillation.temp[oscillation.indices], amplitude[amplitude.indices], I.cummulative.twenty[oscillation.indices, amplitude.indices],
           xlab = 'Oscillation Mean Temperature (°C)', ylab = 'Amplitude (°C)', legend.lab = 'Epidemic Suitability', zlim = c(0,1.0))
points(mean.SaoPaulo,range.SaoPaulo, pch = 20, col = 'white')
textxy(mean.SaoPaulo - 4.75,range.SaoPaulo, 'Sao Paulo', col = 'white', cex = 0.7)

points(mean.Rio, range.Rio, pch = 20, col = 'white')
textxy(mean.Rio - 0.75, range.Rio, 'Rio de Janeiro', col = 'white', cex = 0.7)

points(mean.Salvador, range.Salvador, pch = 20, col = 'white')
textxy(mean.Salvador-0.75, range.Salvador, 'Salvador', col = 'white', cex = 0.7)

points(mean.Fortaleza, range.Fortaleza, pch = 20, col = 'white')
textxy(mean.Fortaleza - 0.75, range.Fortaleza - 0.1, 'Fortaleza', cex = 0.7, col = 'white')

points(mean.BeloHorizonte, range.BeloHorizonte, pch = 20, col = 'white')
textxy(mean.BeloHorizonte - 0.75, range.BeloHorizonte, 'Belo Horizonte', col = 'white', cex = 0.7)

points(mean.Recife, range.Recife, pch = 20, col = 'white')
lines(c(mean.Recife, 22.5), c(range.Recife, 1), col = 'white')
textxy(22.5 - 2.75, 1 - 0.2, 'Recife', col = 'white', cex = 0.7)

points(mean.Bogota, range.Bogota, pch = 20, col = 'white')
textxy(mean.Bogota-2, range.Bogota+0.1, 'Bogota', col = 'white', cex = 0.7)

points(mean.Medellin, range.Medellin, pch = 20, col = 'white')
textxy(mean.Medellin-2, range.Medellin + 0.1, 'Medellin', col = 'white', cex = 0.7)

points(mean.Cali, range.Cali, pch = 20, col = 'white')
textxy(mean.Cali - 2, range.Cali, 'Cali', col = 'white', cex = 0.7)

points(mean.Barranquilla, range.Barranquilla, pch = 20, col = 'white')
lines(c(mean.Barranquilla, 32), c(range.Barranquilla, 2), col = 'white')
textxy(31,2, 'Barranquilla', col = 'white', cex = 0.7)

points(mean.Cartagena, range.Cartagena, pch = 20, col = 'white')
lines(c(mean.Cartagena, 25), c(range.Cartagena, 0.5), col = 'white')
textxy(20, 0.3, 'Cartagena', col = 'white', cex = 0.7)

points(mean.Tokyo,range.Tokyo, pch = 20, col='white')
textxy(mean.Tokyo - 2.75,range.Tokyo, "Tokyo", col='white', cex = 0.7)

points(mean.Delhi, range.Delhi, pch = 20, col = 'white')
textxy(mean.Delhi - 0.25, range.Delhi, "Delhi", col = 'white', cex = 0.7)

points(mean.Manila, range.Manila, pch = 20, col = 'white')
textxy(mean.Manila - 1.4, range.Manila+0.05, "Manila", col = 'white', cex = 0.7)

points(mean.Shanghai, range.Shanghai, pch = 20, col = 'white')
textxy(mean.Shanghai-0.75, range.Shanghai, "Shanghai", col = 'white', cex = 0.7)

points(mean.Beijing, range.Beijing, pch = 20, col = 'white')
textxy(mean.Beijing, range.Beijing, "Beijing", col = 'white', cex = 0.7)

points(mean.NY, range.NY, pch = 20, col = 'white')
textxy(mean.NY - 0.75, range.NY, "New York", col = 'white', cex = 0.7)

points(mean.Guangzhou, range.Guangzhou, pch = 20, col = 'white')
textxy(mean.Guangzhou - 0.75, range.Guangzhou, "Guangzhou", col = 'white', cex = 0.7)

points(mean.Kobe, range.Kobe, pch = 20, col = 'white')
textxy(mean.Kobe - 0.4, range.Kobe, "Kobe", col = 'white', cex = 0.7)

points(mean.BuenosAires, range.BuenosAires, pch = 20, col = 'white')
textxy(mean.BuenosAires - 0.75, range.BuenosAires, "Buenos Aires", col = 'white', cex = 0.7)
dev.off()

tiff(filename = '~/Box Sync/Vector-borne disease/output/S3 Fig.tiff', width = 16.5, height = 12.7, units = 'cm', res = 600, compression = 'lzw')
par(mar = c(4.1,4.1,1.1,2.1))
image.plot(oscillation.temp[oscillation.indices], amplitude[amplitude.indices], I.cummulative.forty[oscillation.indices, amplitude.indices],
           xlab = 'Oscillation Mean Temperature (°C)', ylab = 'Amplitude (°C)', legend.lab = 'Epidemic Suitability', zlim = c(0,1.0))
points(mean.SaoPaulo,range.SaoPaulo, pch = 20, col = 'white')
textxy(mean.SaoPaulo - 4.75,range.SaoPaulo, 'Sao Paulo', col = 'white', cex = 0.7)

points(mean.Rio, range.Rio, pch = 20, col = 'white')
textxy(mean.Rio - 0.75, range.Rio, 'Rio de Janeiro', col = 'white', cex = 0.7)

points(mean.Salvador, range.Salvador, pch = 20, col = 'white')
textxy(mean.Salvador-0.75, range.Salvador, 'Salvador', col = 'white', cex = 0.7)

points(mean.Fortaleza, range.Fortaleza, pch = 20, col = 'white')
textxy(mean.Fortaleza - 0.75, range.Fortaleza - 0.1, 'Fortaleza', cex = 0.7, col = 'white')

points(mean.BeloHorizonte, range.BeloHorizonte, pch = 20, col = 'white')
textxy(mean.BeloHorizonte - 0.75, range.BeloHorizonte, 'Belo Horizonte', col = 'white', cex = 0.7)

points(mean.Recife, range.Recife, pch = 20, col = 'white')
lines(c(mean.Recife, 22.5), c(range.Recife, 1), col = 'white')
textxy(22.5 - 2.75, 1 - 0.2, 'Recife', col = 'white', cex = 0.7)

points(mean.Bogota, range.Bogota, pch = 20, col = 'white')
textxy(mean.Bogota-2, range.Bogota+0.1, 'Bogota', col = 'white', cex = 0.7)

points(mean.Medellin, range.Medellin, pch = 20, col = 'white')
textxy(mean.Medellin-2, range.Medellin + 0.1, 'Medellin', col = 'white', cex = 0.7)

points(mean.Cali, range.Cali, pch = 20, col = 'white')
textxy(mean.Cali - 2, range.Cali, 'Cali', col = 'white', cex = 0.7)

points(mean.Barranquilla, range.Barranquilla, pch = 20, col = 'white')
lines(c(mean.Barranquilla, 32), c(range.Barranquilla, 2), col = 'white')
textxy(31,2, 'Barranquilla', col = 'white', cex = 0.7)

points(mean.Cartagena, range.Cartagena, pch = 20, col = 'white')
lines(c(mean.Cartagena, 25), c(range.Cartagena, 0.5), col = 'white')
textxy(20, 0.3, 'Cartagena', col = 'white', cex = 0.7)

points(mean.Tokyo,range.Tokyo, pch = 20, col='white')
textxy(mean.Tokyo - 2.75,range.Tokyo, "Tokyo", col='white', cex = 0.7)

points(mean.Delhi, range.Delhi, pch = 20, col = 'white')
textxy(mean.Delhi - 0.25, range.Delhi, "Delhi", col = 'white', cex = 0.7)

points(mean.Manila, range.Manila, pch = 20, col = 'white')
textxy(mean.Manila - 1.4, range.Manila+0.05, "Manila", col = 'white', cex = 0.7)

points(mean.Shanghai, range.Shanghai, pch = 20, col = 'white')
textxy(mean.Shanghai-0.75, range.Shanghai, "Shanghai", col = 'white', cex = 0.7)

points(mean.Beijing, range.Beijing, pch = 20, col = 'white')
textxy(mean.Beijing, range.Beijing, "Beijing", col = 'white', cex = 0.7)

points(mean.NY, range.NY, pch = 20, col = 'white')
textxy(mean.NY - 0.75, range.NY, "New York", col = 'white', cex = 0.7)

points(mean.Guangzhou, range.Guangzhou, pch = 20, col = 'white')
textxy(mean.Guangzhou - 0.75, range.Guangzhou, "Guangzhou", col = 'white', cex = 0.7)

points(mean.Kobe, range.Kobe, pch = 20, col = 'white')
textxy(mean.Kobe - 0.4, range.Kobe, "Kobe", col = 'white', cex = 0.7)

points(mean.BuenosAires, range.BuenosAires, pch = 20, col = 'white')
textxy(mean.BuenosAires - 0.75, range.BuenosAires, "Buenos Aires", col = 'white', cex = 0.7)
dev.off()

tiff(filename = '~/Box Sync/Vector-borne disease/output/S4 Fig.tiff', width = 16.5, height = 12.7, units = 'cm', res = 600, compression = 'lzw')
par(mar=c(4.1,4.1,1.1,2.1))
image.plot(oscillation.temp[oscillation.indices], amplitude[amplitude.indices], I.cummulative.sixty[oscillation.indices, amplitude.indices],
           xlab = 'Oscillation Mean Temperature (°C)', ylab = 'Amplitude (°C)', legend.lab = 'Epidemic Suitability', zlim = c(0,1.0))
points(mean.SaoPaulo,range.SaoPaulo, pch = 20, col = 'white')
textxy(mean.SaoPaulo - 4.75,range.SaoPaulo, 'Sao Paulo', col = 'white', cex = 0.7)

points(mean.Rio, range.Rio, pch = 20, col = 'white')
textxy(mean.Rio - 0.75, range.Rio, 'Rio de Janeiro', col = 'white', cex = 0.7)

points(mean.Salvador, range.Salvador, pch = 20, col = 'white')
textxy(mean.Salvador-0.75, range.Salvador, 'Salvador', col = 'white', cex = 0.7)

points(mean.Fortaleza, range.Fortaleza, pch = 20, col = 'white')
textxy(mean.Fortaleza - 0.75, range.Fortaleza - 0.1, 'Fortaleza', cex = 0.7, col = 'white')

points(mean.BeloHorizonte, range.BeloHorizonte, pch = 20, col = 'white')
textxy(mean.BeloHorizonte - 0.75, range.BeloHorizonte, 'Belo Horizonte', col = 'white', cex = 0.7)

points(mean.Recife, range.Recife, pch = 20, col = 'white')
lines(c(mean.Recife, 22.5), c(range.Recife, 1), col = 'white')
textxy(22.5 - 2.75, 1 - 0.2, 'Recife', col = 'white', cex = 0.7)

points(mean.Bogota, range.Bogota, pch = 20, col = 'white')
textxy(mean.Bogota-2, range.Bogota+0.1, 'Bogota', col = 'white', cex = 0.7)

points(mean.Medellin, range.Medellin, pch = 20, col = 'white')
textxy(mean.Medellin-2, range.Medellin + 0.1, 'Medellin', col = 'white', cex = 0.7)

points(mean.Cali, range.Cali, pch = 20, col = 'white')
textxy(mean.Cali - 2, range.Cali, 'Cali', col = 'white', cex = 0.7)

points(mean.Barranquilla, range.Barranquilla, pch = 20, col = 'white')
lines(c(mean.Barranquilla, 32), c(range.Barranquilla, 2), col = 'white')
textxy(31,2, 'Barranquilla', col = 'white', cex = 0.7)

points(mean.Cartagena, range.Cartagena, pch = 20, col = 'white')
lines(c(mean.Cartagena, 25), c(range.Cartagena, 0.5), col = 'white')
textxy(20, 0.3, 'Cartagena', col = 'white', cex = 0.7)

points(mean.Tokyo,range.Tokyo, pch = 20, col='white')
textxy(mean.Tokyo - 2.75,range.Tokyo, "Tokyo", col='white', cex = 0.7)

points(mean.Delhi, range.Delhi, pch = 20, col = 'white')
textxy(mean.Delhi - 0.25, range.Delhi, "Delhi", col = 'white', cex = 0.7)

points(mean.Manila, range.Manila, pch = 20, col = 'white')
textxy(mean.Manila - 1.4, range.Manila+0.05, "Manila", col = 'white', cex = 0.7)

points(mean.Shanghai, range.Shanghai, pch = 20, col = 'white')
textxy(mean.Shanghai-0.75, range.Shanghai, "Shanghai", col = 'white', cex = 0.7)

points(mean.Beijing, range.Beijing, pch = 20, col = 'white')
textxy(mean.Beijing, range.Beijing, "Beijing", col = 'white', cex = 0.7)

points(mean.NY, range.NY, pch = 20, col = 'white')
textxy(mean.NY - 0.75, range.NY, "New York", col = 'white', cex = 0.7)

points(mean.Guangzhou, range.Guangzhou, pch = 20, col = 'white')
textxy(mean.Guangzhou - 0.75, range.Guangzhou, "Guangzhou", col = 'white', cex = 0.7)

points(mean.Kobe, range.Kobe, pch = 20, col = 'white')
textxy(mean.Kobe - 0.4, range.Kobe, "Kobe", col = 'white', cex = 0.7)

points(mean.BuenosAires, range.BuenosAires, pch = 20, col = 'white')
textxy(mean.BuenosAires - 0.75, range.BuenosAires, "Buenos Aires", col = 'white', cex = 0.7)
dev.off()

tiff(filename = '~/Box Sync/Vector-borne disease/output/S5 Fig.tiff', width = 16.5, height = 12.7, units = 'cm', res = 600)
par(mar = c(4.1,4.1,1.1,2.1))
image.plot(oscillation.temp[oscillation.indices], amplitude[amplitude.indices], I.cummulative.eighty[oscillation.indices, amplitude.indices],
           xlab = 'Oscillation Mean Temperature (°C)', ylab = 'Amplitude (°C)', legend.lab = 'Epidemic Suitability', zlim = c(0,1.0))
points(mean.SaoPaulo,range.SaoPaulo, pch = 20, col = 'white')
textxy(mean.SaoPaulo - 4.75,range.SaoPaulo, 'Sao Paulo', col = 'white', cex = 0.7)

points(mean.Rio, range.Rio, pch = 20, col = 'white')
textxy(mean.Rio - 0.75, range.Rio, 'Rio de Janeiro', col = 'white', cex = 0.7)

points(mean.Salvador, range.Salvador, pch = 20, col = 'white')
textxy(mean.Salvador-0.75, range.Salvador, 'Salvador', col = 'white', cex = 0.7)

points(mean.Fortaleza, range.Fortaleza, pch = 20, col = 'white')
textxy(mean.Fortaleza - 0.75, range.Fortaleza - 0.1, 'Fortaleza', cex = 0.7, col = 'white')

points(mean.BeloHorizonte, range.BeloHorizonte, pch = 20, col = 'white')
textxy(mean.BeloHorizonte - 0.75, range.BeloHorizonte, 'Belo Horizonte', col = 'white', cex = 0.7)

points(mean.Recife, range.Recife, pch = 20, col = 'white')
lines(c(mean.Recife, 22.5), c(range.Recife, 1), col = 'white')
textxy(22.5 - 2.75, 1 - 0.2, 'Recife', col = 'white', cex = 0.7)

points(mean.Bogota, range.Bogota, pch = 20, col = 'white')
textxy(mean.Bogota-2, range.Bogota+0.1, 'Bogota', col = 'white', cex = 0.7)

points(mean.Medellin, range.Medellin, pch = 20, col = 'white')
textxy(mean.Medellin-2, range.Medellin + 0.1, 'Medellin', col = 'white', cex = 0.7)

points(mean.Cali, range.Cali, pch = 20, col = 'white')
textxy(mean.Cali - 2, range.Cali, 'Cali', col = 'white', cex = 0.7)

points(mean.Barranquilla, range.Barranquilla, pch = 20, col = 'white')
lines(c(mean.Barranquilla, 32), c(range.Barranquilla, 2), col = 'white')
textxy(31,2, 'Barranquilla', col = 'white', cex = 0.7)

points(mean.Cartagena, range.Cartagena, pch = 20, col = 'white')
lines(c(mean.Cartagena, 25), c(range.Cartagena, 0.5), col = 'white')
textxy(20, 0.3, 'Cartagena', col = 'white', cex = 0.7)

points(mean.Tokyo,range.Tokyo, pch = 20, col='white')
textxy(mean.Tokyo - 2.75,range.Tokyo, "Tokyo", col='white', cex = 0.7)

points(mean.Delhi, range.Delhi, pch = 20, col = 'white')
textxy(mean.Delhi - 0.25, range.Delhi, "Delhi", col = 'white', cex = 0.7)

points(mean.Manila, range.Manila, pch = 20, col = 'white')
textxy(mean.Manila - 1.4, range.Manila+0.05, "Manila", col = 'white', cex = 0.7)

points(mean.Shanghai, range.Shanghai, pch = 20, col = 'white')
textxy(mean.Shanghai-0.75, range.Shanghai, "Shanghai", col = 'white', cex = 0.7)

points(mean.Beijing, range.Beijing, pch = 20, col = 'white')
textxy(mean.Beijing, range.Beijing, "Beijing", col = 'white', cex = 0.7)

points(mean.NY, range.NY, pch = 20, col = 'white')
textxy(mean.NY - 0.75, range.NY, "New York", col = 'white', cex = 0.7)

points(mean.Guangzhou, range.Guangzhou, pch = 20, col = 'white')
textxy(mean.Guangzhou - 0.75, range.Guangzhou, "Guangzhou", col = 'white', cex = 0.7)

points(mean.Kobe, range.Kobe, pch = 20, col = 'white')
textxy(mean.Kobe - 0.4, range.Kobe, "Kobe", col = 'white', cex = 0.7)

points(mean.BuenosAires, range.BuenosAires, pch = 20, col = 'white')
textxy(mean.BuenosAires - 0.75, range.BuenosAires, "Buenos Aires", col = 'white', cex = 0.7)
dev.off()

tiff(filename = '~/Box Sync/Vector-borne disease/output/S6 Fig.tiff', width = 16.5, height = 12.7, units = 'cm', res = 600, compression = 'lzw')
par(mar = c(4.1, 4.1, 1.1, 2.1))
image.plot(oscillation.temp[oscillation.indices], amplitude[amplitude.indices], I.cummulative.zero.mintemp[oscillation.indices, amplitude.indices],
           xlab = 'Oscillation Mean Temperature (°C)', ylab = 'Amplitude (°C)', legend.lab = 'Epidemic Suitability', zlim = c(0,1.0))
points(mean.SaoPaulo,range.SaoPaulo, pch = 20, col = 'white')
textxy(mean.SaoPaulo - 4.75,range.SaoPaulo, 'Sao Paulo', col = 'white', cex = 0.7)

points(mean.Rio, range.Rio, pch = 20, col = 'white')
textxy(mean.Rio - 0.75, range.Rio, 'Rio de Janeiro', col = 'white', cex = 0.7)

points(mean.Salvador, range.Salvador, pch = 20, col = 'white')
textxy(mean.Salvador-0.75, range.Salvador, 'Salvador', col = 'white', cex = 0.7)

points(mean.Fortaleza, range.Fortaleza, pch = 20, col = 'white')
textxy(mean.Fortaleza - 0.75, range.Fortaleza - 0.1, 'Fortaleza', cex = 0.7, col = 'white')

points(mean.BeloHorizonte, range.BeloHorizonte, pch = 20, col = 'white')
textxy(mean.BeloHorizonte - 0.75, range.BeloHorizonte, 'Belo Horizonte', col = 'white', cex = 0.7)

points(mean.Recife, range.Recife, pch = 20, col = 'white')
lines(c(mean.Recife, 22.5), c(range.Recife, 1), col = 'white')
textxy(22.5 - 2.75, 1 - 0.2, 'Recife', col = 'white', cex = 0.7)

points(mean.Bogota, range.Bogota, pch = 20, col = 'white')
textxy(mean.Bogota-2, range.Bogota+0.1, 'Bogota', col = 'white', cex = 0.7)

points(mean.Medellin, range.Medellin, pch = 20, col = 'white')
textxy(mean.Medellin-2, range.Medellin + 0.1, 'Medellin', col = 'white', cex = 0.7)

points(mean.Cali, range.Cali, pch = 20, col = 'white')
textxy(mean.Cali - 2, range.Cali, 'Cali', col = 'white', cex = 0.7)

points(mean.Barranquilla, range.Barranquilla, pch = 20, col = 'white')
lines(c(mean.Barranquilla, 32), c(range.Barranquilla, 2), col = 'white')
textxy(31,2, 'Barranquilla', col = 'white', cex = 0.7)

points(mean.Cartagena, range.Cartagena, pch = 20, col = 'white')
lines(c(mean.Cartagena, 25), c(range.Cartagena, 0.5), col = 'white')
textxy(20, 0.3, 'Cartagena', col = 'white', cex = 0.7)

points(mean.Tokyo,range.Tokyo, pch = 20, col='white')
textxy(mean.Tokyo - 2.75,range.Tokyo, "Tokyo", col='white', cex = 0.7)

points(mean.Delhi, range.Delhi, pch = 20, col = 'white')
textxy(mean.Delhi - 0.25, range.Delhi, "Delhi", col = 'white', cex = 0.7)

points(mean.Manila, range.Manila, pch = 20, col = 'white')
textxy(mean.Manila - 1.4, range.Manila+0.05, "Manila", col = 'white', cex = 0.7)

points(mean.Shanghai, range.Shanghai, pch = 20, col = 'white')
textxy(mean.Shanghai-0.75, range.Shanghai, "Shanghai", col = 'white', cex = 0.7)

points(mean.Beijing, range.Beijing, pch = 20, col = 'white')
textxy(mean.Beijing, range.Beijing, "Beijing", col = 'white', cex = 0.7)

points(mean.NY, range.NY, pch = 20, col = 'white')
textxy(mean.NY - 0.75, range.NY, "New York", col = 'white', cex = 0.7)

points(mean.Guangzhou, range.Guangzhou, pch = 20, col = 'white')
textxy(mean.Guangzhou - 0.75, range.Guangzhou, "Guangzhou", col = 'white', cex = 0.7)

points(mean.Kobe, range.Kobe, pch = 20, col = 'white')
textxy(mean.Kobe - 0.4, range.Kobe, "Kobe", col = 'white', cex = 0.7)

points(mean.BuenosAires, range.BuenosAires, pch = 20, col = 'white')
textxy(mean.BuenosAires - 0.75, range.BuenosAires, "Buenos Aires", col = 'white', cex = 0.7)
dev.off()

tiff(filename = '~/Box Sync/Vector-borne disease/output/S7 Fig.tiff', width = 16.5, height = 12.7, units = 'cm', res = 600, compression = 'lzw')
par(mar = c(4.1,4.1,1.1,2.1))
image.plot(oscillation.temp[oscillation.indices], amplitude[amplitude.indices], I.cummulative.zero.maxtemp[oscillation.indices, amplitude.indices],
           xlab = 'Oscillation Mean Temperature (°C)', ylab = 'Amplitude (°C)', legend.lab = 'Epidemic Suitability', zlim = c(0,1.0))
points(mean.SaoPaulo,range.SaoPaulo, pch = 20, col = 'white')
textxy(mean.SaoPaulo - 4.75,range.SaoPaulo, 'Sao Paulo', col = 'white', cex = 0.7)

points(mean.Rio, range.Rio, pch = 20, col = 'white')
textxy(mean.Rio - 0.75, range.Rio, 'Rio de Janeiro', col = 'white', cex = 0.7)

points(mean.Salvador, range.Salvador, pch = 20, col = 'white')
textxy(mean.Salvador-0.75, range.Salvador, 'Salvador', col = 'white', cex = 0.7)

points(mean.Fortaleza, range.Fortaleza, pch = 20, col = 'white')
textxy(mean.Fortaleza - 0.75, range.Fortaleza - 0.1, 'Fortaleza', cex = 0.7, col = 'white')

points(mean.BeloHorizonte, range.BeloHorizonte, pch = 20, col = 'white')
textxy(mean.BeloHorizonte - 0.75, range.BeloHorizonte, 'Belo Horizonte', col = 'white', cex = 0.7)

points(mean.Recife, range.Recife, pch = 20, col = 'white')
lines(c(mean.Recife, 22.5), c(range.Recife, 1), col = 'white')
textxy(22.5 - 2.75, 1 - 0.2, 'Recife', col = 'white', cex = 0.7)

points(mean.Bogota, range.Bogota, pch = 20, col = 'white')
textxy(mean.Bogota-2, range.Bogota+0.1, 'Bogota', col = 'white', cex = 0.7)

points(mean.Medellin, range.Medellin, pch = 20, col = 'white')
textxy(mean.Medellin-2, range.Medellin + 0.1, 'Medellin', col = 'white', cex = 0.7)

points(mean.Cali, range.Cali, pch = 20, col = 'white')
textxy(mean.Cali - 2, range.Cali, 'Cali', col = 'white', cex = 0.7)

points(mean.Barranquilla, range.Barranquilla, pch = 20, col = 'white')
lines(c(mean.Barranquilla, 32), c(range.Barranquilla, 2), col = 'white')
textxy(31,2, 'Barranquilla', col = 'white', cex = 0.7)

points(mean.Cartagena, range.Cartagena, pch = 20, col = 'white')
lines(c(mean.Cartagena, 25), c(range.Cartagena, 0.5), col = 'white')
textxy(20, 0.3, 'Cartagena', col = 'white', cex = 0.7)

points(mean.Tokyo,range.Tokyo, pch = 20, col='white')
textxy(mean.Tokyo - 2.75,range.Tokyo, "Tokyo", col='white', cex = 0.7)

points(mean.Delhi, range.Delhi, pch = 20, col = 'white')
textxy(mean.Delhi - 0.25, range.Delhi, "Delhi", col = 'white', cex = 0.7)

points(mean.Manila, range.Manila, pch = 20, col = 'white')
textxy(mean.Manila - 1.4, range.Manila+0.05, "Manila", col = 'white', cex = 0.7)

points(mean.Shanghai, range.Shanghai, pch = 20, col = 'white')
textxy(mean.Shanghai-0.75, range.Shanghai, "Shanghai", col = 'white', cex = 0.7)

points(mean.Beijing, range.Beijing, pch = 20, col = 'white')
textxy(mean.Beijing, range.Beijing, "Beijing", col = 'white', cex = 0.7)

points(mean.NY, range.NY, pch = 20, col = 'white')
textxy(mean.NY - 0.75, range.NY, "New York", col = 'white', cex = 0.7)

points(mean.Guangzhou, range.Guangzhou, pch = 20, col = 'white')
textxy(mean.Guangzhou - 0.75, range.Guangzhou, "Guangzhou", col = 'white', cex = 0.7)

points(mean.Kobe, range.Kobe, pch = 20, col = 'white')
textxy(mean.Kobe - 0.4, range.Kobe, "Kobe", col = 'white', cex = 0.7)

points(mean.BuenosAires, range.BuenosAires, pch = 20, col = 'white')
textxy(mean.BuenosAires - 0.75, range.BuenosAires, "Buenos Aires", col = 'white', cex = 0.7)
dev.off()

tiff(filename = '~/Box Sync/Vector-borne disease/output/Fig5.tiff', width = 16.5, height = 12.7, units = 'cm', res = 600, compression = 'lzw')
par(mar = c(4.1, 4.1, 1.1, 2.1))
image.plot(oscillation.temp[oscillation.indices], amplitude[amplitude.indices], (I.cummulative.zero.mintemp[oscillation.indices, amplitude.indices]+I.cummulative.zero.meantemp[oscillation.indices, amplitude.indices]+I.cummulative.zero.maxtemp[oscillation.indices, amplitude.indices])/3,
           xlab = 'Oscillation Mean Temperature (°C)', ylab = 'Amplitude (°C)', legend.lab = 'Epidemic Suitability', zlim = c(0,1.0))
points(mean.SaoPaulo,range.SaoPaulo, pch = 20, col = 'white')
textxy(mean.SaoPaulo - 4.75,range.SaoPaulo, 'Sao Paulo', col = 'white', cex = 0.7)

points(mean.Rio, range.Rio, pch = 20, col = 'white')
textxy(mean.Rio - 0.75, range.Rio, 'Rio de Janeiro', col = 'white', cex = 0.7)

points(mean.Salvador, range.Salvador, pch = 20, col = 'white')
textxy(mean.Salvador-0.75, range.Salvador, 'Salvador', col = 'white', cex = 0.7)

points(mean.Fortaleza, range.Fortaleza, pch = 20, col = 'white')
textxy(mean.Fortaleza - 0.75, range.Fortaleza - 0.1, 'Fortaleza', cex = 0.7, col = 'white')

points(mean.BeloHorizonte, range.BeloHorizonte, pch = 20, col = 'white')
textxy(mean.BeloHorizonte - 0.75, range.BeloHorizonte, 'Belo Horizonte', col = 'white', cex = 0.7)

points(mean.Recife, range.Recife, pch = 20, col = 'white')
lines(c(mean.Recife, 22.5), c(range.Recife, 1), col = 'white')
textxy(22.5 - 2.75, 1 - 0.2, 'Recife', col = 'white', cex = 0.7)

points(mean.Bogota, range.Bogota, pch = 20, col = 'white')
textxy(mean.Bogota-2, range.Bogota+0.1, 'Bogota', col = 'white', cex = 0.7)

points(mean.Medellin, range.Medellin, pch = 20, col = 'white')
textxy(mean.Medellin-2, range.Medellin + 0.1, 'Medellin', col = 'white', cex = 0.7)

points(mean.Cali, range.Cali, pch = 20, col = 'white')
textxy(mean.Cali - 2, range.Cali, 'Cali', col = 'white', cex = 0.7)

points(mean.Barranquilla, range.Barranquilla, pch = 20, col = 'white')
lines(c(mean.Barranquilla, 32), c(range.Barranquilla, 2), col = 'white')
textxy(31,2, 'Barranquilla', col = 'white', cex = 0.7)

points(mean.Cartagena, range.Cartagena, pch = 20, col = 'white')
lines(c(mean.Cartagena, 25), c(range.Cartagena, 0.5), col = 'white')
textxy(20, 0.3, 'Cartagena', col = 'white', cex = 0.7)

points(mean.Tokyo,range.Tokyo, pch = 20, col='white')
textxy(mean.Tokyo - 2.75,range.Tokyo, "Tokyo", col='white', cex = 0.7)

points(mean.Delhi, range.Delhi, pch = 20, col = 'white')
textxy(mean.Delhi - 0.25, range.Delhi, "Delhi", col = 'white', cex = 0.7)

points(mean.Manila, range.Manila, pch = 20, col = 'white')
textxy(mean.Manila - 1.4, range.Manila+0.05, "Manila", col = 'white', cex = 0.7)

points(mean.Shanghai, range.Shanghai, pch = 20, col = 'white')
textxy(mean.Shanghai-0.75, range.Shanghai, "Shanghai", col = 'white', cex = 0.7)

points(mean.Beijing, range.Beijing, pch = 20, col = 'white')
textxy(mean.Beijing, range.Beijing, "Beijing", col = 'white', cex = 0.7)

points(mean.NY, range.NY, pch = 20, col = 'white')
textxy(mean.NY - 0.75, range.NY, "New York", col = 'white', cex = 0.7)

points(mean.Guangzhou, range.Guangzhou, pch = 20, col = 'white')
textxy(mean.Guangzhou - 0.75, range.Guangzhou, "Guangzhou", col = 'white', cex = 0.7)

points(mean.Kobe, range.Kobe, pch = 20, col = 'white')
textxy(mean.Kobe - 0.4, range.Kobe, "Kobe", col = 'white', cex = 0.7)

points(mean.BuenosAires, range.BuenosAires, pch = 20, col = 'white')
textxy(mean.BuenosAires - 0.75, range.BuenosAires, "Buenos Aires", col = 'white', cex = 0.7)
dev.off()

## compute epidemic suitability
suitability.BuenosAires = c(I.cummulative.zero.mintemp[which(oscillation.temp == round(mean.BuenosAires, 1)), which(amplitude == round(range.BuenosAires,1))],
                            I.cummulative.zero.meantemp[which(oscillation.temp == round(mean.BuenosAires, 1)), which(amplitude == round(range.BuenosAires,1))],
                            I.cummulative.zero.maxtemp[which(oscillation.temp == round(mean.BuenosAires, 1)), which(amplitude == round(range.BuenosAires,1))],
                            I.cummulative.twenty[which(oscillation.temp == round(mean.BuenosAires, 1)), which(amplitude == round(range.BuenosAires,1))],
                            I.cummulative.forty[which(oscillation.temp == round(mean.BuenosAires, 1)), which(amplitude == round(range.BuenosAires,1))],
                            I.cummulative.sixty[which(oscillation.temp == round(mean.BuenosAires, 1)), which(amplitude == round(range.BuenosAires,1))],
                            I.cummulative.eighty[which(oscillation.temp == round(mean.BuenosAires, 1)), which(amplitude == round(range.BuenosAires,1))])

suitability.SaoPaulo = c(I.cummulative.zero.mintemp[which(oscillation.temp == round(mean.SaoPaulo, 1)), which(amplitude == round(range.SaoPaulo,1))],
                         I.cummulative.zero.meantemp[which(oscillation.temp == round(mean.SaoPaulo, 1)), which(amplitude == round(range.SaoPaulo,1))],
                         I.cummulative.zero.maxtemp[which(oscillation.temp == round(mean.SaoPaulo, 1)), which(amplitude == round(range.SaoPaulo,1))],
                         I.cummulative.twenty[which(oscillation.temp == round(mean.SaoPaulo, 1)), which(amplitude == round(range.SaoPaulo,1))],
                         I.cummulative.forty[which(oscillation.temp == round(mean.SaoPaulo, 1)), which(amplitude == round(range.SaoPaulo,1))],
                         I.cummulative.sixty[which(oscillation.temp == round(mean.SaoPaulo, 1)), which(amplitude == round(range.SaoPaulo,1))],
                         I.cummulative.eighty[which(oscillation.temp == round(mean.SaoPaulo, 1)), which(amplitude == round(range.SaoPaulo,1))])

suitability.Rio = c(I.cummulative.zero.mintemp[which(oscillation.temp == round(mean.Rio, 1)), which(amplitude == round(range.Rio,1))],
                    I.cummulative.zero.meantemp[which(oscillation.temp == round(mean.Rio, 1)), which(amplitude == round(range.Rio,1))],
                    I.cummulative.zero.maxtemp[which(oscillation.temp == round(mean.Rio, 1)), which(amplitude == round(range.Rio,1))],
                    I.cummulative.twenty[which(oscillation.temp == round(mean.Rio, 1)), which(amplitude == round(range.Rio,1))],
                    I.cummulative.forty[which(oscillation.temp == round(mean.Rio, 1)), which(amplitude == round(range.Rio,1))],
                    I.cummulative.sixty[which(oscillation.temp == round(mean.Rio, 1)), which(amplitude == round(range.Rio,1))],
                    I.cummulative.eighty[which(oscillation.temp == round(mean.Rio, 1)), which(amplitude == round(range.Rio,1))])

suitability.Salvador = c(I.cummulative.zero.mintemp[which(oscillation.temp == round(mean.Salvador, 1)), which(amplitude == round(range.Salvador,1))],
                         I.cummulative.zero.meantemp[which(oscillation.temp == round(mean.Salvador, 1)), which(amplitude == round(range.Salvador,1))],
                         I.cummulative.zero.maxtemp[which(oscillation.temp == round(mean.Salvador, 1)), which(amplitude == round(range.Salvador,1))],
                         I.cummulative.twenty[which(oscillation.temp == round(mean.Salvador, 1)), which(amplitude == round(range.Salvador,1))],
                         I.cummulative.forty[which(oscillation.temp == round(mean.Salvador, 1)), which(amplitude == round(range.Salvador,1))],
                         I.cummulative.sixty[which(oscillation.temp == round(mean.Salvador, 1)), which(amplitude == round(range.Salvador,1))],
                         I.cummulative.eighty[which(oscillation.temp == round(mean.Salvador, 1)), which(amplitude == round(range.Salvador,1))])

suitability.Fortaleza = c(I.cummulative.zero.mintemp[which(oscillation.temp == round(mean.Fortaleza, 1)), which(amplitude == round(range.Fortaleza,1))],
                          I.cummulative.zero.meantemp[which(oscillation.temp == round(mean.Fortaleza, 1)), which(amplitude == round(range.Fortaleza,1))],
                          I.cummulative.zero.maxtemp[which(oscillation.temp == round(mean.Fortaleza, 1)), which(amplitude == round(range.Fortaleza,1))],
                          I.cummulative.twenty[which(oscillation.temp == round(mean.Fortaleza, 1)), which(amplitude == round(range.Fortaleza,1))],
                          I.cummulative.forty[which(oscillation.temp == round(mean.Fortaleza, 1)), which(amplitude == round(range.Fortaleza,1))],
                          I.cummulative.sixty[which(oscillation.temp == round(mean.Fortaleza, 1)), which(amplitude == round(range.Fortaleza,1))],
                          I.cummulative.eighty[which(oscillation.temp == round(mean.Fortaleza, 1)), which(amplitude == round(range.Fortaleza,1))])

suitability.BeloHorizonte = c(I.cummulative.zero.mintemp[round(mean.BeloHorizonte, 1) * 10 + 1, round(range.BeloHorizonte,1) * 10 + 1],
                              I.cummulative.zero.meantemp[round(mean.BeloHorizonte, 1) * 10 + 1, round(range.BeloHorizonte,1) * 10 + 1],
                              I.cummulative.zero.maxtemp[round(mean.BeloHorizonte, 1) * 10 + 1, round(range.BeloHorizonte,1) * 10 + 1],
                              I.cummulative.twenty[round(mean.BeloHorizonte, 1) * 10 + 1, round(range.BeloHorizonte,1) * 10 + 1],
                              I.cummulative.forty[round(mean.BeloHorizonte, 1) * 10 + 1, round(range.BeloHorizonte,1) * 10 + 1],
                              I.cummulative.sixty[round(mean.BeloHorizonte, 1) * 10 + 1, round(range.BeloHorizonte,1) * 10 + 1],
                              I.cummulative.eighty[round(mean.BeloHorizonte, 1) * 10 + 1, round(range.BeloHorizonte,1) * 10 + 1])

suitability.Recife = c(I.cummulative.zero.mintemp[round(mean.Recife, 1) * 10 + 1, round(range.Recife,1) * 10 + 1],
                       I.cummulative.zero.meantemp[round(mean.Recife, 1) * 10 + 1, round(range.Recife,1) * 10 + 1],
                       I.cummulative.zero.maxtemp[round(mean.Recife, 1) * 10 + 1, round(range.Recife,1) * 10 + 1],
                       I.cummulative.twenty[round(mean.Recife, 1) * 10 + 1, round(range.Recife,1) * 10 + 1],
                       I.cummulative.forty[round(mean.Recife, 1) * 10 + 1, round(range.Recife,1) * 10 + 1],
                       I.cummulative.sixty[round(mean.Recife, 1) * 10 + 1, round(range.Recife,1) * 10 + 1],
                       I.cummulative.eighty[round(mean.Recife, 1) * 10 + 1, round(range.Recife,1) * 10 + 1])

suitability.Shanghai = c(I.cummulative.zero.mintemp[which(oscillation.temp == round(mean.Shanghai, 1)), which(amplitude == round(range.Shanghai,1))],
                         I.cummulative.zero.meantemp[which(oscillation.temp == round(mean.Shanghai, 1)), which(amplitude == round(range.Shanghai,1))],
                         I.cummulative.zero.maxtemp[which(oscillation.temp == round(mean.Shanghai, 1)), which(amplitude == round(range.Shanghai,1))],
                         I.cummulative.twenty[which(oscillation.temp == round(mean.Shanghai, 1)), which(amplitude == round(range.Shanghai,1))],
                         I.cummulative.forty[which(oscillation.temp == round(mean.Shanghai, 1)), which(amplitude == round(range.Shanghai,1))],
                         I.cummulative.sixty[which(oscillation.temp == round(mean.Shanghai, 1)), which(amplitude == round(range.Shanghai,1))],
                         I.cummulative.eighty[which(oscillation.temp == round(mean.Shanghai, 1)), which(amplitude == round(range.Shanghai,1))])

suitability.Beijing = c(I.cummulative.zero.mintemp[which(oscillation.temp == round(mean.Beijing, 1)), which(amplitude == round(range.Beijing,1))],
                        I.cummulative.zero.meantemp[which(oscillation.temp == round(mean.Beijing, 1)), which(amplitude == round(range.Beijing,1))],
                        I.cummulative.zero.maxtemp[which(oscillation.temp == round(mean.Beijing, 1)), which(amplitude == round(range.Beijing,1))],
                        I.cummulative.twenty[which(oscillation.temp == round(mean.Beijing, 1)), which(amplitude == round(range.Beijing,1))],
                        I.cummulative.forty[which(oscillation.temp == round(mean.Beijing, 1)), which(amplitude == round(range.Beijing,1))],
                        I.cummulative.sixty[which(oscillation.temp == round(mean.Beijing, 1)), which(amplitude == round(range.Beijing,1))],
                        I.cummulative.eighty[which(oscillation.temp == round(mean.Beijing, 1)), which(amplitude == round(range.Beijing,1))])

suitability.Guangzhou = c(I.cummulative.zero.mintemp[round(mean.Guangzhou, 1) * 10 + 1, round(range.Guangzhou,1) * 10 + 1],
                          I.cummulative.zero.meantemp[round(mean.Guangzhou, 1) * 10 + 1, round(range.Guangzhou,1) * 10 + 1],
                          I.cummulative.zero.maxtemp[round(mean.Guangzhou, 1) * 10 + 1, round(range.Guangzhou,1) * 10 + 1],
                          I.cummulative.twenty[round(mean.Guangzhou, 1) * 10 + 1, round(range.Guangzhou,1) * 10 + 1],
                          I.cummulative.forty[round(mean.Guangzhou, 1) * 10 + 1, round(range.Guangzhou,1) * 10 + 1],
                          I.cummulative.sixty[round(mean.Guangzhou, 1) * 10 + 1, round(range.Guangzhou,1) * 10 + 1],
                          I.cummulative.eighty[round(mean.Guangzhou, 1) * 10 + 1, round(range.Guangzhou,1) * 10 + 1])

suitability.Bogota = c(I.cummulative.zero.mintemp[round(mean.Bogota, 1) * 10 + 1, round(range.Bogota,1) * 10 + 1],
                       I.cummulative.zero.meantemp[round(mean.Bogota, 1) * 10 + 1, round(range.Bogota,1) * 10 + 1],
                       I.cummulative.zero.maxtemp[round(mean.Bogota, 1) * 10 + 1, round(range.Bogota,1) * 10 + 1],
                       I.cummulative.twenty[round(mean.Bogota, 1) * 10 + 1, round(range.Bogota,1) * 10 + 1],
                       I.cummulative.forty[round(mean.Bogota, 1) * 10 + 1, round(range.Bogota,1) * 10 + 1],
                       I.cummulative.sixty[round(mean.Bogota, 1) * 10 + 1, round(range.Bogota,1) * 10 + 1],
                       I.cummulative.eighty[round(mean.Bogota, 1) * 10 + 1, round(range.Bogota,1) * 10 + 1])
  
suitability.Medellin = c(I.cummulative.zero.mintemp[round(mean.Medellin, 1) * 10 + 1, round(range.Medellin,1) * 10 + 1],
                         I.cummulative.zero.meantemp[round(mean.Medellin, 1) * 10 + 1, round(range.Medellin,1) * 10 + 1],
                         I.cummulative.zero.maxtemp[round(mean.Medellin, 1) * 10 + 1, round(range.Medellin,1) * 10 + 1],
                         I.cummulative.twenty[round(mean.Medellin, 1) * 10 + 1, round(range.Medellin,1) * 10 + 1],
                         I.cummulative.forty[round(mean.Medellin, 1) * 10 + 1, round(range.Medellin,1) * 10 + 1],
                         I.cummulative.sixty[round(mean.Medellin, 1) * 10 + 1, round(range.Medellin,1) * 10 + 1],
                         I.cummulative.eighty[round(mean.Medellin, 1) * 10 + 1, round(range.Medellin,1) * 10 + 1])

suitability.Cali = c(I.cummulative.zero.mintemp[which(oscillation.temp == round(mean.Cali, 1)), which(amplitude == round(range.Cali,1))],
                     I.cummulative.zero.meantemp[which(oscillation.temp == round(mean.Cali, 1)), which(amplitude == round(range.Cali,1))],
                     I.cummulative.zero.maxtemp[which(oscillation.temp == round(mean.Cali, 1)), which(amplitude == round(range.Cali,1))],
                     I.cummulative.twenty[which(oscillation.temp == round(mean.Cali, 1)), which(amplitude == round(range.Cali,1))],
                     I.cummulative.forty[which(oscillation.temp == round(mean.Cali, 1)), which(amplitude == round(range.Cali,1))],
                     I.cummulative.sixty[which(oscillation.temp == round(mean.Cali, 1)), which(amplitude == round(range.Cali,1))],
                     I.cummulative.eighty[which(oscillation.temp == round(mean.Cali, 1)), which(amplitude == round(range.Cali,1))])

suitability.Barranquilla = c(I.cummulative.zero.mintemp[which(oscillation.temp == round(mean.Barranquilla, 1)), which(amplitude == round(range.Barranquilla,1))],
                             I.cummulative.zero.meantemp[which(oscillation.temp == round(mean.Barranquilla, 1)), which(amplitude == round(range.Barranquilla,1))],
                             I.cummulative.zero.maxtemp[which(oscillation.temp == round(mean.Barranquilla, 1)), which(amplitude == round(range.Barranquilla,1))],
                            I.cummulative.twenty[which(oscillation.temp == round(mean.Barranquilla, 1)), which(amplitude == round(range.Barranquilla,1))],
                            I.cummulative.forty[which(oscillation.temp == round(mean.Barranquilla, 1)), which(amplitude == round(range.Barranquilla,1))],
                            I.cummulative.sixty[which(oscillation.temp == round(mean.Barranquilla, 1)), which(amplitude == round(range.Barranquilla,1))],
                            I.cummulative.eighty[which(oscillation.temp == round(mean.Barranquilla, 1)), which(amplitude == round(range.Barranquilla,1))])

suitability.Cartagena = c(I.cummulative.zero.mintemp[which(oscillation.temp == round(mean.Cartagena, 1)), which(amplitude == round(range.Cartagena,1))],
                          I.cummulative.zero.meantemp[which(oscillation.temp == round(mean.Cartagena, 1)), which(amplitude == round(range.Cartagena,1))],
                          I.cummulative.zero.maxtemp[which(oscillation.temp == round(mean.Cartagena, 1)), which(amplitude == round(range.Cartagena,1))],
                          I.cummulative.twenty[which(oscillation.temp == round(mean.Cartagena, 1)), which(amplitude == round(range.Cartagena,1))],
                          I.cummulative.forty[which(oscillation.temp == round(mean.Cartagena, 1)), which(amplitude == round(range.Cartagena,1))],
                          I.cummulative.sixty[which(oscillation.temp == round(mean.Cartagena, 1)), which(amplitude == round(range.Cartagena,1))],
                          I.cummulative.eighty[which(oscillation.temp == round(mean.Cartagena, 1)), which(amplitude == round(range.Cartagena,1))])

suitability.Delhi = c(I.cummulative.zero.mintemp[round(mean.Delhi, 1) * 10 + 1, round(range.Delhi,1) * 10 + 1],
                      I.cummulative.zero.meantemp[round(mean.Delhi, 1) * 10 + 1, round(range.Delhi,1) * 10 + 1],
                      I.cummulative.zero.maxtemp[round(mean.Delhi, 1) * 10 + 1, round(range.Delhi,1) * 10 + 1],
                      I.cummulative.twenty[round(mean.Delhi, 1) * 10 + 1, round(range.Delhi,1) * 10 + 1],
                      I.cummulative.forty[round(mean.Delhi, 1) * 10 + 1, round(range.Delhi,1) * 10 + 1],
                      I.cummulative.sixty[round(mean.Delhi, 1) * 10 + 1, round(range.Delhi,1) * 10 + 1],
                      I.cummulative.eighty[round(mean.Delhi, 1) * 10 + 1, round(range.Delhi,1) * 10 + 1])

suitability.Tokyo = c(I.cummulative.zero.mintemp[which(oscillation.temp == round(mean.Tokyo, 1)), which(amplitude == round(range.Tokyo,1))],
                      I.cummulative.zero.meantemp[which(oscillation.temp == round(mean.Tokyo, 1)), which(amplitude == round(range.Tokyo,1))],
                      I.cummulative.zero.maxtemp[which(oscillation.temp == round(mean.Tokyo, 1)), which(amplitude == round(range.Tokyo,1))],
                      I.cummulative.twenty[which(oscillation.temp == round(mean.Tokyo, 1)), which(amplitude == round(range.Tokyo,1))],
                      I.cummulative.forty[which(oscillation.temp == round(mean.Tokyo, 1)), which(amplitude == round(range.Tokyo,1))],
                      I.cummulative.sixty[which(oscillation.temp == round(mean.Tokyo, 1)), which(amplitude == round(range.Tokyo,1))],
                      I.cummulative.eighty[which(oscillation.temp == round(mean.Tokyo, 1)), which(amplitude == round(range.Tokyo,1))])

suitability.Kobe = c(I.cummulative.zero.mintemp[round(mean.Kobe, 1) * 10 + 1, round(range.Kobe,1) * 10 + 1],
                     I.cummulative.zero.meantemp[round(mean.Kobe, 1) * 10 + 1, round(range.Kobe,1) * 10 + 1],
                     I.cummulative.zero.maxtemp[round(mean.Kobe, 1) * 10 + 1, round(range.Kobe,1) * 10 + 1],
                     I.cummulative.twenty[round(mean.Kobe, 1) * 10 + 1, round(range.Kobe,1) * 10 + 1],
                     I.cummulative.forty[round(mean.Kobe, 1) * 10 + 1, round(range.Kobe,1) * 10 + 1],
                     I.cummulative.sixty[round(mean.Kobe, 1) * 10 + 1, round(range.Kobe,1) * 10 + 1],
                     I.cummulative.eighty[round(mean.Kobe, 1) * 10 + 1, round(range.Kobe,1) * 10 + 1])

suitability.Manila = c(I.cummulative.zero.mintemp[which(oscillation.temp == round(mean.Manila, 1)), which(amplitude == round(range.Manila,1))],
                       I.cummulative.zero.meantemp[which(oscillation.temp == round(mean.Manila, 1)), which(amplitude == round(range.Manila,1))],
                       I.cummulative.zero.maxtemp[which(oscillation.temp == round(mean.Manila, 1)), which(amplitude == round(range.Manila,1))],
                       I.cummulative.twenty[which(oscillation.temp == round(mean.Manila, 1)), which(amplitude == round(range.Manila,1))],
                       I.cummulative.forty[which(oscillation.temp == round(mean.Manila, 1)), which(amplitude == round(range.Manila,1))],
                       I.cummulative.sixty[which(oscillation.temp == round(mean.Manila, 1)), which(amplitude == round(range.Manila,1))],
                       I.cummulative.eighty[which(oscillation.temp == round(mean.Manila, 1)), which(amplitude == round(range.Manila,1))])
  
suitability.NY = c(I.cummulative.zero.mintemp[which(oscillation.temp == round(mean.NY, 1)), which(amplitude == round(range.NY,1))],
                   I.cummulative.zero.meantemp[which(oscillation.temp == round(mean.NY, 1)), which(amplitude == round(range.NY,1))],
                   I.cummulative.zero.maxtemp[which(oscillation.temp == round(mean.NY, 1)), which(amplitude == round(range.NY,1))],
                   I.cummulative.twenty[which(oscillation.temp == round(mean.NY, 1)), which(amplitude == round(range.NY,1))],
                   I.cummulative.forty[which(oscillation.temp == round(mean.NY, 1)), which(amplitude == round(range.NY,1))],
                   I.cummulative.sixty[which(oscillation.temp == round(mean.NY, 1)), which(amplitude == round(range.NY,1))],
                   I.cummulative.eighty[which(oscillation.temp == round(mean.NY, 1)), which(amplitude == round(range.NY,1))])

