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

}