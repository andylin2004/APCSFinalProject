boolean grabbingWireEnd = false;
Wire wireGrabbed;
RightClickMenu menu;
ArrayList<CircuitComponent> parts = new ArrayList();
ArrayList<Wire> wires = new ArrayList();
Button reset = new ResetButton();

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
