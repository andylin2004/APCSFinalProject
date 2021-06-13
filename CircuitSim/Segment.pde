public class Segment{
  
  ArrayList<Node> connections; 
  int x1,y1,x2,y2;
  
  public Segment(int StartX, int StartY){
    connections = new ArrayList<Node>();
    x1 = StartX;
    y1 = StartY;
  }
  
  public void addNode(Node newNode){
    connections.add(newNode);
  }
}
