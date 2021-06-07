public class Battery extends CircuitComponent{
  private float voltage;
  //private float centerX;
  //private float centerY;
  PImage batImage;
  
  
  public Battery(float r, int CX, int CY){
    super(CX - 20, CY, CX + 500, CY);
    centerX = CX;
    centerY = CY;
    voltage = r;
    imageMode(CENTER);
    batImage = loadImage("battery.png");
    batImage.resize(70,40);
    attachmentLeft = new Button();
    attachmentLeft.x = CX + 35;
    attachmentLeft.y = CY;
    attachmentRight = new Button();
    attachmentRight.x = CX - 35;
    attachmentRight.y = CY;

  }
  
  void display(){
    /*
    fill(0);
    rectMode(CENTER);
    rect(centerX, centerY, 40, 30);
    fill(255);
    */
    attachmentLeft.display();
    attachmentRight.display();
    fill(0);
    textSize(20);
    text("battery voltage:" + voltage, centerX, centerY);
    text("part:" + toString(), centerX, centerY+30);
    text("prev:" + previousConnection, centerX, centerY+60);
    text("next:" + nextConnection, centerX, centerY+90);
    image(batImage,centerX, centerY);
  }
  
  float getVoltage(){
    return voltage;
  }
  
  void addVoltage(int num){
    if (voltage==0 && num==-1){
      return;
    }
    voltage += num;
  }
}
