boolean grabbingWireEnd = false;
Wire wireGrabbed;
RightClickMenu menu;
ArrayList<CircuitComponent> parts = new ArrayList();
Button reset = new ResetButton();
InstructionsButton instructions = new InstructionsButton(30, 400);
float totalResistence;
float totalCurrent;
float totalVoltage;

void setup() {
  size(1440, 900);
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
  if (grabbingWireEnd) {
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
  } else if (grabbingWireEnd) {
    for (CircuitComponent part : parts) {
      if (Math.pow(mouseX-part.attachmentLeft.x, 2)+Math.pow(mouseY-part.attachmentLeft.y, 2) < 100) {
        wireGrabbed.x2 = mouseX;
        wireGrabbed.y2 = mouseY;
        parts.add(wireGrabbed);
        part.connections.add(wireGrabbed);
        part.connectLeft = wireGrabbed;
        wireGrabbed.start.connections.add(wireGrabbed);
        if (wireGrabbed.startConnectEnd == CircuitComponent.LEFT) {
          if (wireGrabbed.start.connectLeft == null) {
            wireGrabbed.start.connectLeft = wireGrabbed;
          } else {
            if (!(wireGrabbed.start.connectLeft instanceof CircuitBranch)) {
              CircuitBranch replacing = new CircuitBranch();
              replacing.branchStarts.add(wireGrabbed.start.connectLeft);
              wireGrabbed.start.connectLeft = replacing;
            }
            CircuitBranch toEdit = (CircuitBranch)wireGrabbed.start.connectLeft;
            toEdit.branchStarts.add(wireGrabbed);
          }
        } else {
          wireGrabbed.end.connectLeft = wireGrabbed;
        }
        wireGrabbed.end = part;
        wireGrabbed.endConnectEnd = CircuitComponent.LEFT;
        grabbingWireEnd = false;
        return;
      } else if (Math.pow(mouseX-part.attachmentRight.x, 2)+Math.pow(mouseY-part.attachmentRight.y, 2) < 100) {
        wireGrabbed.x2 = mouseX;
        wireGrabbed.y2 = mouseY;
        wireGrabbed.end = part;
        wireGrabbed.endConnectEnd = CircuitComponent.RIGHT;
        parts.add(wireGrabbed);
        part.connectRight = wireGrabbed;
        wireGrabbed.start.connections.add(wireGrabbed);
        if (wireGrabbed.startConnectEnd == CircuitComponent.RIGHT) {
          wireGrabbed.start.connectRight = wireGrabbed;
        } else {
          if (!(wireGrabbed.start.connectRight instanceof CircuitBranch)) {
            CircuitBranch replacing = new CircuitBranch();
            replacing.branchStarts.add(wireGrabbed.start.connectRight);
            wireGrabbed.start.connectRight = replacing;
          }
          CircuitBranch toEdit = (CircuitBranch)wireGrabbed.start.connectRight;
          toEdit.branchStarts.add(wireGrabbed);
        }
        part.connections.add(wireGrabbed);
        grabbingWireEnd = false;
        return;
      }
    }
  } else {
    if (Math.pow(mouseX-reset.x, 2)+Math.pow(mouseY-reset.y, 2) < 100) {
      reset.click();
      parts.clear();
      println();
      return;
    }
    if (Math.pow(mouseX-instructions.x, 2)+Math.pow(mouseY-instructions.y, 2) < 100) {
      instructions.click();
    }
    for (CircuitComponent part : parts) {
      if (Math.pow(mouseX-part.attachmentLeft.x, 2)+Math.pow(mouseY-part.attachmentLeft.y, 2) < 100) {
        wireGrabbed = new Wire(mouseX, mouseY);
        wireGrabbed.start = part;
        wireGrabbed.startConnectEnd = CircuitComponent.LEFT;
        grabbingWireEnd = true;
        return;
      } else if (Math.pow(mouseX-part.attachmentRight.x, 2)+Math.pow(mouseY-part.attachmentRight.y, 2) < 100) {
        wireGrabbed = new Wire(mouseX, mouseY);
        wireGrabbed.start = part;
        wireGrabbed.start = part;
        wireGrabbed.startConnectEnd = CircuitComponent.RIGHT;
        grabbingWireEnd = true;
        return;
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
  }
}

void keyPressed() {
  if (keyCode==38) {
    for (int i = 0; i < parts.size(); i++) {
      if (parts.get(i) instanceof Resistor) {
        Resistor curRes = (Resistor) parts.get(i);
        if (Math.pow(mouseX-parts.get(i).getCX(), 2)+Math.pow(mouseY-parts.get(i).getCY(), 2) < 500) {
          curRes.addResistence(1);
        }
      } else if (parts.get(i) instanceof Battery) {
        Battery curBat = (Battery) parts.get(i);
        if (Math.pow(mouseX-parts.get(i).getCX(), 2)+Math.pow(mouseY-parts.get(i).getCY(), 2) < 500) {
          curBat.addVoltage(1);
        }
      }
    }
  } else if (keyCode==40) {
    for (int i = 0; i < parts.size(); i++) {
      if (parts.get(i) instanceof Resistor) {
        Resistor curRes = (Resistor) parts.get(i);
        if (Math.pow(mouseX-parts.get(i).getCX(), 2)+Math.pow(mouseY-parts.get(i).getCY(), 2) < 500) {
          curRes.addResistence(-1);
        }
      } else if (parts.get(i) instanceof Battery) {
        Battery curBat = (Battery) parts.get(i);
        if (Math.pow(mouseX-parts.get(i).getCX(), 2)+Math.pow(mouseY-parts.get(i).getCY(), 2) < 500) {
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

float findTotalResistence() {
  totalResistence = 0;
  for (int i = 0; i < parts.size(); i++) {
    if (parts.get(i) instanceof Resistor) {
      Resistor curRes = (Resistor) parts.get(i);
      totalResistence+= curRes.getResistence();
    }
  }
  return totalResistence;
}

float findTotalVoltage() {
  totalVoltage = 0;
  for (int i = 0; i < parts.size(); i++) {
    if (parts.get(i) instanceof Battery) {
      Battery curBat = (Battery) parts.get(i);
      totalVoltage+= curBat.getVoltage();
    }
  }
  return totalVoltage;
}

float setCurrent() {
  totalCurrent = totalResistence / findTotalVoltage();
  return totalCurrent;
}

boolean verifyIfCircuit(){
  for (CircuitComponent part : parts){
    if (part instanceof Battery){
      if (((Battery)part).checkConnections()){
        return verifyIfCircuit(part.connectLeft, part, CircuitComponent.LEFT);
      }
    }
  }
  return false;
}

boolean verifyIfCircuit(CircuitComponent part, CircuitComponent prev, Boolean prevDirection){
  if (part instanceof Battery){
    return true;
  }else if (part.checkConnections()){
    if (part instanceof Wire){
      verifyIfCircuit(((Wire)part).nextPart(prev), part, ((Wire)part).nextDir(prev));
    }
  }else{
    return false;
  }
}
