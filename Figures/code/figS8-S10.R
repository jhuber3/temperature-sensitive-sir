## set working directory
setwd('~/Box Sync/Vector-borne disease/code/')

## clear existing workspace
rm(list=ls())

## declare and initialize necessary variables
oscillation.temp = seq(from = 0.0, to = 40.0, by = 0.1)
amplitude = seq(from = 0.0, to = 20.0, by = 0.1)
header = '~/Box Sync/Vector-borne disease/data/amplitude_oscillation/uncertainty/output_'
extension = '.txt'

# load city data
load(file = '~/Box Sync/Vector-borne disease/data/weather.RData')

## access data
uncertainty.finalepidemicsize = list()
N = 10000
pb <- txtProgressBar(min = 0, max = 50, style = 3)
for(n in 0:49)
{
  filename = paste(header, n, extension, sep = '')
  output = matrix(unlist(read.table(filename, quote = "\"", comment.char="")),nrow = 401, ncol = 201)
  uncertainty.finalepidemicsize[[n+1]] = output / N
  setTxtProgressBar(pb, n+1)
}

sum.finalepidemicsize = matrix(0, nrow = 401, ncol = 301)
for(n in 1:50)
{
  sum.finalepidemicsize = sum.finalepidemicsize + uncertainty.finalepidemicsize[[n]]
}

arr <- array(unlist(uncertainty.finalepidemicsize), c(401,201,50) )
image(rowMeans(arr, dim = 2))
dim(uncertainty.finalepidemicsize[[1]])

mean <- apply(arr, c(1,2), mean)
sd <- apply(arr, c(1,2), mean)

min.quantile = apply(arr, c(1,2), quantile, 0.025)
median.quantile = apply(arr, c(1,2), quantile, 0.50)
max.quantile = apply(arr, c(1,2), quantile, 0.975)

oscillation.indices= seq(from = which(oscillation.temp == 10), to = which(oscillation.temp == 38), by = 1)
amplitude.indices = seq(from = 1, to = which(amplitude == 17), by = 1)

