public class CircuitBranch extends CircuitComponent {
  ArrayList<CircuitComponent> branchStarts = new ArrayList();
  ArrayList<CircuitComponent> branchEnds = new ArrayList();
  ArrayList<ArrayList<CircuitComponent>> branchesComponent = new ArrayList();
  ArrayList<Boolean> branchActive = new ArrayList();
  CircuitComponent startAt;
  CircuitComponent terminus;
  private float resistence, voltage;

  public CircuitBranch() {
  }

  public float getVoltage() {
    return voltage;
  }

  public boolean verifyIfCircuit(CircuitComponent lastConnect, Boolean prevDirection, Battery battery) {
    for (int i = 0; i<branchActive.size(); i++) {
      if (branchActive.get(i)) {
        for (CircuitComponent branch : branchStarts) {
          if (verifyIfCircuit(branch, lastConnect, prevDirection, battery)) {
            return true;
          }
        }
      }
    }
    return false;
  }

  private boolean verifyIfCircuit(CircuitComponent part, CircuitComponent prev, Boolean prevDirection, Battery start) {
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
      println("false at" + part);
      return false;
    }
  }
  
  public float findTotalResistance(CircuitComponent part, CircuitComponent prev, Boolean prevDirection, Battery start){
    println(branchesComponent);
    return getResistance() + Circuit.findTotalResistance(terminus, this, prevDirection, start);
  }
  
  public float getResistance(){
    float totalResistance = 0;
    for (ArrayList<CircuitComponent> branch: branchesComponent){
      float totalInBranch = 0;
      for (CircuitComponent partInBranch: branch){
        println(partInBranch);
        totalInBranch += partInBranch.getResistance();
      }
      println(totalInBranch);
      totalResistance += 1/totalInBranch;
      println(totalResistance);
    }
    return totalResistance;
  }
  
  void accountForBranches(Boolean prevDirection){
    for (CircuitComponent branch : branchStarts){
      if (branch.associatedWith == null){
        branchesComponent.add(new ArrayList());
        accountForBranches(branch, startAt, !prevDirection);
      }
    }
  }
        
  private void accountForBranches(CircuitComponent part, CircuitComponent prev, Boolean prevDirection){
    println(part + "e");
    println(branchesComponent);
    if (part.associatedWith == this || part.nextPart(prevDirection) == this){
      terminus = part;
    }else if (part.associatedWith == null){
      part.associatedWith = this;
      branchesComponent.get(branchesComponent.size()-1).add(part);
      if (part instanceof Wire){
        accountForBranches(((Wire)part).nextPart(prev), part, ((Wire)part).nextDir(prev));
      }else if(part instanceof CircuitBranch){
        accountForBranches(((CircuitBranch)part).terminus, part, prevDirection);
      }else{
        accountForBranches(((CircuitComponent)part).nextPart(prevDirection), part, !prevDirection);
      }
    }
    
  }
  
  boolean checkConnections(){
    return (startAt != null && terminus != null);
  }
  
  
  
}
