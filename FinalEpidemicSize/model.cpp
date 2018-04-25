//******************************************************************************
// Name                 : model.cpp
// Author               : John Huber
// Copyright            : CRAPL
// Description          : This is the implementation of the time/temperature-
//                      : sensitive SEI-SEIR model for disease transmission.
//                      : In this model, temperature is modeled as a sinusoidal
//                      : curve with varying mean temperature and amplitude.
//******************************************************************************

// preprocessor directives
#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <ctime>
#include <fstream>
#include <iostream>
#include <sstream>
#include <stdio.h>
#include <string>
#include <time.h>
#include <vector>

#include <boost/array.hpp>
#include <boost/numeric/odeint.hpp>
#include <boost/numeric/ublas/io.hpp>
#include <boost/numeric/ublas/vector.hpp>
#include <boost/numeric/ublas/matrix.hpp>

#include "temperaturesensitivefunctions.hpp"

// declare the appropriate namespaces
using namespace std;
using namespace boost::numeric::odeint;

// establish typedef
typedef boost::array<double,7> state_type;
typedef runge_kutta_cash_karp54< state_type > error_stepper_type;
typedef controlled_runge_kutta< error_stepper_type > controlled_stepper_type;
//typedef boost::numeric::ublas::vector< double > state_type;

// establish the necessary constants
const double pi = boost::math::constants::pi<double>();

// function to compute the temperature
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


// This is a struct for the implementation of the SEI-SEIR model.
// Parameter values are defined as follows:
// x[0] = M1; x[1] = M2; x[2] = M3; x[3] = S; x[4] = E; x[5] = I; x[6] = R;
// dxdt[0] = dM1; dxdt[1] = dM2; dxdt[2] = dM3; dxdt[3] = dS; dxdt[4] = dE;
// dxdt[5] = dI; dxdt[6] = dR;
// For more documentation, please see Huber et al
struct sirmodel
{
  vector<double> parameters;
  double timestep;

  sirmodel(vector<double> parameters, double timestep) : parameters(parameters), timestep(timestep){}

