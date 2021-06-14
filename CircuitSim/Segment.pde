public class Segment{
  
  ArrayList<Node> connections;
  Node start;
  Node end;
  int x1,y1,x2,y2;
  ArrayList<Resistor> resistors;
  ArrayList<Battery> batteries;
  
  
  public Segment(int StartX, int StartY, int endX, int endY, Node startNode, Node endNode){
    connections = new ArrayList<Node>();
    x1 = StartX;
    y1 = StartY;
    x2 = endX;
    y2 = endY;
    start = startNode;
    end = endNode;
    resistors = new ArrayList<Resistor>();
    batteries = new ArrayList<Battery>();
    
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
  
  public Node getOther(Node aNode){
    if (aNode==start){
      return end;
    }
    else{
      return start;
    }
  }
  
  public boolean inRange(PVector pos, float dist){
    PVector line = PVector.sub(end.getPos(), start.getPos());
    float angle = line.heading();
    pos.sub(start.getPos());
    pos.rotate(-angle);
    println(pos.x >= 0 && pos.x < line.mag() && abs(pos.y) <= dist);
    return pos.x >= 0 && pos.x < line.mag() && abs(pos.y) <= dist;
  }
  
  public void addBattery(Battery bat){
    batteries.add(bat);
  }
  
  public void addResistor(Resistor res){
    resistors.add(res);
  }
  
  public int getTotalResistance(){
    int res = 0;
    for (int i = 0; i < resistors.size();i++){
      res += resistors.get(i).getResistance();
    }
    return res;
  }
  
  public int getTotalVoltage(){
    int volt = 0;
    for (int i = 0; i < batteries.size();i++){
      volt += batteries.get(i).getVoltage();
    }
    return volt;
  }
  
  public Float getDirection(Node node) {
  // return -1 if it's the "start", 1 if it's the "end"
  if (node==start){
    return -1.0;
  }
  else{
    return 1.0;
  }
}
}
