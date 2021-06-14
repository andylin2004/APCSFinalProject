class Equation {
  List<Float> coefficients;
  List<String> variables;  
  Float sum; 
  
  public Equation(Float Sum){
    coefficients = new ArrayList<Float>();
    variables = new ArrayList<String>();
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
  
  public void addSum(Float num){
    sum+=num;
  }
}
