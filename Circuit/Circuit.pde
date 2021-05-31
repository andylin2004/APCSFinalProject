boolean grabbingWireEnd = false;
RightClickMenu menu;
ArrayList<CircuitComponent> parts = new ArrayList();
Button reset = new ResetButton();
float totalResistence;

void setup() {
  size(1000, 500);
  frameRate(30);
  ArrayList<String> menuItems = new ArrayList<String>();
  menuItems.add("resistor");
  menuItems.add("battery");
  menuItems.add("a");
  menuItems.add("a");
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
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    menu.x = mouseX;
    menu.y = mouseY;
  } else {
    if (Math.pow(mouseX-reset.x, 2)+Math.pow(mouseY-reset.y, 2) < 100) {
      reset.click();
      parts.clear();
      return;
    }
    for (CircuitComponent part: parts){
      if ((Math.pow(mouseX-part.attachmentLeft.x, 2)+Math.pow(mouseY-part.attachmentLeft.y, 2) < 100)
        || (Math.pow(mouseX-part.attachmentRight.x, 2)+Math.pow(mouseY-part.attachmentRight.y, 2) < 100)){
         part.nextConnection = new Wire(mouseX, mouseY);
         grabbingWireEnd = true;
         return;       }
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
  
void findTotalResistence(){
  totalResistence = 0;
  for (int i = 0; i < parts.size(); i++){
    if (parts.get(i) instanceof Resistor){
      totalResistence+= parts.get(i).getResistence();
    }
  }
}
