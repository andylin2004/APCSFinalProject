public class CircuitComponent{
  int centerX,centerY;
  Segment location;
  
  
  public CircuitComponent(int CX, int CY, Segment seg){
    centerX = CX;
    centerY = CY;
    location = seg;
  }
  
  public Segment getSeg(){
    return location;
  }
  
  public void display(){
  }
}
