public class CircuitComponent{
 
  float X1;
  float Y1;
  float X2;
  float Y2;
  float power;
  float voltage;
  float current;
  ArrayList<Object> nextConnection;
  ArrayList<Object> previousConnection;
  
  public CircuitComponent(x1, y1, x2, y2, p, v, c){
    X1 = x1; Y1 = y1; X2 = x2; Y2 = y2; power = p; voltage = v; current = c;
  }
  
  public void setXlocationNode1(float num){
    XLocationNode1 = num;
  }
  
  

  
  
}
