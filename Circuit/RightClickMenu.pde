public class RightClickMenu{
  int x, y;
  
  RightClickMenu(){}
  
  void display(){
    int spacing = 360/5;
    for (int i = 0; i<360; i += spacing){
      ellipse(x+15*cos(radians(i)), y+15*sin(radians(i)), 10, 10);
    }
  }
}
