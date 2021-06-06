public class Resistor extends CircuitComponent{
  private float resistence;
  private float centerX;
  private float centerY;
  private PImage onBulb;
  private PImage offBulb;
  
  
  public Resistor(float r, int CX, int CY){
    super(CX - 40, CY, CX + 40, CY);
    centerX = CX;
    centerY = CY;
    resistence = r;
    imageMode(CENTER);
    onBulb = loadImage("onBulb.png");
    onBulb.resize(80,90);
    offBulb = loadImage("offBulb.png");
    offBulb.resize(80,90);
    attachmentLeft = new Button();
    attachmentLeft.x = CX + 12;
    attachmentLeft.y = CY +20;
    attachmentRight = new Button();
    attachmentRight.x = CX - 12;
    attachmentRight.y = CY+20;
  }
  
  void display(){
    /*
    fill(255);
    ellipse(centerX, centerY, 80, 60);
    textSize(20);
    */
    fill(0);
    attachmentLeft.display();
    attachmentRight.display();
    fill(0);
    text("resistence:" + resistence, centerX, centerY);
    image(offBulb, centerX, centerY);
  }
  
  public float getResistence(){
    return resistence;
  }
}
