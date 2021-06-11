public class CircuitComponent {

  float X1;
  float Y1;
  float X2;
  float Y2;
  float centerX;
  float centerY;
  float power;
  float voltage;
  float current;
  ArrayList<CircuitComponent> connections;
  CircuitComponent connectLeft;
  CircuitComponent connectRight;
  Button attachmentLeft;
  Button attachmentRight;
  CircuitBranch associatedWith;
  static final boolean LEFT = true;
  static final boolean RIGHT = false;
  boolean isMoving;

  public CircuitComponent(int x1, int y1, int x2, int y2) {
    X1 = x1; 
    Y1 = y1; 
    X2 = x2;
    Y2 = y2; 
    centerX = x1 + (x1 + x2)/2;
    centerY = y1;
    power = 0; 
    voltage = 0; 
    current = 0;
    connections = new ArrayList();
    attachmentLeft = new Button();
    attachmentLeft.x = x1;
    attachmentLeft.y = y1;
    attachmentRight = new Button();
    attachmentRight.x = x2;
    attachmentRight.y = y2;
    isMoving = false;
  }
  
  public CircuitComponent(int x1, int y1) {
    X1 = x1; 
    Y1 = y1; 
    power = 0; 
    voltage = 0; 
    current = 0;
  }
  
  public CircuitComponent(){
  }

  public void setX1(float num) {
    X1 = num;
  }

  public void setY1(float num) {
    Y1 = num;
  }

  public void setX2(float num) {
    X2 = num;
  }

  public void setY2(float num) {
    Y2 = num;
  }

  public void setPower(float num) {
    power = num;
  }

  public void setCurrent(float num) {
    current = num;
  }

  public void setVoltage(float num) {
    voltage = num;
  }

  public float getX1() {
    return X1;
  }

  public float getY1() {
    return Y1;
  }

  public float getX2() {
    return X2;
  }

  public float getY2() {
    return Y2;
  }
  
  public float getCX(){
    return centerX;
  }
  
  public float getCY(){
    return centerY;
  }

  boolean checkConnections(){
    return connectLeft != null && connectRight != null;
  }

  public void display() {
  }
  
  public CircuitComponent nextPart(Boolean prevDirection){
    if (prevDirection == LEFT){
      return connectRight;
    }else if (prevDirection == RIGHT){
      return connectLeft;
    }else{
      return null;
    }
  }
  
  public void click(){
    if (isMoving == true){
      centerX = mouseX;
      centerY = mouseY;
      attachmentLeft.x = mouseX - 20;
      attachmentLeft.y = mouseY + 20;
      attachmentRight.x = mouseX + 20;
      attachmentRight.y = mouseY + 20;
    }
  }
}
