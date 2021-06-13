class EquationSystem {
  
  List<Equation> equations;    // (add, remove)
  Map<String,Integer> mapping;
  
  public EquationSystem();
  /*
  private void setMapping() {
    for each equation:
      for each variable:
        if variable not in mapping:
          mapping.put(variable, mapping.size());
  }
  */
  public Map<String,Integer> getMapping(){
    return mapping;
  }
  /*
  public double[] solve() {
    mapping.clear();
    setMapping();
    int nEquations = equations.size();
    int nVariables = mapping.size();
    double[][] coefficients = new double[nEquations][nVariables];
    double[][] sums = new double[nVariables][1];
    
    for each equation (index i through equations):
      for each term (index j through coefficients & variables):
        coefficients[i][mapping.get(variables[j])] = coefficients[j];
      sums[i][0] = equation.sum;
    
    double[][] inverse = Matrix.inverse(coefficients);
    double[] solutions = Matrix.multiply(inverse, sums);
    return solutions;
  }
  */
  
}
