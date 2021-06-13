class EquationSystem {
  
  List<Equation> equations;    // (add, remove)
  Map<String,Integer> mapping;
  
  public EquationSystem(){
    mapping = new HashMap<String,Integer>();
    equations = new ArrayList<Equation>();
  }
  
  private void setMapping() {
    for (int i = 0; i < equations.size(); i ++){
      for (int j = 0; j < equations.get(i).getVariables().length; j++){
        if (mapping.get(equations.get(i).getVariables()[j])!=null){
          mapping.put(equations.get(i).getVariables()[j], mapping.size());
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
    float[][] coefficients = new float[nEquations][nVariables];
    float[][] sums = new float[nVariables][1];
    
    for (int i = 0; i < equations.size(); i++){
      for (int j = 0; j < equations.get(i).getVariables().length; j++){
        coefficients[i][mapping.get(equations.get(i).getVariables()[j])] = equations.get(i).getCoefficients()[j];
        sums[i][0] = equations.get(i).getSum();
      }
    }
    
    float[][] inverse = Matrix.inverse(coefficients);
    float[][] solutions = Matrix.Multiply(inverse, sums);
    float[] oneD = new float[nVariables];
    for (int i = 0; i < solutions.length; i++){
      oneD[i]=solutions[i][0];
    }
    return oneD;
  }
  
}
