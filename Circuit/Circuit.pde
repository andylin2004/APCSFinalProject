boolean grabbingWireEnd = false;
Wire wireGrabbed;
RightClickMenu menu;
ArrayList<CircuitComponent> parts = new ArrayList();
ArrayList<Wire> wires = new ArrayList();
Button reset = new ResetButton();
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
  text("Total Resistence: " + findTotalResistence(), 30, 30);
  text("Total Current: " + setCurrent(), 30, 70);
  text("Total Voltage: " + findTotalVoltage(), 30, 110);
  text("Is circuit" + verifyIfCircuit(), 30, 150);
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

boolean verifyIfCircuit(){
  if (parts.size() == 0){
    return false;
  }else{
    return verifyIfCircuit(parts.get(0), null);
  }
}

boolean verifyIfCircuit(CircuitComponent part, CircuitComponent last){
  if (part.nextConnection.size() == 0 || part.previousConnection.size() == 0){
    return false;
  }else{
    for (CircuitComponent link : part.nextConnection){
      if (link == parts.get(0)){
        return true;
      }else{
        return verifyIfCircuit(link, part);
      }
    }
  }
  return false;
}
