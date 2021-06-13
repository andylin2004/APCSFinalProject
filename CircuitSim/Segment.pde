public class Segment{
  
  ArrayList<Node> connections;
  Node start;
  Node end;
  int x1,y1,x2,y2;
  
  
  public Segment(int StartX, int StartY, int endX, int endY, Node startNode, Node endNode){
    connections = new ArrayList<Node>();
    x1 = StartX;
    y1 = StartY;
    x2 = endX;
    y2 = endY;
    start = startNode;
    end = endNode;
    
  }
  
  public void addNode(Node newNode){
    connections.add(newNode);
  }
  
  public void display(){
    strokeWeight(5);
    line(x1,y1,x2,y2);
  }
  
  public Node getStart(){
    return start;
  }
  
  public Node getEnd(){
    return end;
  }
}
