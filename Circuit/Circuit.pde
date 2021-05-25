boolean menuOpen = false;

void setup(){
  new RightClickMenu();
}

void mouseClicked(){
  if (mouseButton == RIGHT){
    new RightClickMenu(mouseX, mouseY);
  }
}
