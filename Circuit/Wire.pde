public class Wire extends CircuitComponent{
  int x1, y1, x2, y2;
  CircuitComponent start, end;
  Boolean startConnectEnd, endConnectEnd, startsAtStart;
  
  public Wire(int startX, int startY){
    super(startX, startY);
    x1 = startX;
    y1 = startY;
  }
  
  void display(){
    rectMode(CORNER);
    stroke(247, 157, 72);
    strokeWeight(5);
    line(x1-2.5, y1-2.5, x2, y2);
    stroke(0);
    strokeWeight(1);
    //fill(255);
    //rect((x1+x2)/2, (y1+y2)/2, 250, 200);
    //fill(0);
    text("part:" + toString(), (x1+x2)/2, (y1+y2)/2+30);
    text("start:" + start, (x1+x2)/2, (y1+y2)/2+60);
    text("end:" + end, (x1+x2)/2, (y1+y2)/2+90);
    text("associatedWith:" + associatedWith, (x1+x2)/2, (y1+y2)/2+120);
  }
  
  boolean checkConnections(){
    return startConnectEnd != null && endConnectEnd != null;
  }
  
  CircuitComponent nextPart(CircuitComponent prev){
    if (start == prev){
      return end;
    }else{
      return start;
    }
  }
  
  Boolean nextDir(CircuitComponent prev){
    if (start == prev){
      return endConnectEnd;
    }else{
      return startConnectEnd;
    }
  }
}
