class Equation {
  float[] coefficients;
  String[] variables;  
  float sum; 
  
  public Equation(float[] Coefficients, String[] Variables, float Sum){
    coefficients = Coefficients;
    variables = Variables;
    sum = Sum;
  }
  
  public float[] getCoefficients(){
    return coefficients;
  }
  
  public String[] getVariables(){
    return variables;
  }
  
  public float getSum(){
    return sum;
  }
}
