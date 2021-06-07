public class CircuitBranch extends CircuitComponent {
  ArrayList<CircuitComponent> branchStarts = new ArrayList();
  CircuitComponent startAt;
  CircuitComponent terminus;
  private float resistence, voltage;

  public CircuitBranch() {
  }

  public void display() {
    for (CircuitComponent part : branchContains) {
      part.display();
    }
  }

  public float getResistance() {
    return resistence;
  }

  public float getVoltage() {
    return voltage;
  }
}
