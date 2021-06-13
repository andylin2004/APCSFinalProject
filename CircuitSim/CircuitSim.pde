import java.util.*;

RightClickMenu menu;
Circuit parts = new Circuit();
ArrayList<Node> selectedNodes = new ArrayList<Node>();

void setup(){
  size(1440, 900);
}

void draw(){
  ArrayList<String> menuItems = new ArrayList<String>();
  menuItems.add("node");
  menu = new RightClickMenu(menuItems);
  for (Node aNode : parts.circuitNodes){
    aNode.display();
  }
  for (Segment aSeg : parts.circuitSegments){
    aSeg.display();
  }
}

void mousePressed(){
  if (mouseButton == RIGHT){
    Node newNode = new Node(mouseX, mouseY);
    parts.addNode(newNode);
  }
  else{
    for (Node aNode : parts.circuitNodes){
      if (Math.pow(mouseX-aNode.x, 2)+Math.pow(mouseY-aNode.y, 2) < 200){
        createSegment(aNode);
      }
    }
  }
  
}

void createNode(){
  
}

void createSegment(Node curNode){
  if (selectedNodes.size()==0){
    selectedNodes.add(curNode);
  }
  else if (selectedNodes.size()==1){
    Segment newSeg = new Segment(curNode.x, curNode.y, selectedNodes.get(0).x, selectedNodes.get(0).y, selectedNodes.get(0), curNode);
    curNode.addSegment(newSeg);
    selectedNodes.get(0).addSegment(newSeg);
    parts.addSeg(newSeg);
    //newSeg.addNode(curNode);
    //newSeg.addNode(selectedNodes.get(0));
    selectedNodes.clear();
  }
}
/*
boolean inRange(PVector pos, float dist){
  PVector line = PVector.sub(p2, p1);
  float angle = line.heading();
  pos.sub(p1);
  pos.rotate(-angle);
  return pos.x >= 0 && pos.x < line.mag() && abs(pos.y) <= dist;
}
*/
