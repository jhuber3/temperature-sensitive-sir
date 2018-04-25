## load necessary packages
require(deSolve)

## load data
load(file = 'Informative_Aegypti_DENV_ParameterFits_2016-03-30.Rsave')
load(file = 'LifespanFits_2016-03-30-informative (1).Rsave')
load(file = 'aegyptiuncertainty.RData')

## write functions
sir = function(t, y, p){
  M1 = y[1]
  M2 = y[2]
  M3 = y[3]

  M = M1+M2+M3

  S = y[4]
  E = y[5]
  I = y[6]
  R = y[7]

  N = S + E + I + R
  with(as.list(p,t), {
    dM1 = (EFD*pEA*MDR)*(M1+M2+M3)*(1-((M1+M2+M3)/K))-(a*pMI*(I)/(N)+mu)*M1
    dM2 = (a*pMI*(I+5)/(N))*M1-(PDR+mu)*M2
    dM3 = PDR*M2-mu*M3

    dS = -a*b*(M3/(N))*S
    dE = a*b*(M3/(N))*S-alpha*E
    dI = alpha*E-eta*(I)
    dR = eta*(I)

    dx = c(dM1, dM2, dM3, dS, dE, dI, dR)
    list(dx)
  })
}

## sample 1,000 steps in the chain
steps = sample(1:25000, 1000)

## set the starting conditions
temp = seq(from = 10, to = 40, by = 0.5)
times = seq(from = 0, to = 365, by = 0.01)

## declare and initialize the matrix
epidemicsize.matrix = matrix(rep(0, length(steps) * length(temp)), nrow = length(steps), ncol = length(temp))

## loop through and fill the matrix
for(ii in steps){
  for(jj in 1:length(temp)){
    M.initial = carrying.capacity(temp[jj],29.0,0.05,20000,EFD.samps[ii,3],EFD.samps[ii,1],EFD.samps[ii,2],
                                  e2a.samps[ii,3], e2a.samps[ii,1], e2a.samps[ii,2], MDR.samps[ii,3], MDR.samps[ii,1],
                                  MDR.samps[ii,2], lf.DENV.samps[ii,3], lf.DENV.samps[ii,1], lf.DENV.samps[ii,2])
    y0 <- c(0.985*M.initial,0.0,0.015*M.initial,9975.0,0.0,25.0,0.0)
    parameters = c(a = a.function(temp[jj],a.samps[ii,3],a.samps[ii,1],a.samps[ii,2]), b = b.function(temp[jj],b.samps[ii,3],b.samps[ii,1],b.samps[ii,2]),
                   EFD = EFD.function(temp[jj], EFD.samps[ii,3], EFD.samps[ii,1], EFD.samps[ii,2]), pEA = pEA.function(temp[jj], e2a.samps[ii,3], e2a.samps[ii,1], e2a.samps[ii,2]),
                   MDR = MDR.function(temp[jj], MDR.samps[ii,3], MDR.samps[ii,1], MDR.samps[ii,2]), pMI = pMI.function(temp[jj], c.samps[ii,3], c.samps[ii,1], c.samps[ii,2]),
                   mu = mu.m.function(temp[jj], lf.DENV.samps[ii,3], lf.DENV.samps[ii,1], lf.DENV.samps[ii,2]),
                   PDR = PDR.function(temp[jj], PDR.samps[ii,3], PDR.samps[ii,1], PDR.samps[ii,2]),
                   K= M.initial, alpha = 1/5.9, eta = 1/5)
    sir.out <- as.data.frame(ode(y0, times, sir, parameters, method='rk4'))
    epidemicsize.matrix[which(steps == ii),jj]=max(sir.out[, 8])
  }
}

save(epidemicsize.matrix, file = 'sensitivityoutputV2.RData')
