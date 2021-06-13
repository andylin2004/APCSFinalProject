class Equation {
  float[] coefficients;
  String[] variables;  
  double sum; 
  
  public Equation(float[] Coefficients, String[] Variables, double Sum){
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
}
