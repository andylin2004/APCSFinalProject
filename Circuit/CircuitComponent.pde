public class CircuitComponent {

  float X1;
  float Y1;
  float X2;
  float Y2;
  float power;
  float voltage;
  float current;
  ArrayList<CircuitComponent> nextConnection;
  ArrayList<CircuitComponent> previousConnection;
  Button attachmentLeft;
  Button attachmentRight;
  Boolean inputDirection;
  static final boolean LEFT = true;
  static final boolean RIGHT = false;

  public CircuitComponent(int x1, int y1, int x2, int y2) {
    X1 = x1; 
    Y1 = y1; 
    X2 = x2; 
    Y2 = y2; 
    power = 0; 
    voltage = 0; 
    current = 0;
    nextConnection = new ArrayList();
    previousConnection = new ArrayList();
    attachmentLeft = new Button();
    attachmentLeft.x = x1;
    attachmentLeft.y = y1;
    attachmentRight = new Button();
    attachmentRight.x = x2;
    attachmentRight.y = y2;
  }
  
  public CircuitComponent(int x1, int y1) {
    X1 = x1; 
    Y1 = y1; 
    power = 0; 
    voltage = 0; 
    current = 0;
    nextConnection = new ArrayList();
    previousConnection = new ArrayList();
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

  public void addConnection(CircuitComponent connection, boolean next) {
    if (next) {
      nextConnection.add(connection);
    } else {
      previousConnection.add(connection);
    }
  }

  public ArrayList<CircuitComponent> getConnections(boolean next) {
    if (next) {
      return nextConnection;
    }
    return previousConnection;
  }

  public void display() {
  }
}
