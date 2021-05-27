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
    fill(0);
    ellipse(X1, Y1, 15, 15);
    ellipse(X2, Y2, 15, 15);
    fill(255);
    textSize(20);
    attachmentLeft.display();
    attachmentRight.display();
    text("resistence:" + resistence, centerX, centerY);
  }
}
