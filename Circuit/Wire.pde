public class Wire extends CircuitComponent{
  int x1, y1, x2, y2;
  CircuitComponent start, end;
  Boolean prevConnectEnd, nextConnectEnd;
  
  public Wire(int startX, int startY){
    super(startX, startY);
    x1 = startX;
    y1 = startY;
  }
  
  void display(){
    rectMode(CORNERS);
    stroke(247, 157, 72);
    strokeWeight(5);
    line(x1-2.5, y1-2.5, x2, y2);
    stroke(0);
    strokeWeight(1);
    text("part:" + toString(), (x1+x2)/2, (y1+y2)/2+30);
    text("connects:" + connections, (x1+x2)/2, (y1+y2)/2+60);
  }
}
