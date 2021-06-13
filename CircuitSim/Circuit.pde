public class Circuit{
  ArrayList<Node> circuitNodes;
  ArrayList<Segment> circuitSegments;
  
  public Circuit(){
    circuitNodes = new ArrayList<Node>();
    circuitSegments = new ArrayList<Segment>();
  }
  
  public void addNode(Node newNode){
    circuitNodes.add(newNode);
  }
  public void addSeg(Segment seg){
    circuitSegments.add(seg);
  }
  
  
  /**
  initial call would look like this:
  
  ArrayList<List<Segment>> solutions = new ArrayList<List<Segment>>();
  ArrayList<Segment> path = new ArrayList<Segment>();
  path.add(addedSegment)
  addLoops(path, addedPath.getStart(), addedPath.getEnd(), solutions);
  
  and the solutions, if any, would be added to `solutions`
  */

  public void addLoops(Segment addedSegment){
    ArrayList<List<Segment>> solutions = new ArrayList<List<Segment>>();
    ArrayList<Segment> path = new ArrayList<Segment>();
    path.add(addedSegment);
    addLoops(path, addedSegment.getStart(), addedSegment.getEnd(), solutions);
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
      for (int j = 1; i <path.size(); j++){
        Segment seg = path.get(j);
        if (curSeg == seg){
          alreadySeg = true;
        }
        if (seg.getStart() ==otherNode || seg.getEnd() ==otherNode){
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
