public class Node{
  ArrayList<Segment> connections; 
  int x,y;
  
  public Node(int X, int Y){
    connections = new ArrayList<Segment>();
    x = X;
    y = Y;
  }
  
  public void display(){
    ellipse(x, y, 20, 20);
  }
}
