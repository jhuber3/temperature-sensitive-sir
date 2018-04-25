## clear existing workspace
rm(list=ls())

## set working directory
setwd('~/Box Sync/Vector-borne disease/code/')

## load necessary data
weather = read.csv(file = '../data/Temperature Profiles by City.csv')

## city weather data
weather.SaoPaulo = as.numeric(weather[which(weather$City == "Sao Paulo"), 2:13])
max.SaoPaulo = max(weather.SaoPaulo)
mean.SaoPaulo = mean(weather.SaoPaulo)
min.SaoPaulo = min(weather.SaoPaulo)
range.SaoPaulo = (max.SaoPaulo - min.SaoPaulo)/2

weather.Rio = as.numeric(weather[which(weather$City == "Rio de Janeiro"), 2:13])
max.Rio = max(weather.Rio)
mean.Rio = mean(weather.Rio)
min.Rio = min(weather.Rio)
range.Rio = (max.Rio - min.Rio)/2

weather.Salvador = as.numeric(weather[which(weather$City == "Salvador"), 2:13])
max.Salvador = max(weather.Salvador)
mean.Salvador = mean(weather.Salvador)
min.Salvador = min(weather.Salvador)
range.Salvador = (max.Salvador - min.Salvador)/2

weather.Fortaleza = as.numeric(weather[which(weather$City == "Fortaleza"), 2:13])
max.Fortaleza = max(weather.Fortaleza)
mean.Fortaleza = mean(weather.Fortaleza)
min.Fortaleza = min(weather.Fortaleza)
range.Fortaleza = (max.Fortaleza - min.Fortaleza)/2

weather.BeloHorizonte = as.numeric(weather[which(weather$City == "Belo Horizonte"), 2:13])
max.BeloHorizonte = max(weather.BeloHorizonte)
mean.BeloHorizonte = mean(weather.BeloHorizonte)
min.BeloHorizonte = min(weather.BeloHorizonte)
range.BeloHorizonte = (max.BeloHorizonte - min.BeloHorizonte)/2

weather.Recife = as.numeric(weather[which(weather$City == "Recife"), 2:13])
max.Recife = max(weather.Recife)
mean.Recife = mean(weather.Recife)
min.Recife = min(weather.Recife)
range.Recife = (max.Recife - min.Recife)/2

weather.Bogota = as.numeric(weather[which(weather$City == "Bogota"), 2:13])
max.Bogota = max(weather.Bogota)
mean.Bogota = mean(weather.Bogota)
min.Bogota = min(weather.Bogota)
range.Bogota = (max.Bogota - min.Bogota)/2

weather.Medellin = as.numeric(weather[which(weather$City == "Medellin"), 2:13])
max.Medellin = max(weather.Medellin)
mean.Medellin = mean(weather.Medellin)
min.Medellin = min(weather.Medellin)
range.Medellin = (max.Medellin - min.Medellin)/2

weather.Cali = as.numeric(weather[which(weather$City == "Cali"), 2:13])
max.Cali = max(weather.Cali)
mean.Cali = mean(weather.Cali)
min.Cali = min(weather.Cali)
range.Cali = (max.Cali - min.Cali)/2

weather.Barranquilla = as.numeric(weather[which(weather$City == "Barranquilla"), 2:13])
max.Barranquilla = max(weather.Barranquilla)
mean.Barranquilla = mean(weather.Barranquilla)
min.Barranquilla = min(weather.Barranquilla)
range.Barranquilla = (max.Barranquilla - min.Barranquilla)/2

weather.Cartagena = as.numeric(weather[which(weather$City == "Cartagena"), 2:13])
max.Cartagena = max(weather.Cartagena)
mean.Cartagena = mean(weather.Cartagena)
min.Cartagena = min(weather.Cartagena)
range.Cartagena = (max.Cartagena - min.Cartagena)/2

weather.Tokyo = as.numeric(weather[which(weather$City == "Tokyo"), 2:13])
max.Tokyo = max(weather.Tokyo)
mean.Tokyo = mean(weather.Tokyo)
min.Tokyo = min(weather.Tokyo)
range.Tokyo = (max.Tokyo - min.Tokyo)/2

weather.Delhi = as.numeric(weather[which(weather$City == "Dehli"), 2:13])
max.Delhi = max(weather.Delhi)
mean.Delhi = mean(weather.Delhi)
min.Delhi = min(weather.Delhi)
range.Delhi = (max.Delhi - min.Delhi)/2

weather.Manila = as.numeric(weather[which(weather$City == "Manila"), 2:13])
max.Manila = max(weather.Manila)
mean.Manila = mean(weather.Manila)
min.Manila = min(weather.Manila)
range.Manila = (max.Manila - min.Manila)/2

weather.Shanghai = as.numeric(weather[which(weather$City == "Shanghai"), 2:13])
max.Shanghai = max(weather.Shanghai)
mean.Shanghai = mean(weather.Shanghai)
min.Shanghai = min(weather.Shanghai)
range.Shanghai = (max.Shanghai - min.Shanghai)/2

weather.Beijing = as.numeric(weather[which(weather$City == "Beijing"), 2:13])
max.Beijing = max(weather.Beijing)
mean.Beijing = mean(weather.Beijing)
min.Beijing = min(weather.Beijing)
range.Beijing = (max.Beijing - min.Beijing)/2

weather.NY = as.numeric(weather[which(weather$City == "New York"), 2:13])
max.NY = max(weather.NY)
mean.NY = mean(weather.NY)
min.NY = min(weather.NY)
range.NY = (max.NY - min.NY)/2

weather.Guangzhou = as.numeric(weather[which(weather$City == "Guangzhou"), 2:13])
max.Guangzhou = max(weather.Guangzhou)
mean.Guangzhou = mean(weather.Guangzhou)
min.Guangzhou = min(weather.Guangzhou)
range.Guangzhou = (max.Guangzhou - min.Guangzhou)/2

weather.Kobe = as.numeric(weather[which(weather$City == "Kobe"), 2:13])
max.Kobe = max(weather.Kobe)
mean.Kobe = mean(weather.Kobe)
min.Kobe = min(weather.Kobe)
range.Kobe = (max.Kobe - min.Kobe)/2

weather.BuenosAires = as.numeric(weather[which(weather$City == "Buenos Aires"), 2:13])
max.BuenosAires = max(weather.BuenosAires)
mean.BuenosAires = mean(weather.BuenosAires)
min.BuenosAires = min(weather.BuenosAires)
range.BuenosAires = (max.BuenosAires - min.BuenosAires)/2

## save data 
save(list=ls(), file = '~/Box Sync/Vector-borne disease/data/weather.RData')

