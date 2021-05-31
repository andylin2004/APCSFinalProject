public class Resistor extends CircuitComponent{
  private float resistence;
  private float centerX;
  private float centerY;
  
  public Resistor(float r, int CX, int CY){
    super(CX - 40, CY, CX + 40, CY);
    centerX = CX;
    centerY = CY;
    resistence = r;
  }
  
  void display(){
    fill(255);
    ellipse(centerX, centerY, 80, 60);
    textSize(20);
    attachmentLeft.display();
    attachmentRight.display();
    text("resistence:" + resistence, centerX, centerY);
  }
  
  public float getResistence(){
    return resistence;
  }
}
