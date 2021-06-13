import java.util.*; //<>//

boolean grabbingWireEnd = false;
Wire wireGrabbed;
RightClickMenu menu;
static ArrayList<CircuitComponent> parts = new ArrayList();
Button reset = new ResetButton();
InstructionsButton instructions = new InstructionsButton(100, 800);
float totalResistence;
float totalCurrent;
float totalVoltage;
boolean isCircuit = false;

void setup() {
  size(1440, 900);
  frameRate(30);
  ArrayList<String> menuItems = new ArrayList<String>();
  menuItems.add("resistor");
  menuItems.add("battery");
  menuItems.add("connectorUp");
  menuItems.add("connectorDown");
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
  for (CircuitComponent part : parts) {
    part.click();
  }
  textSize(20);
  fill(0);
  text("Total Resistance: " + totalResistence, 30, 30);
  text("Total Current: " + totalCurrent, 30, 70);
  text("Total Voltage: " + totalVoltage, 30, 110);
  text("Is circuit" + isCircuit, 30, 150);
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    rightClick();
  } else {
    leftClick();
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
  } else if (keyCode==68) {
    for (CircuitComponent part : parts) {
      if (Math.pow(mouseX-part.centerX, 2)+Math.pow(mouseY-part.centerY, 2) < 500) {
        part.displayInfo = ! part.displayInfo;
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
    case("connectorUp"):
    parts.add(new Connector(mouseX, mouseY, true));
    break;
    case("connectorDown"):
    parts.add(new Connector(mouseX, mouseY, false));
    break;
  }
}



void rightClick() {
  menu.x = mouseX;
  menu.y = mouseY;
  grabbingWireEnd = false;
}

void leftClick() {
  if (grabbingWireEnd) {
    attachWireToComplete();
  } else {
    //}else if (grabbingWireEnd){
    //  ifGrabWire();
    //}else {
    if (Math.pow(mouseX-reset.x, 2)+Math.pow(mouseY-reset.y, 2) < 700) {
      reset.click();
      parts.clear();
      totalResistence = 0;
      totalVoltage = 0;
      totalCurrent = 0;
      isCircuit = false;
      println();
      return;
    }
    if (isInstructions()) {
      instructions.click();
      return;
    }
    for (CircuitComponent part : parts) {
      if (!(part instanceof Wire)) {
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
        if (Math.pow(mouseX-part.getCX(), 2)+Math.pow(mouseY-part.getCY(), 2) < 500) {
          part.isMoving = ! part.isMoving;
        }
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

void attachWireToComplete() {
  for (CircuitComponent part : parts) {
    if (!(part instanceof Wire)) {
      if (Math.pow(mouseX-part.attachmentLeft.x, 2)+Math.pow(mouseY-part.attachmentLeft.y, 2) < 100) {
        handleLeftSideCompleteAttach(part);
        return;
      } else if (Math.pow(mouseX-part.attachmentRight.x, 2)+Math.pow(mouseY-part.attachmentRight.y, 2) < 100) {
        handleRightSideCompleteAttach(part);
        return;
      }
    }
  }
}

void handleLeftSideCompleteAttach(CircuitComponent part) {
  wireGrabbed.x2 = mouseX;
  wireGrabbed.y2 = mouseY;
  parts.add(wireGrabbed);
  part.connections.add(wireGrabbed);
  wireGrabbed.start.connections.add(wireGrabbed);
  wireGrabbed.end = part;
  wireGrabbed.endConnectEnd = CircuitComponent.LEFT;
  if (wireGrabbed.startConnectEnd == CircuitComponent.LEFT) {
    if (wireGrabbed.start.connectLeft == null) {
      wireGrabbed.start.connectLeft = wireGrabbed;
    }
  } else {
    wireGrabbed.end.connectLeft = wireGrabbed;
    wireGrabbed.start.connectRight = wireGrabbed;
  }
  grabbingWireEnd = false;
  //isCircuit = verifyIfCircuit();
  if (isCircuit) {
    
  }
}

void handleRightSideCompleteAttach(CircuitComponent part) {
  wireGrabbed.x2 = mouseX;
  wireGrabbed.y2 = mouseY;
  wireGrabbed.end = part;
  wireGrabbed.endConnectEnd = CircuitComponent.RIGHT;
  parts.add(wireGrabbed);          
  wireGrabbed.start.connections.add(wireGrabbed);
  if (wireGrabbed.startConnectEnd == CircuitComponent.RIGHT) {
    if (wireGrabbed.start.connectRight == null) {
      wireGrabbed.start.connectRight = wireGrabbed;
    }
  } else {
    wireGrabbed.end.connectRight = wireGrabbed;
    wireGrabbed.start.connectLeft = wireGrabbed;
  }
  part.connections.add(wireGrabbed);
  grabbingWireEnd = false;
  //isCircuit = verifyIfCircuit();
  if (isCircuit) {
    
  }
}

boolean isInstructions() {
  if (mouseX <175 && mouseX > 20 && mouseY > 755 && mouseY < 785) {
    return true;
  }
  return false;
}
