public class Wire extends CircuitComponent{
  int x1, y1, x2, y2, centerX, centerY;
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
    if (displayInfo){
      text("resistance:" + getResistance(), centerX, centerY);
      text("voltage:", centerX, centerY+30);
      text("current:" + connections, centerX, centerY+60);
      text("associatedWith:" + associatedWith, (x1+x2)/2, (y1+y2)/2+120);
    }
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
  
  void click(){
    if (startConnectEnd == start.LEFT){
      x1 = start.attachmentLeft.x;
      y1 = start.attachmentLeft.y;
    }
    else{
      x1 = start.attachmentRight.x;
      y1 = start.attachmentRight.y;
    }
    if (endConnectEnd == end.RIGHT){
      x2 = end.attachmentRight.x;
      y2 = end.attachmentRight.y;
    }
    else{
      x2 = end.attachmentLeft.x;
      y2 = end.attachmentLeft.y;
    }
  }
}