  void operator()( state_type &x , state_type &dxdt , double t) const
  {
    // Compute temperature and carrying capacity
    double temp = parameters[0]*sin((2.0*pi/365.0)*(t))+parameters[1];
    double K = carrying_capacity(temp,29.0,0.05,20000, timestep);

    // if any compartment is less than 1e-20 then set to zero. This is to ensure no numerical errors arise.
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

    // system of ODE's
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

struct sirmodel_starttemp
{
  vector<double> parameters;
  double start_temp;
  double timestep;

  sirmodel_starttemp(vector<double> parameters, double start_temp, double timestep) : parameters(parameters), start_temp(start_temp), timestep(timestep) {}

  void operator()( state_type &x , state_type &dxdt , double t ) const
  {
    double temp = temperature_curve(t,start_temp,2*pi/365,parameters[0],parameters[1]);
    double K = carrying_capacity(temp,29.0,0.05,20000,timestep);

    // if any compartment is less than 1e-20 then set to zero. This is to ensure no numerical errors arise.
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

    // system of ODEs
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
  vector<double> parameters;
  vector<double> EFD_parms;
  vector<double> pEA_parms;
  vector<double> MDR_parms;
  vector<double> a_parms;
  vector<double> pMI_parms;
  vector<double> mu_parms;
  vector<double> PDR_parms;
  vector<double> b_parms;
  double timestep;

  sirmodel_uncertainty(vector<double> parameters, vector<double> EFD_parms, vector<double> pEA_parms,
  vector<double> MDR_parms, vector<double> a_parms, vector<double> pMI_parms,
  vector<double> mu_parms, vector<double> PDR_parms, vector<double> b_parms, double timestep): parameters(parameters),
  EFD_parms(EFD_parms), pEA_parms(pEA_parms), MDR_parms(MDR_parms), a_parms(a_parms), pMI_parms(pMI_parms),
  mu_parms(mu_parms), PDR_parms(PDR_parms), b_parms(b_parms), timestep(timestep) {}

  void operator()( state_type &x , state_type &dxdt , double t ) const
  {
    double temp = parameters[0]*sin((2.0*pi/365.0)*(t))+parameters[1];
    double K = carrying_capacity(temp,29.0,0.05,20000, EFD_parms, pEA_parms, MDR_parms, mu_parms, timestep);

    // if any compartment is less than 1e-20 then set to zero. This is to ensure no numerical errors arise.
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

    // system of ODEs
    dxdt[0] = (EFD(temp, EFD_parms)*pEA(temp, pEA_parms)*MDR(temp, MDR_parms)*(1.0/mu(temp, mu_parms,timestep)))*(x[0]+x[1]+x[2])*(1-((x[0]+x[1]+x[2])/K))-
    (a(temp, a_parms)*pMI(temp, pMI_parms)*x[5]/(x[3]+x[4]+x[5]+x[6])+mu(temp, mu_parms,timestep))*x[0];

    dxdt[1] = (a(temp, a_parms)*pMI(temp, pMI_parms)*x[5]/(x[3]+x[4]+x[5]+x[6]))*x[0]-(PDR(temp, PDR_parms)+mu(temp, mu_parms,timestep))*x[1];

    dxdt[2] = PDR(temp, PDR_parms)*x[1]-mu(temp, mu_parms, timestep)*x[2];

    dxdt[3] = -a(temp, a_parms)*b(temp, b_parms)*(x[2]/(x[3] + x[4] + x[5] + x[6]))*x[3];

    dxdt[4] = a(temp, a_parms)*b(temp, b_parms)*(x[2]/(x[3] + x[4] + x[5] + x[6]))*x[3]-(1.0/5.9)*x[4];

    dxdt[5] = (1.0/5.9)*x[4]-(1.0/5.0)*x[5];

    dxdt[6] = (1.0/5.0)*x[5];
  }
};

// This is a struct for writing output to a text file.
struct stream_writer{
  std::ostream& m_out;
  stream_writer( std::ostream& out) : m_out( out ) {}
  void operator()( const state_type &x, const double t ){
    if(fabs(t-364.99)<1e-3){
      m_out<<x[6]<< " ";
    }
  }
};

struct stream_writer_trajectory{
  std::ostream& m_out;
  stream_writer_trajectory( std::ostream& out) : m_out( out) {}
  void operator()( const state_type &x, const double t ){
    m_out << t << " " << x[0] << " " << x[1] << " " << x[2] << " " << x[3] << " " << x[4] << " " << x[5] << " " << x[6] << '\n';
  }
};

// This is a function for writing output to the terminal.
void output_display(const state_type &x, const double t){
  cout << t << " " << x[0] << " " << x[1] << " " << x[2] << " " << x[3] << " " << x[4] << " " << x[5] << " " << x[6] << '\n';
}

int main(int argc, char*argv[]){

  vector<double> parms(2);
  vector<double> oscillation_temps(401);
  vector<double> amplitude(201);
  double start_oscillation;
  double start_amplitude;

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

  for(int ii = 0; ii < oscillation_temps.size(); ii++){
    start_oscillation = 0.0 + ii*0.1;
    oscillation_temps[ii] = start_oscillation;
  }

  for(int ii = 0; ii < amplitude.size(); ii++){
    start_amplitude = 0.0 + ii*0.1;
    amplitude[ii] = start_amplitude;
  }

  runge_kutta4< state_type > stepper;

  // RUN THIS TO GENERATE FINAL EPIDEMIC SIZE ASSUMING MEAN PARAMETERIZATION
  // MATCH INITIAL CONDITIONS AND CARRYING CAPACITY TO REFLECT STARTING TEMPERATURE
  // int index = atoi(argv[1]) - 1;
  // parms[1] = oscillation_temps[index];
  // string path = "output/uncertainty/output_";
  // std::ostringstream strs;
  // strs << oscillation_temps[index];
  // string file_oscillationtemp =  strs.str();
  // strs.str("");
  // string filename = path + file_oscillationtemp + ".txt";
  // ofstream fout (filename);

  //
  // for(int ii = 0; ii < amplitude.size(); ii++){
  //   //std::cout << ii << std::endl;
  //   double timestep = 0.01;
  //   parms[0] = amplitude[ii];
  //   double M_initial = carrying_capacity(parms[1],29.0,0.05,20000, timestep);
  //   state_type x = {0.985*M_initial,0.0,0.015*M_initial,1999.0,0.0,1.0,8000.0};
  //   integrate_const(stepper, sirmodel_starttemp(parms, parms[1], timestep), x, 0.00, 365.00, timestep,stream_writer( fout ));
  // }

  // RUN THIS TO GENERATE CONSTANT TRAJECTORIES UNDER CONSTANT TEMPERATURE
  // int index = atoi(argv[1]) - 1;
  // string path = "output/constant_temp/output_";
  // std::ostringstream strs;
  // strs << index;
  // string file_index = strs.str();
  // strs.str("");
  // string filename = path + file_index + ".txt";
  // ofstream fout (filename);
  // double timestep = 0.01;
  // parms[1] = oscillation_temps[index];
  // double M_initial = carrying_capacity(parms[1],29.0,0.05,20000,timestep);
  // std::cout << M_initial << std::endl;
  // state_type x = {0.985*M_initial,0.0,0.015*M_initial,9999.0,0.0,1.0,0.0};
  // parms[0] = 0;
  // std::cout << parms[1] << std::endl;
  // integrate_const(stepper, sirmodel(parms, timestep), x, 0.00, 365.00, timestep,stream_writer_trajectory( fout ));

  // RUN THIS TO GENERATE THE UNCERTAINTY IN THE FINAL EPIDEMIC SIZE
  // for(int ii = 0; ii < oscillation_temps.size(); ii++)
  // {
  //   for(int jj = 0; jj < amplitude.size(); jj++)
  //   {
  //     std::cout << jj << std::endl;
  //     double timestep = 0.01;
  //     double M_initial = carrying_capacity(oscillation_temps[ii], 29.0, 0.05, 20000, EFD_uncertainty[index], pEA_uncertainty[index],
  //     MDR_uncertainty[index], mu_uncertainty[index], timestep);
  //     parms[0] = amplitude[jj];
  //     parms[1] = oscillation_temps[ii];
  //     state_type x = {0.985 * M_initial, 0.0, 0.015 * M_initial, 9999.0, 0.0, 1.0, 0.0};
  //     integrate_const(stepper,  sirmodel_uncertainty(parms, EFD_uncertainty[index], pEA_uncertainty[index],
  //       MDR_uncertainty[index], a_uncertainty[index], pMI_uncertainty[index],
  //       mu_uncertainty[index], PDR_uncertainty[index], b_uncertainty[index], timestep),
  //     x, 0.0, 365.0, 0.01, stream_writer ( fout ));
  //   }
  //   fout << '\n';
  // }

  fout.close();
  return 0;
}

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
  return inverted_quadratic(temp,-1.48e-01,9.16,37.73, timestep);
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

  double alpha = (EFD(T0)*pEA(T0)*MDR(T0)*(1.0/mu(T0, timestep))-mu(T0, timestep))/(EFD(T0)*pEA(T0)*MDR(T0)*(1.0/mu(T0, timestep)));

  return (alpha*N*exp(-EA*(pow((temp-T0),2))/(kappa*(temp+273.0)*(T0+273.0))));
}

double carrying_capacity(double temp, double T0, double EA, double N,
  std::vector<double> EFD_parms, std::vector<double> pEA_parms, std::vector<double> MDR_parms, std::vector<double> mu_parms, double timestep)
{
  double kappa = 8.617e-05;

  double alpha = (EFD(T0, EFD_parms)*pEA(T0, pEA_parms)*MDR(T0, MDR_parms)*(1.0/mu(T0,mu_parms, timestep))-mu(T0, mu_parms, timestep))/(EFD(T0, EFD_parms)*pEA(T0, pEA_parms)*MDR(T0, MDR_parms)*(1.0/mu(T0, mu_parms, timestep)));

  return (alpha*N*exp(-EA*(pow((temp-T0),2))/(kappa*(temp+273.0)*(T0+273.0))));
}
