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

void assignValues() {
  for (CircuitComponent part : parts) {
    if (part instanceof Battery) {
      assignValues(part.connectLeft, part, CircuitComponent.LEFT, (Battery)part, totalVoltage);
    }
  }
}

void assignValues(CircuitComponent part, CircuitComponent prev, Boolean prevDirection, Battery start, float voltage) {
  println(part);
  println(voltage);
  if (part == start){
    
  }else if (part instanceof CircuitBranch) {
    ((CircuitBranch)part).assignValues(prev, start, prevDirection, voltage);
  } else {
    part.current = voltage / totalResistence;
    if (part instanceof Wire) {
      part.voltage = voltage;
      assignValues(((Wire)part).nextPart(prev), part, ((Wire)part).nextDir(prev), start, voltage);
    } else if (part instanceof CircuitBranch) {
      ((CircuitBranch)part).assignValues(((CircuitBranch)part).terminus, part, prevDirection, voltage);
      assignValues(((CircuitBranch)part).terminus, part, prevDirection, start, voltage);
    } else {
      part.voltage = part.resistance * part.current;
      assignValues(((CircuitComponent)part).nextPart(prevDirection), part, !prevDirection, start, voltage-part.voltage);
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
  for (CircuitComponent part : parts) {
    if (part instanceof Battery) {
      if (((Battery)part).checkConnections()) {
        totalResistence = findTotalResistance(part.connectLeft, part, CircuitComponent.LEFT, (Battery)part);
        return totalResistence;
      }
    }
  }
  return 0;
}

static float findTotalResistance(CircuitComponent part, CircuitComponent prev, Boolean prevDirection, Battery start) {
  if (part instanceof Battery) {
    return 0;
  } else if (part.checkConnections()) {
    if (part instanceof Wire) {
      return findTotalResistance(((Wire)part).nextPart(prev), part, ((Wire)part).nextDir(prev), start);
    } else if (part instanceof CircuitBranch) {
      return ((CircuitBranch)part).findTotalResistance(prev, start, prevDirection, start);
    } else if (part instanceof Resistor) {
      return ((Resistor)part).getResistance() + findTotalResistance(((CircuitComponent)part).nextPart(prevDirection), part, !prevDirection, start);
    } else {
      return findTotalResistance(((CircuitComponent)part).nextPart(prevDirection), part, !prevDirection, start);
    }
  } else {
    return 0;
  }
}

float findTotalVoltage() {
  HashSet<CircuitComponent> partsSeen = new HashSet();
  if (parts.size() != 0) {
    totalVoltage = findTotalVoltage(parts.get(0).connectLeft, parts.get(0), CircuitComponent.LEFT, partsSeen, 0);
    return totalVoltage;
  }
  return 0;
}

static float findTotalVoltage(CircuitComponent part, CircuitComponent prev, Boolean prevDirection, HashSet partsSeen, int lastTotal) {
  println(part);
  if (part instanceof Battery) {
    partsSeen.add(((CircuitComponent)part).nextPart(prevDirection));
    if (partsSeen.size() > lastTotal) {
      lastTotal = partsSeen.size();
      return ((Battery)part).getVoltage() + findTotalVoltage(((CircuitComponent)part).nextPart(prevDirection), part, !prevDirection, partsSeen, lastTotal);
    } else {
      return 0;
    }
  } else if (part instanceof CircuitBranch) {
    partsSeen.add(((CircuitBranch)part).startAt);
    partsSeen.add(((CircuitBranch)part).terminus);
    if (partsSeen.size() > lastTotal) {
      lastTotal = partsSeen.size();
      return ((CircuitBranch)part).findTotalVoltage(part, prev, prevDirection, partsSeen, lastTotal);
    } else {
      return 0;
    }
  } else if (part instanceof Wire) {
    partsSeen.add(((Wire)part).nextPart(prev));
    if (partsSeen.size() > lastTotal) {
      lastTotal = partsSeen.size();
      return findTotalVoltage(((Wire)part).nextPart(prev), part, ((Wire)part).nextDir(prev), partsSeen, lastTotal);
    } else {
      return 0;
    }
  } else if (part instanceof CircuitComponent) {
    partsSeen.add(((CircuitComponent)part).nextPart(prevDirection));
    if (partsSeen.size() > lastTotal) {
      lastTotal = partsSeen.size();
      return findTotalVoltage(((CircuitComponent)part).nextPart(prevDirection), part, !prevDirection, partsSeen, lastTotal);
    } else {
      return 0;
    }
  } else {
    return 0;
  }
}

float setCurrent() {
  totalCurrent = findTotalResistence() / findTotalVoltage();
  return totalCurrent;
}


static boolean verifyIfCircuit() {
  for (CircuitComponent part : parts) {
    if (part instanceof Battery) {
      if (((Battery)part).checkConnections()) {
        return verifyIfCircuit(part.connectLeft, part, CircuitComponent.LEFT, (Battery)part);
      }
    }
  }
  return false;
}

static boolean verifyIfCircuit(CircuitComponent part, CircuitComponent prev, Boolean prevDirection, Battery start) {
  if (part instanceof Battery) {
    return true;
  } else if (part.checkConnections()) {
    if (part instanceof Wire) {
      return verifyIfCircuit(((Wire)part).nextPart(prev), part, ((Wire)part).nextDir(prev), start);
    } else if (part instanceof CircuitBranch) {
      return ((CircuitBranch)part).verifyIfCircuit(prev, start, prevDirection, start);
    } else {
      return verifyIfCircuit(((CircuitComponent)part).nextPart(prevDirection), part, !prevDirection, start);
    }
  } else {
    return false;
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
          wireGrabbed.associatedWith = part.associatedWith;
          grabbingWireEnd = true;
          return;
        } else if (Math.pow(mouseX-part.attachmentRight.x, 2)+Math.pow(mouseY-part.attachmentRight.y, 2) < 100) {
          wireGrabbed = new Wire(mouseX, mouseY);
          wireGrabbed.start = part;
          wireGrabbed.start = part;
          wireGrabbed.startConnectEnd = CircuitComponent.RIGHT;
          wireGrabbed.associatedWith = part.associatedWith;
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
      if (wireGrabbed.associatedWith != null) {
        wireGrabbed.associatedWith.branchesComponent.get(wireGrabbed.associatedWith.branchesComponent.size() - 1).add(wireGrabbed);
      }
    } else {
      if (!(wireGrabbed.start.connectLeft instanceof CircuitBranch)) {
        CircuitBranch replacing = new CircuitBranch();
        replacing.branchStarts.add(wireGrabbed.start.connectLeft);
        replacing.branchEnds.add(wireGrabbed.start.connectLeft);
        replacing.startAt = wireGrabbed.start;
        replacing.terminus = wireGrabbed.end;
        wireGrabbed.start.connectLeft = replacing;
      }
      CircuitBranch toEdit = (CircuitBranch)wireGrabbed.start.connectLeft;
      toEdit.branchStarts.add(wireGrabbed);
      toEdit.branchesComponent.add(new ArrayList());
      toEdit.branchesComponent.get(toEdit.branchesComponent.size() - 1).add(wireGrabbed);
      wireGrabbed.associatedWith = toEdit;
      part.associatedWith = toEdit;
    }
  } else {
    wireGrabbed.end.connectLeft = wireGrabbed;
    wireGrabbed.start.connectRight = wireGrabbed;
    if (wireGrabbed.associatedWith != null) {
      wireGrabbed.associatedWith.branchesComponent.get(wireGrabbed.associatedWith.branchesComponent.size() - 1).add(wireGrabbed);
    }
    part.associatedWith = wireGrabbed.associatedWith;
  }
  if (part.connectLeft instanceof Wire && part.connectLeft != wireGrabbed) {
    if (wireGrabbed.associatedWith == null) {
      CircuitBranch replacing = new CircuitBranch();
      replacing.branchStarts.add(wireGrabbed.start.connectLeft);
      replacing.branchEnds.add(wireGrabbed.start.connectLeft);
      replacing.startAt = wireGrabbed.start;
      replacing.terminus = wireGrabbed.end;
    } else {
      CircuitBranch toEdit = (CircuitBranch)part.connectRight;
      toEdit.accountForBranches(CircuitComponent.LEFT);
      part.connectLeft = toEdit;
    }
  }
  if (part.connectLeft instanceof CircuitBranch) {
    CircuitBranch toEdit = (CircuitBranch)part.connectLeft;
    toEdit.branchStarts.add(wireGrabbed);
  }
  if (part.connectLeft == null) {
    part.connectLeft = wireGrabbed;
    if (wireGrabbed.associatedWith != null) {
      wireGrabbed.associatedWith.branchesComponent.get(wireGrabbed.associatedWith.branchesComponent.size() - 1).add(part);
    }
  }
  grabbingWireEnd = false;
  isCircuit = verifyIfCircuit();
  if (isCircuit) {
    setCurrent();
    assignValues();
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
      if (wireGrabbed.associatedWith != null) {
        wireGrabbed.associatedWith.branchesComponent.get(wireGrabbed.associatedWith.branchesComponent.size() - 1).add(wireGrabbed);
      }
    } else {
      if (!(wireGrabbed.start.connectRight instanceof CircuitBranch)) {
        CircuitBranch replacing = new CircuitBranch();
        replacing.branchStarts.add(wireGrabbed.start.connectRight);
        replacing.branchEnds.add(wireGrabbed.start.connectRight);
        replacing.startAt = wireGrabbed.start;
        replacing.terminus = wireGrabbed.end;
        wireGrabbed.start.connectRight = replacing;
      }
      CircuitBranch toEdit = (CircuitBranch)wireGrabbed.start.connectRight;
      toEdit.branchStarts.add(wireGrabbed);
      wireGrabbed.associatedWith = toEdit;
      part.associatedWith = toEdit;
    }
  } else {
    wireGrabbed.end.connectRight = wireGrabbed;
    wireGrabbed.start.connectLeft = wireGrabbed;
    if (wireGrabbed.associatedWith != null) {
      wireGrabbed.associatedWith.branchesComponent.get(wireGrabbed.associatedWith.branchesComponent.size() - 1).add(wireGrabbed);
    }
    part.associatedWith = wireGrabbed.associatedWith;
  }
  if (part.connectRight instanceof Wire && part.connectRight != wireGrabbed) {
    if (wireGrabbed.associatedWith == null) {
      CircuitBranch replacing = new CircuitBranch(); //<>//
      replacing.branchStarts.add(wireGrabbed.start.connectRight);
      replacing.branchEnds.add(wireGrabbed.start.connectRight);
      replacing.startAt = wireGrabbed.start;
      replacing.terminus = wireGrabbed.end;
    } else {
      CircuitBranch toEdit = (CircuitBranch)part.connectLeft;
      toEdit.accountForBranches(CircuitComponent.RIGHT);
      part.connectRight = toEdit;
    }
  }
  if (part.connectRight instanceof CircuitBranch) {
    CircuitBranch toEdit = (CircuitBranch)part.connectRight; //<>//
    toEdit.branchStarts.add(wireGrabbed);
  }         
  if (part.connectRight == null) {
    part.connectRight = wireGrabbed;
    if (wireGrabbed.associatedWith != null) {
      wireGrabbed.associatedWith.branchesComponent.get(wireGrabbed.associatedWith.branchesComponent.size() - 1).add(part);
    }
  }
  part.connections.add(wireGrabbed);
  grabbingWireEnd = false;
  isCircuit = verifyIfCircuit();
  if (isCircuit) {
    setCurrent();
    assignValues();
  }
}

boolean isInstructions() {
  if (mouseX <175 && mouseX > 20 && mouseY > 755 && mouseY < 785) {
    return true;
  }
  return false;
}
