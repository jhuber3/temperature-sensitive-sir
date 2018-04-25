// function declarations

double briere(double x, double c, double T0, double Tm);

double quadratic(double x, double c, double T0, double Tm);

double inverted_quadratic(double x, double c, double T0, double Tm, double timestep);

double a(double temp);
double a(double temp, std::vector<double> parms);

double b(double temp);
double b(double temp, std::vector<double> parms);

double pMI(double temp);
double pMI(double temp, std::vector<double> parms);

double EFD(double temp);
double EFD(double temp, std::vector<double> parms);

double pEA(double temp);
double pEA(double temp, std::vector<double> parms);

double MDR(double temp);
double MDR(double temp, std::vector<double> parms);

double mu(double temp, double timestep);
double mu(double temp, std::vector<double> parms, double timestep);

double PDR(double temp);
double PDR(double temp, std::vector<double> parms);

double carrying_capacity(double temp, double T0, double EA, double N, double timestep);
double carrying_capacity(double temp, double T0, double EA, double N,
  std::vector<double> EFD_parms, std::vector<double> pEA_parms, std::vector<double> MDR_parms, std::vector<double> mu_parms, double timestep);
