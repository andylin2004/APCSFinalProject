public class Battery extends CircuitComponent{
  int voltage;
  PImage batImage;
  
  public Battery(int CX, int CY, Segment seg, int volt){
    super(CX, CY, seg);
    voltage = volt;
    imageMode(CENTER);
    batImage = loadImage("battery.png");
    batImage.resize(70,40);
  }
  
  public void display(){
    image(batImage,centerX, centerY);
    if (info){
      fill(255);
      textSize(20);
      stroke(1);
      rect(centerX +30, centerY -50 +10, 150, 90);
      fill(0);
      text("voltage: " + getVoltage(), centerX + 30, centerY - 20);
      text("current: " + location.getCurrent(), centerX +30, centerY+40);
    }
  }
  
  public int getVoltage(){
    return voltage;
  }
  
  public void addVoltage(int num){
    if (voltage==0 && num==-1){
      return;
    }
    voltage += num;
  }
}
