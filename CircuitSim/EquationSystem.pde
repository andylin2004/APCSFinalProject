class EquationSystem {
  
  List<Equation> equations;    // (add, remove)
  Map<String,Integer> mapping;
  
  public EquationSystem(){
    mapping = new HashMap<String,Integer>();
    equations = new ArrayList<Equation>();
  }
  
  private void setMapping() {
    for (int i = 0; i < equations.size(); i ++){
      Equation equation = equations.get(i);
      String[] variables = equation.getVariables();
      for (int j = 0; j < variables.length; j++){
        String variable = variables[j];
        if (!mapping.containsKey(variable)){
          mapping.put(variables[j], mapping.size());
        }
      }
    }
  }
  
  public void addEquation(Equation eq){
    equations.add(eq);
  }

  public Map<String,Integer> getMapping(){
    return mapping;
  }
  
  public float[] solve() {
    mapping.clear();
    setMapping();
    int nEquations = equations.size();
    int nVariables = mapping.size();
    double[][] coefficients = new double[nEquations][nVariables];
    double[][] sums = new double[nEquations][1];
  
    for (int i = 0; i < nEquations; i++){
      Equation equation = equations.get(i);
      String[] variables = equation.getVariables();
      Float[] c = equation.getCoefficients();
      for (int j = 0; j < variables.length; j++){
        coefficients[i][mapping.get(variables[j])] = c[j];
      }
      sums[i][0] = equations.get(i).getSum();
    }
    
    DMatrixRMaj A = new DMatrixRMaj(coefficients);
    DMatrixRMaj B = new DMatrixRMaj(sums);
    DMatrixRMaj X = new DMatrixRMaj(nVariables, 1);
    
    if( !CommonOps_DDRM.solve(A,B,X) )
      return null;
    
    float[] oneD = new float[nVariables];
    for (int i = 0; i < nVariables; i++){
      oneD[i]=(float)X.get(i, 0);
    }
    return oneD;
  }
  
}
