public class Circuit{
  ArrayList<Node> circuitNodes;
  
  public Circuit(){
    circuitNodes = new ArrayList<Node>();
  }
  
  public void addNode(Node newNode){
    circuitNodes.add(newNode);
  }
}
