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
    if (location.current<0){
      image(onBulb, centerX, centerY);
    }
    else{
      image(offBulb, centerX, centerY);
    }
    //textSize(20);
    //text(location.getCurrent(), centerX, centerY);
  }
  
  public int getResistance(){
    return resistance;
  }
}
