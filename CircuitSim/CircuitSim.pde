import java.util.*;
import org.ejml.dense.row.CommonOps_DDRM;
import org.ejml.data.DMatrixRMaj;

RightClickMenu menu;
Circuit parts = new Circuit();
ArrayList<Node> selectedNodes = new ArrayList<Node>();
Button reset = new ResetButton();

void setup(){
  size(1440, 900);
  ArrayList<String> menuItems = new ArrayList<String>();
  menuItems.add("node");
  menuItems.add("battery");
  menuItems.add("resistor");
  menu = new RightClickMenu(menuItems);
  menu.x = -1000;
  menu.y = -1000;
}

void draw(){
  background(#E3DEDE);
  menu.display();
  reset.display();
  for (Node aNode : parts.circuitNodes){
    aNode.display();
  }
  for (Segment aSeg : parts.circuitSegments){
    aSeg.display();
  }
  for (Battery aBat : parts.batteries){
    aBat.display();
  }
  for (Resistor aRes : parts.resistors){
    aRes.display();
  }
}

void mousePressed(){
  if (mouseButton == RIGHT){
    menu.x = mouseX;
    menu.y = mouseY;
  }
  else{
    for (Node aNode : parts.circuitNodes){
      if (Math.pow(mouseX-aNode.x, 2)+Math.pow(mouseY-aNode.y, 2) < 200){
        createSegment(aNode);
      }
    }
    for (Button button : menu.buttons) {
      if (Math.pow(mouseX-button.x, 2)+Math.pow(mouseY-button.y, 2) < 100) {
        addComponent(button.toAdd);
        menu.x = -1000;
        menu.y = -1000;
        return;
      }
    }
    resetCircuit();
  }
  
}

void resetCircuit(){
  if (Math.pow(mouseX-reset.x, 2)+Math.pow(mouseY-reset.y, 2) < 700) {
    reset.click();
    parts.clear();
  }
}

void keyPressed(){
  if (keyCode==68) {
    displayInfo();
  }
  else if (keyCode ==38){
    for (Resistor res : parts.resistors){
      if (Math.pow(mouseX-res.centerX, 2)+Math.pow(mouseY-res.centerY, 2) < 700){
        res.addResistance(1);
      }
    }
    for (Battery bat : parts.batteries){
      if (Math.pow(mouseX-bat.centerX, 2)+Math.pow(mouseY-bat.centerY, 2) < 700){
        bat.addVoltage(1);
      }
    }
    parts.calculateCurrent();
  }
  else if (keyCode ==40){
    for (Resistor res : parts.resistors){
      if (Math.pow(mouseX-res.centerX, 2)+Math.pow(mouseY-res.centerY, 2) < 700){
        res.addResistance(-1);
      }
    }
    for (Battery bat : parts.batteries){
      if (Math.pow(mouseX-bat.centerX, 2)+Math.pow(mouseY-bat.centerY, 2) < 700){
        bat.addVoltage(-1);
      }
    }
    parts.calculateCurrent();
  }
  
}

void displayInfo(){
  for (Battery part : parts.batteries) {
      if (Math.pow(mouseX-part.centerX, 2)+Math.pow(mouseY-part.centerY, 2) < 500) {
        part.info = ! part.info;
      }
    }
  for (Resistor part : parts.resistors) {
    if (Math.pow(mouseX-part.centerX, 2)+Math.pow(mouseY-part.centerY, 2) < 500) {
      part.info = ! part.info;
    }
  }
}


void createNode(){
  Node newNode = new Node(mouseX, mouseY);
  parts.addNode(newNode);
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
    selectedNodes.clear();
  }
}

void createResistor(){
  for (int i = 0; i < parts.circuitSegments.size(); i++){
    PVector pos = new PVector(mouseX, mouseY);
    if (parts.circuitSegments.get(i).inRange(pos, 100)){
      Resistor res = new Resistor(mouseX, mouseY, parts.circuitSegments.get(i), 10);
      parts.circuitSegments.get(i).addResistor(res);
      parts.addResistor(res);
    }
  }
}

void createBattery(){
  for (int i = 0; i < parts.circuitSegments.size(); i++){
    PVector pos = new PVector(mouseX, mouseY);
    if (parts.circuitSegments.get(i).inRange(pos, 100)){
      Battery bat = new Battery(mouseX, mouseY, parts.circuitSegments.get(i), 10);
      parts.circuitSegments.get(i).addBattery(bat);
      parts.addBattery(bat);
    }
  }
}

void addComponent(String component) {
  switch(component) {
    case("resistor"):
    createResistor();
    break;
    case("battery"):
    createBattery();
    break;
    case("node"):
    createNode();
    break;
  }
  parts.calculateCurrent();
}
