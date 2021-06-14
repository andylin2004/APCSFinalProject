public class Resistor extends CircuitComponent{
  int resistance;
  private PImage onBulb;
  private PImage offBulb;
  
  public Resistor(int CX, int CY, Segment seg, int res){
    super(CX, CY, seg);
    resistance = res;
    imageMode(CENTER);
    onBulb = loadImage("onBulb.png");
    onBulb.resize(80,90);
    offBulb = loadImage("offBulb.png");
    offBulb.resize(80,90);
  }
  
  public void display(){
    if (location.current!=0){
      image(onBulb, centerX, centerY);
    }
    else{
      image(offBulb, centerX, centerY);
    }
    fill(255);
    textSize(20);
    stroke(1);
    rect(centerX +30, centerY -50 +10, 150, 90);
    fill(0);
    text("resistance: " + getResistance(), centerX + 30, centerY - 20);
    text("current: " + location.getCurrent(), centerX +30, centerY+40);
  }
  
  public int getResistance(){
    return resistance;
  }
}
