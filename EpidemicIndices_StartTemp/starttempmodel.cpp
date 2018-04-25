//******************************************************************************
// Name                 : starttempmodel.cpp
// Author               : John Huber
// Copyright            : CRAPL
// Description          : This is the implementation of the time/temperature-
//                      : sensitive SEI-SEIR model for disease transmission.
//                      : In this model, temperature is modeled as a sinusoidal
//                      : curve with varying mean temperature and amplitude.
//                      : The model varies with the starting temperature of the
//                      : epidemic.
//******************************************************************************

// preprocessor directives
#include <cmath>
#include <cstdlib>
#include <ctime>
#include <fstream>
#include <iostream>
#include <sstream>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <vector>

#include <boost/array.hpp>
#include <boost/numeric/odeint.hpp>

#include "temperaturesensitivefunctions.hpp"

// declare the appropriate namespaces
using namespace std;
using namespace boost::numeric::odeint;

// establish typedef
typedef boost::array<double,7> state_type;

// establish the necessary constants
const double pi = boost::math::constants::pi<double>();

// This is a function to calculate the temperature for a shifted curve
double temperature_curve(double t, double start_temp, double frequency, double amplitude, double oscillation_temp){
  double phase;
  if(amplitude - 0.0 < 1e-6)
  {
    phase = 0.0;
  }
  else
  {
    double val = min(max((start_temp - oscillation_temp) / amplitude,-1.0),1.0);
    phase = (-1.0/frequency)*asin(val);
  }
  double temp = amplitude * sin(frequency*(t - phase)) + oscillation_temp;
  return temp;
}


// This is a struct for the SEI-SEIR model where the starting temperature is
// allowed to vary.
// Parameter values are defined as follows:
// x[0] = M1; x[1] = M2; x[2] = M3; x[3] = S; x[4] = E; x[5] = I; x[6] = R;
// dxdt[0] = dM1; dxdt[1] = dM2; dxdt[2] = dM3; dxdt[3] = dS; dxdt[4] = dE;
// dxdt[5] = dI; dxdt[6] = dR;
// For more documentation, please see Huber et al. (2018)
struct sirmodel
{
  double start_temp;
  double timestep;

  sirmodel(double start_temp, double timestep) : start_temp(start_temp), timestep(timestep) {}

  void operator()( state_type &x, state_type &dxdt, double t) const
  {
    double temp = temperature_curve(t,start_temp,2*pi/365,15.0,25.0);
    double K = carrying_capacity(temp,29.0,0.05,20000, timestep);
    // std::cout << temp << " " << K << std::endl;

    if(x[0] < 1e-20)
    {
      x[0] = 0.0;
    }
    if(x[1] < 1e-20)
    {
      x[1] = 0.0;
    }
    if(x[2] < 1e-20)
    {
      x[2] = 0.0;
    }
    if(x[3] < 1e-20)
    {
      x[3] = 0.0;
    }
    if(x[4] < 1e-20)
    {
      x[4] = 0.0;
    }
    if(x[5] < 1e-20)
    {
      x[5] = 0.0;
    }
    if(x[6] < 1e-20)
    {
      x[6] = 0.0;
    }

    dxdt[0] = (EFD(temp)*pEA(temp)*MDR(temp)*(1.0/mu(temp,timestep)))*(x[0]+x[1]+x[2])*(1-((x[0]+x[1]+x[2])/K))-
        (a(temp)*pMI(temp)*x[5]/(x[3]+x[4]+x[5]+x[6])+mu(temp,timestep))*x[0];

      dxdt[1] = (a(temp)*pMI(temp)*x[5]/(x[3]+x[4]+x[5]+x[6]))*x[0]-(PDR(temp)+mu(temp,timestep))*x[1];

      dxdt[2] = PDR(temp)*x[1]-mu(temp,timestep)*x[2];

      dxdt[3] = -a(temp)*b(temp)*(x[2]/(x[3] + x[4] + x[5] + x[6]))*x[3];

      dxdt[4] = a(temp)*b(temp)*(x[2]/(x[3] + x[4] + x[5] + x[6]))*x[3]-(1.0/5.9)*x[4];

      dxdt[5] = (1.0/5.9)*x[4]-(1.0/5.0)*x[5];

      dxdt[6] = (1.0/5.0)*x[5];
  }
};

struct sirmodel_uncertainty
{
  double start_temp;
  vector<double> EFD_parms;
  vector<double> pEA_parms;
  vector<double> MDR_parms;
  vector<double> a_parms;
  vector<double> pMI_parms;
  vector<double> mu_parms;
  vector<double> PDR_parms;
  vector<double> b_parms;
  double timestep;

