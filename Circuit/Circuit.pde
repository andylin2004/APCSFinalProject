boolean menuOpen = false;
RightClickMenu menu;

void setup(){
  size(1000,1000);
  frameRate(30);
  ArrayList<String> menuItems = new ArrayList<String>();
  menuItems.add("a");
  menuItems.add("a");
  menuItems.add("a");
  menuItems.add("a");
  menu = new RightClickMenu(menuItems);
  menu.x = -1000;
  menu.y = -1000;
}

void draw(){
  background(200);
  menu.display();
}

void mousePressed(){
  if (mouseButton == RIGHT){
    menu.x = mouseX;
    menu.y = mouseY;
  }else{
    for (Button button : menu.buttons){
      if (Math.pow(mouseX-button.x, 2)+Math.pow(mouseY-button.y, 2) < 100){
        button.click();
        break;
      }
    }
    menu.x = -1000;
    menu.y = -1000;
  }
}
