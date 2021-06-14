public class CircuitComponent{
  int centerX,centerY;
  Segment location;
  boolean info;
  
  
  public CircuitComponent(int CX, int CY, Segment seg){
    centerX = CX;
    centerY = CY;
    location = seg;
    info = false;
  }
  
  public Segment getSeg(){
    return location;
  }
  
  public void display(){
  }
}
