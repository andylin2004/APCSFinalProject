class Connector extends CircuitComponent{
  Button attachmentTop;
  boolean up;
  
  public Connector(int CX, int CY, boolean dir){
    super(CX-30,CY,CX+30,CY);
    centerX = CX;
    centerY = CY;
    attachmentTop = new Button();
    attachmentTop.x = CX;
    attachmentTop.y = CY - 40;
    up = dir;
  }
  
  
  public void display(){
    if (up){
      fill(0);
      rectMode(CENTER);
      rect(centerX,centerY,60,10);
      rect(centerX,centerY -20,10,40);
      fill(255);
      attachmentLeft.display();
      attachmentRight.display();
      attachmentTop.display();
    }
    else{
      fill(0);
      rectMode(CENTER);
      rect(centerX,centerY,60,10);
      rect(centerX,centerY +20,10,40);
      fill(255);
      attachmentTop.y = (int) centerY + 40;
      attachmentLeft.display();
      attachmentRight.display();
      attachmentTop.display();
    }
  }
  
  public void click(){
    if (isMoving){
      centerX = mouseX;
      centerY = mouseY;
      attachmentLeft.x = mouseX - 30;
      attachmentLeft.y = mouseY;
      attachmentRight.x = mouseX + 30;
      attachmentRight.y = mouseY;
      attachmentTop.x = mouseX;
      if (up){
        attachmentTop.y = mouseY -40;
      }
      else{
        attachmentTop.y = mouseY +40;
      }
    }
  }
}
