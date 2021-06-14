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
  
  public PVector getPos() {
    return new PVector(x, y);
  }
  
  public Equation firstRule() {
  // return an equation, with -1 & 1 for the coefficients (depending on whether the segment goes from or to this node) and `segment.toString()` for the variables
  // sums to 0
  float[] coeff = new float[connections.size()];
  String[] vars = new String[connections.size()];
  for (int i = 0; i < coeff.length; i++){
    coeff[i] = connections.get(i).getDirection(this);
    vars[i] = connections.get(i).toString();
  }
  Equation eqOne = new Equation(coeff, vars, 0);
  return eqOne;
}
 
}
