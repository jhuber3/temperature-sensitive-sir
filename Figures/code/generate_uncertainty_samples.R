# clear existing workspace
rm(list = ls())

# set working directory
setwd('~/Box Sync/Vector-borne disease/code/')

# load .RSave file with marginal posterior distribution
load('../data/Informative_Aegypti_DENV_ParameterFits_2016-03-30.Rsave')
load('../data/LifespanFits_2016-03-30-informative.Rsave')

# 1,000 random samples of posterior
indices.samples = sample(1:25000, 50)

a.writeout = (a.samps[indices.samples, 1:3])

# write output to .txt file
write.table((a.samps[indices.samples, 1:3]), file = '../data/a_uncertainty.txt', row.names = FALSE, col.names = FALSE)
write.table((b.samps[indices.samples, 1:3]), file = '../data/b_uncertainty.txt', row.names = FALSE, col.names = FALSE)
write.table((c.samps[indices.samples, 1:3]), file = '../data/c_uncertainty.txt', row.names = FALSE, col.names = FALSE)
write.table((e2a.samps[indices.samples, 1:3]), file = '../data/e2a_uncertainty.txt', row.names = FALSE, col.names = FALSE)
write.table((EFD.samps[indices.samples, 1:3]), file = '../data/EFD_uncertainty.txt', row.names = FALSE, col.names = FALSE)
write.table((MDR.samps[indices.samples, 1:3]), file = '../data/MDR_uncertainty.txt', row.names = FALSE, col.names = FALSE)
write.table((PDR.samps[indices.samples, 1:3]), file = '../data/PDR_uncertainty.txt', row.names = FALSE, col.names = FALSE)
write.table((lf.DENV.samps[indices.samples, 1:3]), file = '../data/mu_uncertainty.txt', row.names = FALSE, col.names = FALSE)

