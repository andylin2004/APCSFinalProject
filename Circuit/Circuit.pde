boolean grabbingWireEnd = false;
Wire wireGrabbed;
RightClickMenu menu;
ArrayList<CircuitComponent> parts = new ArrayList();
ArrayList<Wire> wires = new ArrayList();
Button reset = new ResetButton();
InstructionsButton instructions = new InstructionsButton(30, 400);
float totalResistence;
float totalCurrent;
float totalVoltage;

void setup() {
  size(1000, 500);
  frameRate(30);
  ArrayList<String> menuItems = new ArrayList<String>();
  menuItems.add("resistor");
  menuItems.add("battery");
  menu = new RightClickMenu(menuItems);
  menu.x = -1000;
  menu.y = -1000;
}

void draw() {
  background(200);
  menu.display();
  reset.display();
  instructions.display();
  for (CircuitComponent part : parts) {
    part.display();
  }
  for (Wire wire : wires) {
    wire.display();
  }
  if (grabbingWireEnd){
    wireGrabbed.x2 = mouseX;
    wireGrabbed.y2 = mouseY;
    wireGrabbed.display();
  }
  textSize(20);
  fill(0);
  text("Total Resistance: " + findTotalResistence(), 30, 30);
  text("Total Current: " + setCurrent(), 30, 70);
  text("Total Voltage: " + findTotalVoltage(), 30, 110);
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    menu.x = mouseX;
    menu.y = mouseY;
    grabbingWireEnd = false;
  }else if (grabbingWireEnd){
    for (CircuitComponent part: parts){
      if ((Math.pow(mouseX-part.attachmentLeft.x, 2)+Math.pow(mouseY-part.attachmentLeft.y, 2) < 100)
        || (Math.pow(mouseX-part.attachmentRight.x, 2)+Math.pow(mouseY-part.attachmentRight.y, 2) < 100)){
         wireGrabbed.x2 = mouseX;
         wireGrabbed.y2 = mouseY;
         wires.add(wireGrabbed);
         wireGrabbed.previousConnection.get(0).nextConnection.add(wireGrabbed);
         wireGrabbed.nextConnection.add(part);
         part.previousConnection.add(wireGrabbed);
         grabbingWireEnd = false;
         return;
       }
    }
  }else {
    if (Math.pow(mouseX-reset.x, 2)+Math.pow(mouseY-reset.y, 2) < 100) {
      reset.click();
      wires.clear();
      parts.clear();
      return;
    }
    if (Math.pow(mouseX-instructions.x, 2)+Math.pow(mouseY-instructions.y, 2) < 100){
      instructions.click();
    }
    for (CircuitComponent part: parts){
      if ((Math.pow(mouseX-part.attachmentLeft.x, 2)+Math.pow(mouseY-part.attachmentLeft.y, 2) < 100)
        || (Math.pow(mouseX-part.attachmentRight.x, 2)+Math.pow(mouseY-part.attachmentRight.y, 2) < 100)){
         wireGrabbed = new Wire(mouseX, mouseY);
         wireGrabbed.previousConnection.add(part);
         grabbingWireEnd = true;
         return;
       }
    }
    for (Button button : menu.buttons) {
      if (Math.pow(mouseX-button.x, 2)+Math.pow(mouseY-button.y, 2) < 100) {
        addComponent(button.toAdd);
      }
    }
    menu.x = -1000;
    menu.y = -1000;
  }
}

void keyPressed(){
  if (keyCode==38){
    for (int i = 0; i < parts.size(); i++){
      if (parts.get(i) instanceof Resistor){
        Resistor curRes = (Resistor) parts.get(i);
        if (Math.pow(mouseX-parts.get(i).getCX(), 2)+Math.pow(mouseY-parts.get(i).getCY(), 2) < 500){
          curRes.addResistence(1);
        }
      }
      else if (parts.get(i) instanceof Battery){
        Battery curBat = (Battery) parts.get(i);
        if (Math.pow(mouseX-parts.get(i).getCX(), 2)+Math.pow(mouseY-parts.get(i).getCY(), 2) < 500){
          curBat.addVoltage(1);
        }
      }
    }
    
  }
  else if (keyCode==40){
    for (int i = 0; i < parts.size(); i++){
      if (parts.get(i) instanceof Resistor){
        Resistor curRes = (Resistor) parts.get(i);
        if (Math.pow(mouseX-parts.get(i).getCX(), 2)+Math.pow(mouseY-parts.get(i).getCY(), 2) < 500){
          curRes.addResistence(-1);
        }
      }
      else if (parts.get(i) instanceof Battery){
        Battery curBat = (Battery) parts.get(i);
        if (Math.pow(mouseX-parts.get(i).getCX(), 2)+Math.pow(mouseY-parts.get(i).getCY(), 2) < 500){
          curBat.addVoltage(-1);
        }
      }
    }
  }
}

void addComponent(String component) {
  switch(component) {
    case("resistor"):
    parts.add(new Resistor(10, mouseX, mouseY));
    break;
    case("battery"):
    parts.add(new Battery(10, mouseX, mouseY));
    break;
  }
}
  
float findTotalResistence(){
  totalResistence = 0;
  for (int i = 0; i < parts.size(); i++){
    if (parts.get(i) instanceof Resistor){
      Resistor curRes = (Resistor) parts.get(i);
      totalResistence+= curRes.getResistence();
    }
  }
  return totalResistence;
}

float findTotalVoltage(){
  totalVoltage = 0;
  for (int i = 0; i < parts.size(); i++){
    if (parts.get(i) instanceof Battery){
      Battery curBat = (Battery) parts.get(i);
      totalVoltage+= curBat.getVoltage();
    }
  }
  return totalVoltage;
}

float setCurrent(){
  totalCurrent = totalResistence / findTotalVoltage();
  return totalCurrent;
}