tiff(filename = '~/Box Sync/Vector-borne disease/output/S8 Fig.tiff', width = 16.5, height = 12.7, units = 'cm', res = 600, compression = 'lzw')
par(mar = c(4.1, 4.1, 1.1, 2.1))
image.plot(oscillation.temp[oscillation.indices], amplitude[amplitude.indices], min.quantile[oscillation.indices, amplitude.indices],
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

tiff(filename = '~/Box Sync/Vector-borne disease/output/S9 Fig.tiff', width = 16.5, height = 12.7, units = 'cm', res = 600, compression = 'lzw')
par(mar = c(4.1,4.1,1.1,2.1))
image.plot(oscillation.temp[oscillation.indices], amplitude[amplitude.indices], median.quantile[oscillation.indices, amplitude.indices],
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

tiff(filename = '~/Box Sync/Vector-borne disease/output/S10 Fig.tiff', width = 16.5, height = 12.7, units = 'cm', res = 600, compression = 'lzw')
par(mar = c(4.1, 4.1, 1.1, 2.1))
image.plot(oscillation.temp[oscillation.indices], amplitude[amplitude.indices], max.quantile[oscillation.indices, amplitude.indices],
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


# compute epidemic suitabilities for each city
suitability.BuenosAires = c(min.quantile[which(oscillation.temp == round(mean.BuenosAires, 1)), which(amplitude == round(range.BuenosAires,1))],
                            median.quantile[which(oscillation.temp == round(mean.BuenosAires, 1)), which(amplitude == round(range.BuenosAires,1))],
                            max.quantile[which(oscillation.temp == round(mean.BuenosAires, 1)), which(amplitude == round(range.BuenosAires,1))])

suitability.SaoPaulo = c(min.quantile[which(oscillation.temp == round(mean.SaoPaulo, 1)), which(amplitude == round(range.SaoPaulo,1))],
                         median.quantile[which(oscillation.temp == round(mean.SaoPaulo, 1)), which(amplitude == round(range.SaoPaulo,1))],
                         max.quantile[which(oscillation.temp == round(mean.SaoPaulo, 1)), which(amplitude == round(range.SaoPaulo,1))])

suitability.Rio = c(min.quantile[which(oscillation.temp == round(mean.Rio, 1)), which(amplitude == round(range.Rio,1))],
                    median.quantile[which(oscillation.temp == round(mean.Rio, 1)), which(amplitude == round(range.Rio,1))],
                    max.quantile[which(oscillation.temp == round(mean.Rio, 1)), which(amplitude == round(range.Rio,1))])

suitability.Salvador = c(min.quantile[which(oscillation.temp == round(mean.Salvador, 1)), which(amplitude == round(range.Salvador,1))],
                         median.quantile[which(oscillation.temp == round(mean.Salvador, 1)), which(amplitude == round(range.Salvador,1))],
                         max.quantile[which(oscillation.temp == round(mean.Salvador, 1)), which(amplitude == round(range.Salvador,1))])

suitability.Fortaleza = c(min.quantile[which(oscillation.temp == round(mean.Fortaleza, 1)), which(amplitude == round(range.Fortaleza,1))],
                          median.quantile[which(oscillation.temp == round(mean.Fortaleza, 1)), which(amplitude == round(range.Fortaleza,1))],
                          max.quantile[which(oscillation.temp == round(mean.Fortaleza, 1)), which(amplitude == round(range.Fortaleza,1))])

suitability.BeloHorizonte = c(min.quantile[round(mean.BeloHorizonte, 1) * 10 + 1, round(range.BeloHorizonte,1) * 10 + 1],
                              median.quantile[round(mean.BeloHorizonte, 1) * 10 + 1, round(range.BeloHorizonte,1) * 10 + 1],
                              max.quantile[round(mean.BeloHorizonte, 1) * 10 + 1, round(range.BeloHorizonte,1) * 10 + 1])

suitability.Recife = c(min.quantile[round(mean.Recife, 1) * 10 + 1, round(range.Recife,1) * 10 + 1],
                       median.quantile[round(mean.Recife, 1) * 10 + 1, round(range.Recife,1) * 10 + 1],
                       max.quantile[round(mean.Recife, 1) * 10 + 1, round(range.Recife,1) * 10 + 1])

suitability.Shanghai = c(min.quantile[which(oscillation.temp == round(mean.Shanghai, 1)), which(amplitude == round(range.Shanghai,1))],
                         median.quantile[which(oscillation.temp == round(mean.Shanghai, 1)), which(amplitude == round(range.Shanghai,1))],
                         max.quantile[which(oscillation.temp == round(mean.Shanghai, 1)), which(amplitude == round(range.Shanghai,1))])

suitability.Beijing = c(min.quantile[which(oscillation.temp == round(mean.Beijing, 1)), which(amplitude == round(range.Beijing,1))],
                        median.quantile[which(oscillation.temp == round(mean.Beijing, 1)), which(amplitude == round(range.Beijing,1))],
                        max.quantile[which(oscillation.temp == round(mean.Beijing, 1)), which(amplitude == round(range.Beijing,1))])

suitability.Guangzhou = c(min.quantile[round(mean.Guangzhou, 1) * 10 + 1, round(range.Guangzhou,1) * 10 + 1],
                          median.quantile[round(mean.Guangzhou, 1) * 10 + 1, round(range.Guangzhou,1) * 10 + 1],
                          max.quantile[round(mean.Guangzhou, 1) * 10 + 1, round(range.Guangzhou,1) * 10 + 1])

suitability.Bogota = c(min.quantile[round(mean.Bogota, 1) * 10 + 1, round(range.Bogota,1) * 10 + 1],
                       median.quantile[round(mean.Bogota, 1) * 10 + 1, round(range.Bogota,1) * 10 + 1],
                       max.quantile[round(mean.Bogota, 1) * 10 + 1, round(range.Bogota,1) * 10 + 1])

suitability.Medellin = c(min.quantile[round(mean.Medellin, 1) * 10 + 1, round(range.Medellin,1) * 10 + 1],
                         median.quantile[round(mean.Medellin, 1) * 10 + 1, round(range.Medellin,1) * 10 + 1],
                         max.quantile[round(mean.Medellin, 1) * 10 + 1, round(range.Medellin,1) * 10 + 1])

suitability.Cali = c(min.quantile[which(oscillation.temp == round(mean.Cali, 1)), which(amplitude == round(range.Cali,1))],
                     median.quantile[which(oscillation.temp == round(mean.Cali, 1)), which(amplitude == round(range.Cali,1))],
                     max.quantile[which(oscillation.temp == round(mean.Cali, 1)), which(amplitude == round(range.Cali,1))])

suitability.Barranquilla = c(min.quantile[which(oscillation.temp == round(mean.Barranquilla, 1)), which(amplitude == round(range.Barranquilla,1))],
                             median.quantile[which(oscillation.temp == round(mean.Barranquilla, 1)), which(amplitude == round(range.Barranquilla,1))],
                             max.quantile[which(oscillation.temp == round(mean.Barranquilla, 1)), which(amplitude == round(range.Barranquilla,1))])

suitability.Cartagena = c(min.quantile[which(oscillation.temp == round(mean.Cartagena, 1)), which(amplitude == round(range.Cartagena,1))],
                          median.quantile[which(oscillation.temp == round(mean.Cartagena, 1)), which(amplitude == round(range.Cartagena,1))],
                          max.quantile[which(oscillation.temp == round(mean.Cartagena, 1)), which(amplitude == round(range.Cartagena,1))])

suitability.Delhi = c(min.quantile[round(mean.Delhi, 1) * 10 + 1, round(range.Delhi,1) * 10 + 1],
                      median.quantile[round(mean.Delhi, 1) * 10 + 1, round(range.Delhi,1) * 10 + 1],
                      max.quantile[round(mean.Delhi, 1) * 10 + 1, round(range.Delhi,1) * 10 + 1])

suitability.Tokyo = c(min.quantile[which(oscillation.temp == round(mean.Tokyo, 1)), which(amplitude == round(range.Tokyo,1))],
                      median.quantile[which(oscillation.temp == round(mean.Tokyo, 1)), which(amplitude == round(range.Tokyo,1))],
                      max.quantile[which(oscillation.temp == round(mean.Tokyo, 1)), which(amplitude == round(range.Tokyo,1))])

suitability.Kobe = c(min.quantile[round(mean.Kobe, 1) * 10 + 1, round(range.Kobe,1) * 10 + 1],
                     median.quantile[round(mean.Kobe, 1) * 10 + 1, round(range.Kobe,1) * 10 + 1],
                     max.quantile[round(mean.Kobe, 1) * 10 + 1, round(range.Kobe,1) * 10 + 1])

suitability.Manila = c(min.quantile[which(oscillation.temp == round(mean.Manila, 1)), which(amplitude == round(range.Manila,1))],
                       median.quantile[which(oscillation.temp == round(mean.Manila, 1)), which(amplitude == round(range.Manila,1))],
                       max.quantile[which(oscillation.temp == round(mean.Manila, 1)), which(amplitude == round(range.Manila,1))])

suitability.NY = c(min.quantile[which(oscillation.temp == round(mean.NY, 1)), which(amplitude == round(range.NY,1))],
                   median.quantile[which(oscillation.temp == round(mean.NY, 1)), which(amplitude == round(range.NY,1))],
                   max.quantile[which(oscillation.temp == round(mean.NY, 1)), which(amplitude == round(range.NY,1))])
