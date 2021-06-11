public class Resistor extends CircuitComponent{
  private float resistence;
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
    attachmentLeft.x = CX - 12;
    attachmentLeft.y = CY +20;
    attachmentRight = new Button();
    attachmentRight.x = CX + 12;
    attachmentRight.y = CY+20;
    connections = new ArrayList();
  }
  
  void display(){
    fill(0);
    attachmentLeft.display();
    attachmentRight.display();
    fill(0);
    if(displayInfo){
      text("resistance:" + getResistance(), centerX, centerY);
      text("voltage:", centerX, centerY+30);
      text("current:", centerX, centerY+60);
      //text("connectsLeft" + connectLeft, centerX, centerY+90);
      //text("connectsRight" + connectRight, centerX, centerY+120);
      //text("associatedWith:" + associatedWith, centerX, centerY+150);
    }
    if (Circuit.verifyIfCircuit()){
      image(onBulb, centerX, centerY);
    }
    else{
      image(offBulb, centerX, centerY);
    }
  }
  
  public float getResistance(){
    return resistence;
  }
 
  
  public void addResistence(int amount){
    if (resistence == 0 && amount == -1){
       return;
    }
    resistence += amount;
  }
  
  public void click(){
    if (isMoving == true){
      centerX = mouseX;
      centerY = mouseY;
      attachmentLeft.x = mouseX - 12;
      attachmentLeft.y = mouseY + 20;
      attachmentRight.x = mouseX + 12;
      attachmentRight.y = mouseY + 20;
    }
  }
}
