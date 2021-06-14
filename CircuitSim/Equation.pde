class Equation {
  List<Float> coefficients;
  List<String> variables;  
  float sum; 
  
  public Equation(Float[] Coefficients, String[] Variables, Float Sum){
    coefficients = Arrays.asList(Coefficients);
    variables = Arrays.asList(Variables);
    sum = Sum;
  }
  
  public Float[] getCoefficients(){
    return coefficients.toArray(new Float[0]);
  }
  
  public String[] getVariables(){
    return variables.toArray(new String[0]);
  }
  
  public Float getSum(){
    return sum;
  }
  
  public void addTerm(Float coefficient, String variable){
    coefficients.add(coefficient);
    variables.add(variable);
  }
}