  sirmodel_uncertainty(double start_temp, vector<double> EFD_parms, vector<double> pEA_parms,
  vector<double> MDR_parms, vector<double> a_parms, vector<double> pMI_parms,
  vector<double> mu_parms, vector<double> PDR_parms, vector<double> b_parms, double timestep): start_temp(start_temp),
  EFD_parms(EFD_parms), pEA_parms(pEA_parms), MDR_parms(MDR_parms), a_parms(a_parms), pMI_parms(pMI_parms),
  mu_parms(mu_parms), PDR_parms(PDR_parms), b_parms(b_parms), timestep(timestep) {}

  void operator()( state_type &x , state_type &dxdt , double t ) const
  {
    double temp = temperature_curve(t,start_temp,2*pi/365,15.0,25.0);
    double K = carrying_capacity(temp,29.0,0.05,20000,timestep);

    if(x[0] < 1e-20)
    {
      x[0] = 0.0;
    }
    if(x[1] < 1e-20)
    {
      x[1] = 0.0;
    }
    if(x[2] < 1e-20)
    {
      x[2] = 0.0;
    }
    if(x[3] < 1e-20)
    {
      x[3] = 0.0;
    }
    if(x[4] < 1e-20)
    {
      x[4] = 0.0;
    }
    if(x[5] < 1e-20)
    {
      x[5] = 0.0;
    }
    if(x[6] < 1e-20)
    {
      x[6] = 0.0;
    }

    dxdt[0] = (EFD(temp, EFD_parms)*pEA(temp, pEA_parms)*MDR(temp, MDR_parms)*(1.0/mu(temp,mu_parms,timestep)))*(x[0]+x[1]+x[2])*(1-((x[0]+x[1]+x[2])/K))-
    (a(temp, a_parms)*pMI(temp, pMI_parms)*x[5]/(x[3]+x[4]+x[5]+x[6])+mu(temp, mu_parms,timestep))*x[0];

    dxdt[1] = (a(temp, a_parms)*pMI(temp, pMI_parms)*x[5]/(x[3]+x[4]+x[5]+x[6]))*x[0]-(PDR(temp, PDR_parms)+mu(temp, mu_parms,timestep))*x[1];

    dxdt[2] = PDR(temp, PDR_parms)*x[1]-mu(temp, mu_parms,timestep)*x[2];

    dxdt[3] = -a(temp, a_parms)*b(temp, b_parms)*(x[2]/(x[3] + x[4] + x[5] + x[6]))*x[3];

    dxdt[4] = a(temp, a_parms)*b(temp, b_parms)*(x[2]/(x[3] + x[4] + x[5] + x[6]))*x[3]-(1.0/5.9)*x[4];

    dxdt[5] = (1.0/5.9)*x[4]-(1.0/5.0)*x[5];

    dxdt[6] = (1.0/5.0)*x[5];
  }
};

// This is a struct for writing output to a text file
struct stream_writer{
  std::ostream& m_out;

  stream_writer(std::ostream& out) : m_out(out) {}
  void operator()(const state_type &x, const double t){
    m_out<<t<<';'<<x[3]<<';'<<x[4]<<';'<<x[5]<<';'<<x[6]<<'\n';
  }
};

// struct for computing necessary statistics
struct compute_metrics{
  double& max_infected;
  double& epidemic_length;
  double& final_epidemicsize;

  compute_metrics(double& max_inf, double& epi_length, double& final_size): max_infected(max_inf), epidemic_length(epi_length),
  final_epidemicsize(final_size){}
  void operator()(const state_type &x, const double t){
    if(x[5] > max_infected)
    {
      max_infected = x[5];
    }
    if(x[5] > 1.0)
    {
      epidemic_length = t;
    }
    final_epidemicsize = x[6];
  }
};

void output_display(const state_type &x, const double t){
  // if(x[0] + x[1] + x[2] == 0){
  //   cout << x[6] << '\n';
  // }
  cout << x[0] << " " << x[1] << " " << x[2] << " " << x[3] << " " << x[4] << " " << x[5] << " " << x[6] << std::endl;
}

