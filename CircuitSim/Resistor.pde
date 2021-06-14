public class Resistor extends CircuitComponent{
  int resistance;
  private PImage onBulb;
  private PImage offBulb;
  float voltageDrop;
  
  public Resistor(int CX, int CY, Segment seg, int res){
    super(CX, CY, seg);
    resistance = res;
    imageMode(CENTER);
    onBulb = loadImage("onBulb.png");
    onBulb.resize(80,90);
    offBulb = loadImage("offBulb.png");
    offBulb.resize(80,90);
    voltageDrop = 0;
  }
  
  public void display(){
    if (location.current!=0){
      image(onBulb, centerX, centerY);
    }
    else{
      image(offBulb, centerX, centerY);
    }
    if (info){
      fill(255);
      textSize(20);
      strokeWeight(1);
      rect(centerX +30, centerY -50 +10, 250, 90);
      fill(0);
      text("resistance: " + getResistance(), centerX + 30, centerY - 20);
      text("voltage drop: " + getDrop(), centerX + 30, centerY +10);
      text("current: " + location.getCurrent(), centerX +30, centerY+40);
    }
  }
  
  public int getResistance(){
    return resistance;
  }
  
  public float getRoundedCurrent(){
    return Math.round(location.getCurrent()*1000) /1000;
  }
  
  public void addResistance(int amount){
    if (resistance == 0 && amount == -1){
       return;
    }
    resistance += amount;
  }
  
  public float getDrop(){
    voltageDrop = location.getCurrent() * resistance;
    return voltageDrop;
  }
  
  
}
