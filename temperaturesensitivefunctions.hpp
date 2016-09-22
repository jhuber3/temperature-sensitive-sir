// including necessary preprocessing directives
#include <cmath>

// This function implements the Briere fit for unimodal curves.
// Documentation for this model fit can be found in Briere et al. (1999)
// In this model, T0 and Tm are the lower and upper temperature constraints,
// respectively. c is a rate constant. x is the value to be inputted.
double briere(double x, double c, double T0, double Tm);

// This function implements the quadratic fit for a unimodal curve.
// In this model, T0 and Tm are the lower and upper temperature constraints,
// respectively. c is a rate constant. x is the value to be inputted.
double quadratic(double x, double c, double T0, double Tm);

// This function implements the inverted quadratic fit.
// In this model, T0 and Tm are the lower and upper temeprature constraints,
// respectively. c is a rate constant. x is the value to be inputted.
double inverted_quadratic(double x, double c, double T0, double Tm);

// This function implements the model fit for the biting rate of an Ae. aegypti
// mosquito. Mordecai et al used a Briere function to model this parameter.
// For more documentation, see the Briere function.
double a(double temp);

// This function implements the model fit for the probability of mosquito
// infectiousness. This is defined as the probability that a mosquito infected
// with DENV becomes infectious (has virus in the salivary glands).
// Mordecai et al used a Briere function to model this parameter.
// For more documentation, see the Briere function.
double b(double temp);

// This function implements the model fit for the probability of mosquito
// infection. This is defined as the probability that a mosquito fed on
// DENV-infected blood becomes infected.
// Mordecai et al used a Briere function to model this parameter.
// For more documentation, see the Briere function.
double pMI(double temp);

// This function implements the model fit for the fecundity rate. This is
// defined as the number of eggs laid per female per day.
// Mordecai et al used a Briere function to model this parameter.
// For more documentation, see the Briere function.
double EFD(double temp);

// This function implements the model fit for the probabilty of egg-to-adult
// survival. Mordecai et al used a quadratic function to model this parameter.
// For more docume ntation, see the quadratic function.
double pEA(double temp);

// This function implements the model fit for the mosquito development rate.
// Mordecai et al used a Briere funtion to model this parameter.
// For more documentation, see the Briere function.
double MDR(double temp);

// This function implements the model fit for the mosquito mortality rate.
// Originally, Mordecai et al provided a quadratic fit for the adult lifespan
// parameter. This was inverted to arrive at a mortality rate with units (1/day)
// For more documentation, see the inverted quadratic function.
double mu(double temp);

// This function implements the model fit for the parasite development rate.
// This is often referred to as the extrinsic incubation period (EIP).
// Mordecai et al used a Briere function to model this parameter.
// For more documentation, see the Briere function.
double PDR(double temp);

// This function implements the carrying capacity for the mosquito population
// using a modified Arrhenius equation. Documentation for this model fit can be
// found in Palamara et al (2014).
// In this model, T0 refers to the temperature at which carrying capacity is
// maximized. EA is the activation energy. N is the size of the maximum carrying
// capacity. temp is the value of the temperature to be inputted.
double carrying_capacity(double temp, double T0, double EA, double N);