int main(int argc, char* argv[]){

  vector<vector<double> > a_uncertainty(50, vector<double>(3));
  vector<vector<double> > b_uncertainty(50, vector<double>(3));
  vector<vector<double> > pMI_uncertainty(50, vector<double>(3));
  vector<vector<double> > pEA_uncertainty(50, vector<double>(3));
  vector<vector<double> > EFD_uncertainty(50, vector<double>(3));
  vector<vector<double> > MDR_uncertainty(50, vector<double>(3));
  vector<vector<double> > PDR_uncertainty(50, vector<double>(3));
  vector<vector<double> > mu_uncertainty(50, vector<double>(3));

  std::fstream uncertainty_reader;
  uncertainty_reader.open("./data/a_uncertainty.txt");
  for(int ii = 0; ii < 50; ii++)
  {
    uncertainty_reader >> a_uncertainty[ii][0] >> a_uncertainty[ii][1] >> a_uncertainty[ii][2];
  }
  uncertainty_reader.close();

  uncertainty_reader.open("./data/b_uncertainty.txt");
  for(int ii = 0; ii < 50; ii++)
  {
    uncertainty_reader >> b_uncertainty[ii][0] >> b_uncertainty[ii][1] >> b_uncertainty[ii][2];
  }
  uncertainty_reader.close();

  uncertainty_reader.open("./data/c_uncertainty.txt");
  for(int ii = 0; ii < 50; ii++)
  {
    uncertainty_reader >> pMI_uncertainty[ii][0] >> pMI_uncertainty[ii][1] >> pMI_uncertainty[ii][2];
  }
  uncertainty_reader.close();

  uncertainty_reader.open("./data/e2a_uncertainty.txt");
  for(int ii = 0; ii < 50; ii++)
  {
    uncertainty_reader >> pEA_uncertainty[ii][0] >> pEA_uncertainty[ii][1] >> pEA_uncertainty[ii][2];
  }
  uncertainty_reader.close();

  uncertainty_reader.open("./data/EFD_uncertainty.txt");
  for(int ii = 0; ii < 50; ii++)
  {
    uncertainty_reader >> EFD_uncertainty[ii][0] >> EFD_uncertainty[ii][1] >> EFD_uncertainty[ii][2];
  }
  uncertainty_reader.close();

  uncertainty_reader.open("./data/MDR_uncertainty.txt");
  for(int ii = 0; ii < 50; ii++)
  {
    uncertainty_reader >> MDR_uncertainty[ii][0] >> MDR_uncertainty[ii][1] >> MDR_uncertainty[ii][2];
  }
  uncertainty_reader.close();

  uncertainty_reader.open("./data/PDR_uncertainty.txt");
  for(int ii = 0; ii < 50; ii++)
  {
    uncertainty_reader >> PDR_uncertainty[ii][0] >> PDR_uncertainty[ii][1] >> PDR_uncertainty[ii][2];
  }
  uncertainty_reader.close();

  uncertainty_reader.open("./data/mu_uncertainty.txt");
  for(int ii = 0; ii < 50; ii++)
  {
    uncertainty_reader >> mu_uncertainty[ii][0] >> mu_uncertainty[ii][1] >> mu_uncertainty[ii][2];
  }
  uncertainty_reader.close();

  runge_kutta4< state_type > stepper;
  string filepath = "./output/Range1040/output_";
  std::ostringstream strs;
  // int index = atoi(argv[1]) - 1;
  // string filename = filepath + std::to_string(index) + ".txt";
  // ofstream fout(filename);

  int temperature_range = 301;

  for(int ii = 0; ii < temperature_range; ii++){
    double start_temp = 10.0 + 0.1*ii;
    strs << start_temp;
    string file_starttemp = strs.str();
    strs.str("");
    string filename = filepath + file_starttemp + ".txt";
    ofstream fout(filename);
    double timestep = 0.01;
    double M_initial = carrying_capacity(start_temp,29.0,0.05,20000,timestep);
    state_type x = {0.985*M_initial,0.0,0.015*M_initial,9999.0,0.0,1.0,0.0};
    // double final_epidemicsize = 0.0;
    // double epidemic_length = 0.0;
    // double max_infected = 0.0;
    integrate_const(stepper, sirmodel(start_temp, timestep),  x, 0.00, 365.00, 0.01,stream_writer(fout));

    //integrate_const(stepper, sirmodel(start_temp),  x, 0.00, 365.00, 0.01,compute_metrics(max_infected, epidemic_length, final_epidemicsize));

    // integrate_const(stepper,  sirmodel_uncertainty(start_temp, EFD_uncertainty[index], pEA_uncertainty[index],
    //   MDR_uncertainty[index], a_uncertainty[index], pMI_uncertainty[index],
    //   mu_uncertainty[index], PDR_uncertainty[index], b_uncertainty[index],timestep),
    // x, 0.0, 365.0, timestep, compute_metrics(max_infected, epidemic_length, final_epidemicsize));
    // fout << final_epidemicsize << " " << max_infected << " " << epidemic_length << std::endl;
    fout.close();
  }
  //fout.close();

  // ofstream fout("test.txt");
  // double M_initial = carrying_capacity(20.0,29.0,0.05,20000);
  // state_type x = {0.985*M_initial,0.0,0.015*M_initial,9999.0,0.0,1.0,0.0};
  // //state_type x = {0.98*M_initial,0.0,0.02*M_initial,9944.0,0.0,56.0,0.0};
  //
  // integrate_const(stepper, sirmodel(20.0),  x, 0.00, 365.00, 0.01,stream_writer(fout));
  //
  // fout.close();
  return 0;
}

