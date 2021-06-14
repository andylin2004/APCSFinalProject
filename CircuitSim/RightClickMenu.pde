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
    strokeWeight(1);
    color(255);
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
    String dir = "Welcome to Electrify, an interactive circuit simulation! Start by adding nodes. To do this, right \nclick and then click the button in the right corner of the triangle that appears. To connect your \nnodes, click two nodes sequentially and a segment (basically a wire) will appear. Now that you \nhave created the framework of the circuit, right click on the wires to add lights and batteries. \nTo get information about the current, voltage, and resistance, hover over a component and \npress ‘d’. To change a component’s resistance or voltage, press the up and down arrows over \na component. The reset button in the bottom right corner will clear the screen. ";
    if(isOn){
      fill(#CCB8FC);
      noStroke();
      rect(0,0,1440,350);
      fill(0);
      textSize(20);
      text("Directions", 700, 50);
      text(dir, 300, 100);
    }
  }
  
  void click(){
    isOn = !isOn;
  }
}
