public class Resistor extends CircuitComponent{
  private float resistence;
  private float centerX;
  private float centerY;
  
  
  public Resistor(float r, float CX, float CY){
    super(CX - 20, CY, CX + 20, CY);
    centerX = CX;
    centerY = CY;
    resistence = r;
  }
  
  void display(){
    ellipse(centerX, centerY, 40, 30);
    textSize(20);
    text("resistence:" + resistence, centerX, centerY);
  }
}
