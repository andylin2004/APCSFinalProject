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
    fill(0);
    attachmentLeft.display();
    attachmentRight.display();
    fill(0);
    text("resistence:" + resistence, centerX, centerY);
    //text("part:" + toString(), centerX, centerY+30);
    //text("prev:" + previousConnection, centerX, centerY+60);
    //text("next:" + nextConnection, centerX, centerY+90);
  }
  
  public float getResistence(){
    return resistence;
  }
}
