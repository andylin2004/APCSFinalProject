public class Resistor extends CircuitComponent{
  int resistance;
  
  public Resistor(int CX, int CY, Segment seg, int res){
    super(CX, CY, seg);
    resistance = res;
  }
  
  public void display(){
    rectMode(CENTER);
    fill(255);
    rect(centerX, centerY, 20, 40);
  }
}
