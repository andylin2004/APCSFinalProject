public class RightClickMenu{
  RightClickMenu(){
    int spacing = 360/5;
    for (int i = 0; i<360; i += 10){
      ellipse(40+5*cos(radians(i)), 40+5*sin(radians(i)), 10, 10);
    }
  }
}
