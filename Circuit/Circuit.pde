boolean menuOpen = false;
RightClickMenu menu;
ArrayList<CircuitComponent> parts = new ArrayList();
Button reset = new ResetButton();

void setup(){
  size(1000,500);
  frameRate(30);
  ArrayList<String> menuItems = new ArrayList<String>();
  menuItems.add("a");
  menuItems.add("a");
  menuItems.add("a");
  menuItems.add("a");
  menu = new RightClickMenu(menuItems);
}

void draw(){
  background(200);
  menu.display();
  reset.display();
}

void mousePressed(){
  if (mouseButton == RIGHT){
    menu.x = mouseX;
    menu.y = mouseY;
  }else{
    if (Math.pow(mouseX-reset.x, 2)+Math.pow(mouseY-reset.y, 2) < 100){
      reset.click();
      parts.clear();
      return;
    }
    for (Button button : menu.buttons){
      if (Math.pow(mouseX-button.x, 2)+Math.pow(mouseY-button.y, 2) < 100){
        button.click();
      }
    }
    menu.x = -1000;
    menu.y = -1000;
  }
}
