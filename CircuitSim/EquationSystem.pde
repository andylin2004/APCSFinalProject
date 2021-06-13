class EquationSystem {
  
  List<Equation> equations;    // (add, remove)
  Map<String,Integer> mapping;
  
  public EquationSystem();
  
  private void setMapping() {
    for (int i = 0; i < equations.size(); i ++){
      for (int j = 0; j < equations.get(i).getVariables().length; j++){
        if (mapping.get(equations.get(i).getVariables()[j])!=null){
          mapping.put(equations.get(i).getVariables()[j], mapping.size());
        }
      }
    }
  }

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
