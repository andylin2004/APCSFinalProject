public class CircuitBranch extends CircuitComponent {
  ArrayList<CircuitComponent> branchStarts = new ArrayList();
  ArrayList<CircuitComponent> branchEnds = new ArrayList();
  boolean branch2Active = false;
  CircuitComponent startAt;
  CircuitComponent terminus;
  private float resistence, voltage;

  public CircuitBranch() {
  }

  public float getResistance() {
    return resistence;
  }

  public float getVoltage() {
    return voltage;
  }

  public boolean verifyIfCircuit(CircuitComponent lastConnect, Boolean prevDirection, Battery battery) {
    if (!branch2Active){
      return verifyIfCircuit(branchStarts.get(0), lastConnect, prevDirection, battery);
    }else{
      for (CircuitComponent branch : branchStarts){
        if (verifyIfCircuit(branch, lastConnect, prevDirection, battery)){
          return true;
        }
      }
      return false;
    }
  }

  boolean verifyIfCircuit(CircuitComponent part, CircuitComponent prev, Boolean prevDirection, Battery start) {
    if (part instanceof Battery) {
      return true;
    } else if (part.checkConnections()) {
      if (part instanceof Wire) {
        return verifyIfCircuit(((Wire)part).nextPart(prev), part, ((Wire)part).nextDir(prev), start);
      } else if (part instanceof CircuitBranch) {
        return ((CircuitBranch)part).verifyIfCircuit(prev, start, prevDirection, start);
      } else {
        return verifyIfCircuit(((CircuitComponent)part).nextPart(prevDirection), part, !prevDirection, start);
      }
    } else {
      return false;
    }
  }
}
