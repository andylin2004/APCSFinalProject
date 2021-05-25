boolean menuOpen = false;
RightClickMenu menu;

void setup(){
  size(1000,1000);
  frameRate(30);
  menu = new RightClickMenu();
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
    if (Math.pow(mouseX-menu.x, 2)+Math.pow(mouseY-menu.y, 2) < 400){
      print("less");
    }else{
      menu.x = -1000;
      menu.y = -1000;
    }
  }
}
