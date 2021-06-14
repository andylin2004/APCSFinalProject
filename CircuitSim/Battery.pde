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
    /*
    rectMode(CENTER);
    fill(0);
    rect(centerX,centerY, 20, 20);
    */
    image(batImage,centerX, centerY);
  }
  
  public int getVoltage(){
    return voltage;
  }
}
