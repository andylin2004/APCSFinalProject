public class RightClickMenu{
  int x, y;
  ArrayList<Button> buttons = new ArrayList<Button>();
  
  RightClickMenu(ArrayList<String> components){
    for (String component : components){
      buttons.add(new Button(component));
    }
    this.x = -1000;
    this.y = -1000;
  }
  
  void display(){
    int spacing = 360/buttons.size();
    int i = 0;
    for (Button button : buttons){
      button.x = Math.round(this.x+15*cos(radians(i)));
      button.y = Math.round(this.y+15*sin(radians(i)));
      button.display();
      i += spacing;
    }
  }
}

class Button{
  int x, y;
  String toAdd;
  
  Button(String toAdd){
    this.toAdd = toAdd;
  }
  
  Button(){
  }
  
  void display(){
    ellipse(x, y, 10, 10);
  }
  
  void click(){
    print(toAdd);
  }
}

class ResetButton extends Button{
  ResetButton(){
    super();
    this.x = 900;
    this.y = 400;
  }
  
  void click(){
  }
}

class InstructionsButton {
  int x, y;
  boolean isOn;
  
  InstructionsButton(int X, int Y){
    x = X;
    y = Y;
    isOn = false;
  }
  
  void display(){
    ellipse(x,y,10,10);
    String line1 = "Welcome to the circuit simulation. To add an object right click";
    String line2 = "and two dots will appear. If you click on the right dot, a resistor will";
    String line3 = "appear and the left dot creates a battery. To create a wire click one";
    String line4 = "of the nodes on a battery/resistor and click again on the place you";
    String line5 = "would like the wire to connect to. The power, current, and voltage of the";
    String line6 = "entire circuit is tracted in the upper left hand corner and to erase the";
    String line7 = "circuit click the small button in the lower right.";
    if(isOn){
      text(line1+line2+line3+line4+line5+line6+line7, x, y)
    }
  }
  
  void click(){
    isOn = !isOn;
  }
}
  
  
