public class Circuit{
  ArrayList<Node> circuitNodes;
  ArrayList<Segment> circuitSegments;
  ArrayList<List<Segment>> loops;
  ArrayList<Resistor> resistors;
  ArrayList<Battery> batteries;
  
  public Circuit(){
    circuitNodes = new ArrayList<Node>();
    circuitSegments = new ArrayList<Segment>();
    loops = new ArrayList<List<Segment>>();
    resistors = new ArrayList<Resistor>();
    batteries = new ArrayList<Battery>();
  }
  
  public void addNode(Node newNode){
    circuitNodes.add(newNode);
  }
  public void addSeg(Segment seg){
    circuitSegments.add(seg);
    addLoops(seg);
    println(loops);
  }
  
  public void addBattery(Battery bat){
    batteries.add(bat);
  }
  
  public void addResistor(Resistor res){
    resistors.add(res);
  }

  public void addLoops(Segment addedSegment){
    ArrayList<Segment> path = new ArrayList<Segment>();
    path.add(addedSegment);
    addLoops(path, addedSegment.getStart(), addedSegment.getEnd(), loops);
  }

  public void addLoops(List<Segment> path, Node lastNode, Node targetNode, List<List<Segment>> solutions){
    if (lastNode==targetNode){
      solutions.add(new ArrayList<Segment>(path));
    }
    for (int i = 0; i < targetNode.getSegments().size(); i++){
      Segment curSeg = (Segment) targetNode.getSegments().get(i);
      Node otherNode = curSeg.getOther(targetNode);
      boolean alreadySeg = false;
      boolean alreadyNode = false;
      for (int j = 0; j <path.size(); j++){
        Segment seg = path.get(j);
        if (curSeg == seg){
          alreadySeg = true;
        }
        if ((seg.getStart() ==otherNode || seg.getEnd() ==otherNode)&& j !=0){
          alreadyNode = true;
        }
      }
      if (!alreadySeg && !alreadyNode){
        path.add(curSeg);
        addLoops(path, lastNode, otherNode, solutions);
        path.remove(curSeg);
      }
    }
    
  }
  
  
  /*
  for Kirchhoff's second law, when you get up to it:
for each segment in the loop:
add a term with a coefficient of the resistance, variable is toString()
add the total voltage of the segment, **multiplied by -1 if the segment goes in the opposite direction of the loop, to the sum
*/

  public Equation secondLaw(List<Segment> loop){
    Equation eq = new Equation(0.0);
    for (int i = 0; i < loop.size(); i++){
      float res = (float) loop.get(i).getTotalResistance();
      Float resi = new Float(res);
      eq.addTerm(resi,loop.get(i).toString());
      float vol = (float) loop.get(i).getTotalVoltage();
      Float volt = new Float(vol);
      if(i == 0){
        eq.addSum(volt);
      }
      else{
        int dir = loop.get(i-1).getDirection(loop.get(i)); //previous.getDirection(segment)
        eq.addSum(volt*dir);
      }
    }
    return eq;
  }
  
  public void calculateCurrent(){
    EquationSystem current = new EquationSystem();
    for (int i = 0; i < loops.size();i++){
      current.addEquation(secondLaw(loops.get(i)));
    }
    for (int i = 0; i < circuitNodes.size(); i++){
      current.addEquation(circuitNodes.get(i).firstRule());
    }
    
    float[] currents = current.solve();
    
  }

}
