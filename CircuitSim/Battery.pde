public class Battery extends CircuitComponent{
  int voltage;
  
  public Battery(int CX, int CY, Segment seg, int volt){
    super(CX, CY, seg);
    voltage = volt;
  }
  
  public void display(){
    rectMode(CENTER);
    fill(0);
    rect(centerX,centerY, 20, 20);
  }
  
  public int getVoltage(){
    return voltage;
  }
}
