public class RightClickMenu{
  final int x, y;
  
  RightClickMenu(int x, int y){
    this.x = x;
    this.y = y;
    int spacing = 360/5;
    for (int i = 0; i<360; i += 10){
      ellipse(x+5*cos(radians(i)), y+5*sin(radians(i)), 10, 10);
    }
  }
}
