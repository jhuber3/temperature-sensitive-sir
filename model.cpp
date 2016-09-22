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
//typedef boost::numeric::ublas::vector< double > vector_type;
//typedef boost::numeric::ublas::matrix< double > matrix_type;

// establish the necessary constants
const double pi = boost::math::constants::pi<double>();

// This is a struct for the implementation of the SEI-SEIR model.
// Parameter values are defined as follows:
// x[0] = M1; x[1] = M2; x[2] = M3; x[3] = S; x[4] = E; x[5] = I; x[6] = R;
// dxdt[0] = dM1; dxdt[1] = dM2; dxdt[2] = dM3; dxdt[3] = dS; dxdt[4] = dE;
// dxdt[5] = dI; dxdt[6] = dR;
// For more documentation, please see Huber et al
struct sirmodel
{
  vector<double> parameters;

  sirmodel(vector<double> parameters) : parameters(parameters) {}

  void operator()( state_type const &x , state_type &dxdt , double t ) const
  {
    double temp = parameters[0]*sin((2.0*pi/365.0)*(t))+parameters[1];
    double K = carrying_capacity(temp,29.0,0.05,20000);

    dxdt[0] = (EFD(temp)*pEA(temp)*MDR(temp))*(x[0]+x[1]+x[2])*(1-((x[0]+x[1]+x[2])/K))-
    (a(temp)*pMI(temp)*x[5]/(x[3]+x[4]+x[5]+x[6])+mu(temp))*x[0];

    dxdt[1] = (a(temp)*pMI(temp)*x[5]/(x[3]+x[4]+x[5]+x[6]))*x[0]-(PDR(temp)+mu(temp))*x[1];

    dxdt[2] = PDR(temp)*x[1]-mu(temp)*x[2];

    dxdt[3] = -a(temp)*b(temp)*(x[2]/(x[0]+x[1]+x[2]+0.001))*x[3];

    dxdt[4] = a(temp)*b(temp)*(x[2]/(x[0]+x[1]+x[2]+0.001))*x[3]-(1.0/5.9)*x[4];

    dxdt[5] = (1.0/5.9)*x[4]-(1.0/5.0)*x[5];

    dxdt[6] = (1.0/5.0)*x[5];
  }
};

struct sirmodel_test
{
  vector<double> parameters;

  sirmodel_test(vector<double> parameters) : parameters(parameters) {}

  void operator()( state_type const &x , state_type &dxdt , double t ) const
  {
    double temp = parameters[0]*sin((2.0*pi/365.0)*(t))+parameters[1];
    double K = carrying_capacity(temp,29.0,0.05,20000);

    dxdt[0] = (EFD(temp)*pEA(temp)*MDR(temp))*(x[0]+x[1]+x[2])*(1-((x[0]+x[1]+x[2])/K))-
    (a(temp)*pMI(temp)*x[5]/(x[3]+x[4]+x[5]+x[6])+mu(temp))*x[0];

    dxdt[1] = (a(temp)*pMI(temp)*x[5]/(x[3]+x[4]+x[5]+x[6]))*x[0]-(PDR(temp)+mu(temp))*x[1];

    dxdt[2] = PDR(temp)*x[1]-mu(temp)*x[2];

    dxdt[3] = -a(temp)*b(temp)*(x[2]/(x[0]+x[1]+x[2]))*x[3];

    dxdt[4] = a(temp)*b(temp)*(x[2]/(x[0]+x[1]+x[2]))*x[3]-(1.0/6)*x[4];

    dxdt[5] = (1.0/6.0)*x[4]-(1.0/6.0)*x[5];

    dxdt[6] = (1.0/6.0)*x[5];
  }
};

// This is a struct for writing output to a text file.
struct stream_writer{
  std::ostream& m_out;
  stream_writer( std::ostream& out) : m_out( out ) {}
  void operator()( const state_type &x, const double t ){
    if(fabs(t-364.99)<1e-3){
      m_out<<x[6]<<'\n';
    }
  }
};

