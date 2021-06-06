public class Battery extends CircuitComponent{
  private float voltage;
  private float centerX;
  private float centerY;
  PImage batImage;
  
  
  public Battery(float r, int CX, int CY){
    super(CX - 20, CY, CX + 20, CY);
    centerX = CX;
    centerY = CY;
    voltage = r;
    imageMode(CENTER);
    batImage = loadImage("battery.png");
    batImage.resize(70,40);

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
    image(batImage,centerX, centerY);
  }
  
  float getVoltage(){
    return voltage;
  }
}
