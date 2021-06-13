public class Node{
  ArrayList<Segment> connections; 
  int x,y;
  
  public Node(int X, int Y){
    connections = new ArrayList<Segment>();
    x = X;
    y = Y;
  }
  
  public void addSegment(Segment seg){
    connections.add(seg);
  }
  
  public void display(){
    strokeWeight(1);
    ellipse(x, y, 20, 20);
  }
  
  public ArrayList getSegments(){
    return connections;
  }
}