// This is a function for writing output to the terminal.
void output_display(const state_type &x, const double t){
  cout << t << x[0] << x[1] << x[2] << x[3] << x[4] << x[5] << x[6] << '\n';
  //if(x[6] != x[6]){
  //  cout << temporary_output << '\n';

  //}
  //else{
  //  temporary_output = x[6];
  //}
}

void output_display_all(const state_type &x, const double t){
  cout << x[6] << '\n';
}
int main(int argc, char*argv[]){

  vector<double> parms(2);
  vector<double> oscillation_temps(401);
  vector<double> amplitude(301);
  double start_oscillation;
  double start_amplitude;

  for(int ii = 0; ii < oscillation_temps.size(); ii++){
    start_oscillation = 0.0 + ii*0.1;
    oscillation_temps[ii] = start_oscillation;
  }

  for(int ii = 0; ii < amplitude.size(); ii++){
    start_amplitude = 0.0 + ii*0.1;
    amplitude[ii] = start_amplitude;
  }

  //typedef rosenbrock4< double > stepper_type;
  //typedef rosenbrock4_controller< stepper_type > controlled_stepper_type;
  //typedef rosenbrock4_dense_output< controlled_stepper_type > dense_output_type;
  runge_kutta4< state_type > stepper;

  int index = atoi(argv[1]) - 1;
  parms[1] = oscillation_temps[index];
  string path = "./output//output_";
  std::ostringstream strs;
  strs << oscillation_temps[index];
  string file_oscillationtemp =  strs.str();
  strs.str("");
  string filename = path + file_oscillationtemp + ".txt";
  ofstream fout (filename);

  for(int ii = 0; ii < amplitude.size(); ii++){
    double M_initial = carrying_capacity(parms[1],29.0,0.05,20000);
    state_type x = {0.985*M_initial,0.0,0.015*M_initial,9975.0,0.0,25.0,0.0};
    parms[0] = amplitude[ii];

    /*double t = 0.0;
    const double dt = 0.01;
    for(size_t ii = 0; ii < 36500; ++ii){
      t+=dt;
      stepper.do_step(sirmodel(parms),x,t,dt);
      if(ii == 36499){
        cout << x[6] << endl;
      }
    }*/
    //integrate_const(make_dense_output< rosenbrock4< double > >( 1.0e-6 , 1.0e-6 ) ,
            //make_pair(sirmodel(parms),sir_jacobian(parms)),x,0.00,100.0,0.01,output_display);
    integrate_const(stepper, sirmodel(parms), x, 0.00, 365.00, 0.01,stream_writer( fout ));
  }

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
double inverted_quadratic(double x, double c, double T0, double Tm){
  if((x < T0) || (x > Tm)){
    return 24.0;
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

double b(double temp){
  return briere(temp,8.49e-04,17.05,35.83);
}

double pMI(double temp){
  return briere(temp,4.91e-04,12.22,37.46);
}

double EFD(double temp){
  return briere(temp,8.56e-03,14.58,34.61);
}

double pEA(double temp){
  return quadratic(temp,-5.99e-03,13.56,38.29);
}

double MDR(double temp){
  return briere(temp,7.86e-05,11.36,39.17);
}

double mu(double temp){
  return inverted_quadratic(temp,-1.48e-01,9.16,37.73);
}

double PDR(double temp){
  return briere(temp,6.56e-05,10.68,45.90);
}

double carrying_capacity(double temp, double T0, double EA, double N){
  double kappa = 8.617e-05;

  double alpha = (EFD(T0)*pEA(T0)*MDR(T0)-mu(T0))/(EFD(T0)*pEA(T0)*MDR(T0));

  return (alpha*N*exp(-EA*(pow((temp-T0),2))/(kappa*(temp+273.0)*(T0+273.0))));
}
