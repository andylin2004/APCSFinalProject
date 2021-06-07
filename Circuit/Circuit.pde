boolean grabbingWireEnd = false;
Wire wireGrabbed;
RightClickMenu menu;
ArrayList<CircuitComponent> parts = new ArrayList();
ArrayList<Wire> wires = new ArrayList();
Button reset = new ResetButton();
float totalResistence;
float totalCurrent;
float totalVoltage;
int battAt = -1;

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
        wires.add(wireGrabbed);
        if (part.inputDirection == null) {
          part.inputDirection = CircuitComponent.LEFT;
        }
        wireGrabbed.previousConnection.get(0).nextConnection.add(wireGrabbed);
        if (part.inputDirection != null && part.inputDirection == CircuitComponent.RIGHT) {
          if (part.nextConnection.size() > 0) {
            println("1");
            for (CircuitComponent nextPart : part.nextConnection) {
              wireGrabbed.nextConnection.add(nextPart);
            }
          } else {
            println("2");
            if (part.nextConnection.size() > 0){
              CircuitBranch branch = new CircuitBranch();
              part.nextConnection.add(branch);
              branch.startAt = wireGrabbed.previousConnection.get(0);
              wireGrabbed.previousConnection.get(0).nextConnection.remove(1);
              wireGrabbed.previousConnection.get(0).previousConnection.add(branch);
              wireGrabbed.nextConnection.add(wireGrabbed.previousConnection.get(0));
            }else{
              part.nextConnection.add(wireGrabbed);
              CircuitComponent move = wireGrabbed.previousConnection.get(0).nextConnection.remove(1);
              wireGrabbed.previousConnection.get(0).previousConnection.add(move);
              wireGrabbed.nextConnection.add(wireGrabbed.previousConnection.get(0));
            }
          }
        } else {
          println("3");
          if (part.nextConnection.size() == 0 && part.inputDirection == CircuitComponent.RIGHT){
            part.previousConnection.add(wireGrabbed);
            wireGrabbed.nextConnection.add(part);
          }else if (part.previousConnection.size() == 0 && part.inputDirection == CircuitComponent.LEFT){
            part.previousConnection.add(wireGrabbed);
            wireGrabbed.nextConnection.add(part);
          }else{
            CircuitBranch branch = new CircuitBranch();
            branch.startAt = wireGrabbed;
            branch.branchContains.add(wireGrabbed);
            part.previousConnection.add(branch);
            wireGrabbed.nextConnection.add(part);
          }
        } //<>//
        part.previousConnection.add(wireGrabbed);
        grabbingWireEnd = false;
        //println(wireGrabbed);
        //println(wireGrabbed.previousConnection);
        //println(wireGrabbed.nextConnection);
        //println(part);
        //println(part.previousConnection);
        //println(part.nextConnection);
        return;
      } else if (Math.pow(mouseX-part.attachmentRight.x, 2)+Math.pow(mouseY-part.attachmentRight.y, 2) < 100) {
        wireGrabbed.x2 = mouseX;
        wireGrabbed.y2 = mouseY;
        wires.add(wireGrabbed);
        if (part.inputDirection == null) {
          part.inputDirection = CircuitComponent.RIGHT;
        }
        wireGrabbed.previousConnection.get(0).nextConnection.add(wireGrabbed);
        if (part.inputDirection != null && part.inputDirection == CircuitComponent.LEFT) {
          if (part.nextConnection.size() > 0) {
            println("1");
            for (CircuitComponent nextPart : part.nextConnection) {
              wireGrabbed.nextConnection.add(nextPart);
            }
          } else {
            println("2");
            if (part.nextConnection.size() > 0){
              CircuitBranch branch = new CircuitBranch();
              part.nextConnection.add(branch);
              branch.startAt = wireGrabbed.previousConnection.get(0);
              wireGrabbed.previousConnection.get(0).nextConnection.remove(1);
              wireGrabbed.previousConnection.get(0).previousConnection.add(branch);
              wireGrabbed.nextConnection.add(wireGrabbed.previousConnection.get(0));
            }else{
              part.nextConnection.add(wireGrabbed); //<>//
              CircuitComponent move = wireGrabbed.previousConnection.get(0).nextConnection.remove(1);
              wireGrabbed.previousConnection.get(0).previousConnection.add(move);
              wireGrabbed.nextConnection.add(wireGrabbed.previousConnection.get(0));
            }
          }
        } else {
          println("3");
          if (part.nextConnection.size() == 0 && part.inputDirection == CircuitComponent.LEFT){
            part.previousConnection.add(wireGrabbed);
            wireGrabbed.nextConnection.add(part);
          }else if (part.previousConnection.size() == 0 && part.inputDirection == CircuitComponent.RIGHT){
            part.previousConnection.add(wireGrabbed);
            wireGrabbed.nextConnection.add(part);
          }else{
            CircuitBranch branch = new CircuitBranch();
            branch.startAt = wireGrabbed;
            branch.branchContains.add(wireGrabbed);
            part.previousConnection.add(branch);
            wireGrabbed.nextConnection.add(part);
          }
        }
        grabbingWireEnd = false;
        //println(wireGrabbed);
        //println(wireGrabbed.previousConnection);
        //println(wireGrabbed.nextConnection);
        //println(part);
        //println(part.previousConnection);
        //println(part.nextConnection);
        //println(parts.get(0));
        //println(parts.get(0).previousConnection);
        //println(parts.get(0).nextConnection);
        return;
      }
    }
  } else {
    if (Math.pow(mouseX-reset.x, 2)+Math.pow(mouseY-reset.y, 2) < 100) {
      reset.click();
      wires.clear();
      parts.clear();
      println();
      return;
    }
    for (CircuitComponent part : parts) {
      if (Math.pow(mouseX-part.attachmentLeft.x, 2)+Math.pow(mouseY-part.attachmentLeft.y, 2) < 100) {
        if (part.inputDirection == null) {
          part.inputDirection = CircuitComponent.RIGHT;
        }
        wireGrabbed = new Wire(mouseX, mouseY);
        wireGrabbed.previousConnection.add(part);
        if (part.inputDirection == CircuitComponent.LEFT) {
          for (CircuitComponent partPrev : part.previousConnection) {
            wireGrabbed.previousConnection.add(partPrev);
          }
        }
        grabbingWireEnd = true;
        return;
      } else if (Math.pow(mouseX-part.attachmentRight.x, 2)+Math.pow(mouseY-part.attachmentRight.y, 2) < 100) {
        if (part.inputDirection == null) {
          part.inputDirection = CircuitComponent.LEFT;
        }
        wireGrabbed = new Wire(mouseX, mouseY);
        wireGrabbed.previousConnection.add(part);
        if (part.inputDirection == CircuitComponent.RIGHT) {
          for (CircuitComponent partPrev : part.previousConnection) {
            wireGrabbed.previousConnection.add(partPrev);
          }
        }
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

boolean verifyIfCircuit() {
  battAt = -1;
  if (parts.size() == 0) {
    return false;
  } else {
    for (int i = 0; i < parts.size(); i++){
      if (parts.get(i) instanceof Battery){
        battAt = i;
        break;
      }
    }
    if (battAt != -1){
      return verifyIfCircuit(parts.get(battAt));
    }else{
      return false;
    }
  }
}

boolean verifyIfCircuit(CircuitComponent part) {
  if (part.nextConnection.size() == 0) {
    return false;
  } else {
    for (CircuitComponent link : part.nextConnection) {
      if (link == parts.get(battAt)) {
        return true;
      } else {
        return verifyIfCircuit(link);
      }
    }
  }
  return false;
}
