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
  private PImage resetIcon;
  ResetButton(){
    super();
    this.x = 1300;
    this.y = 800;
  }
  
  void click(){
  }

  void display(){
    imageMode(CENTER);
    resetIcon = loadImage("reset.png");
    resetIcon.resize(60,60);
    image(resetIcon, x, y);
  }

}

class InstructionsButton {
  int x, y;
  boolean isOn;
  PImage inIcon;
  
  InstructionsButton(int X, int Y){
    x = X;
    y = Y;
    isOn = false;
  }
  
  void display(){
    imageMode(CENTER);
    inIcon = loadImage("instructions.png");
    inIcon.resize(200,200);
    image(inIcon, x, y);
    String dir = "Welcome to Electrify, an interactive circuit simulation! To add an object, right click in the \nlocation you would like to display it. You will then see two dots. If you click the right dot, a  \nlightbulb will be added to the circuit, and the left side adds a battery. To add a wire, click one of  \nthe nodes on a lightbulb/battery and click again on the node you would like to attach it to. To  \nadjust the resistance or voltage of a circuit component, hover over the component and use \nthe arrow keys. To erase the simulation, click the reset button in the bottom right corner.";
    if(isOn){
      fill(#CCB8FC);
      noStroke();
      rect(0,0,1000,350);
      fill(0);
      text("Directions", 500, 50);
      text(dir, 250, 100);
    }
  }
  
  void click(){
    isOn = !isOn;
  }
}
  
  