// This is the general function for the Briere fit.
// For more documentation, see temperaturesensitivefunctions.hpp
// This is the general function for the Briere fit.
// For more documentation, see temperaturesensitivefunctions.hpp
double briere(double x, double c, double T0, double Tm){
  if((x < T0) || (x > Tm)){
    return 0.0;
  }
  else{
    return c*x*(x-T0)*sqrt(Tm-x);
  }
}

// This is the general function for the quadratic fit.
// For more documentation, see temperaturesensitivefunctions.hpp
double quadratic(double x, double c, double T0, double Tm){
  if((x < T0) || (x > Tm)){
    return 0.0;
  }
  else{
    return c*(x-T0)*(x-Tm);
  }
}

// This is the general function for the inverted quadratic fit.
// For more documentation, see temperaturesensitivefunctions.hpp
double inverted_quadratic(double x, double c, double T0, double Tm, double timestep){
  if((x < T0) || (x > Tm)){
    return 1.0/timestep;
  }
  else{
    return 1.0/(c*(x-T0)*(x-Tm));
  }
}

// These are the temperature-senstive entomological parameters for the
// Ae. aegypti vector. Further documentation regarding each function is found in
// the temperaturesensitivefunctions.hpp file
double a(double temp){
  return briere(temp,2.02e-04,13.35,40.08);
}

double a(double temp, std::vector<double> parms)
{
  return briere(temp, parms[2], parms[0], parms[1]);
}

double b(double temp){
  return briere(temp,8.49e-04,17.05,35.83);
}

double b(double temp, std::vector<double> parms)
{
  return briere(temp, parms[2], parms[0], parms[1]);
}

double pMI(double temp){
  return briere(temp,4.91e-04,12.22,37.46);
}

double pMI(double temp, std::vector<double> parms)
{
  return briere(temp, parms[2], parms[0], parms[1]);
}

double EFD(double temp){
  return briere(temp,8.56e-03,14.58,34.61);
}

double EFD(double temp, std::vector<double> parms)
{
  return briere(temp, parms[2], parms[0], parms[1]);
}

double pEA(double temp){
  return quadratic(temp,-5.99e-03,13.56,38.29);
}

double pEA(double temp, std::vector<double> parms)
{
  return quadratic(temp, parms[2], parms[0], parms[1]);
}

double MDR(double temp){
  return briere(temp,7.86e-05,11.36,39.17);
}

double MDR(double temp, std::vector<double> parms)
{
  return briere(temp, parms[2], parms[0], parms[1]);
}

double mu(double temp, double timestep){
  return inverted_quadratic(temp,-1.48e-01,9.16,37.73,timestep);
}

double mu(double temp, std::vector<double> parms, double timestep)
{
  return inverted_quadratic(temp, parms[2], parms[0], parms[1], timestep);
}


double PDR(double temp){
  return briere(temp,6.65e-05,10.68,45.90);
}

double PDR(double temp, std::vector<double> parms)
{
  return briere(temp, parms[2], parms[0], parms[1]);
}

double carrying_capacity(double temp, double T0, double EA, double N, double timestep){
  double kappa = 8.617e-05;

  double alpha = (EFD(T0)*pEA(T0)*MDR(T0)*(1.0/mu(T0,timestep))-mu(T0,timestep))/(EFD(T0)*pEA(T0)*MDR(T0)*(1.0/mu(T0,timestep)));

  return (alpha*N*exp(-EA*(pow((temp-T0),2))/(kappa*(temp+273.0)*(T0+273.0))));
}

double carrying_capacity(double temp, double T0, double EA, double N,
  std::vector<double> EFD_parms, std::vector<double> pEA_parms, std::vector<double> MDR_parms, std::vector<double> mu_parms, double timestep)
{
  double kappa = 8.617e-05;

  double alpha = (EFD(T0, EFD_parms)*pEA(T0, pEA_parms)*MDR(T0, MDR_parms)*(1.0/mu(T0, mu_parms, timestep))-mu(T0, mu_parms,timestep))/(EFD(T0, EFD_parms)*pEA(T0, pEA_parms)*MDR(T0, MDR_parms)*(1.0/mu(T0, mu_parms, timestep)));

  return (alpha*N*exp(-EA*(pow((temp-T0),2))/(kappa*(temp+273.0)*(T0+273.0))));
}
