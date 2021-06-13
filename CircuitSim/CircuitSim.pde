import java.util.*;

RightClickMenu menu;
Circuit parts = new Circuit();

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
}

void mousePressed(){
  if (mouseButton == RIGHT){
    Node newNode = new Node(mouseX, mouseY);
    parts.addNode(newNode);
  }
}
