class CircuitList {
  boolean verifyIfCircuit() {
    for (CircuitComponent part : parts) {
      if (part instanceof Battery) {
        if (((Battery)part).checkConnections()) {
          return verifyIfCircuit(part.connectLeft, part, CircuitComponent.LEFT, (Battery)part);
        }
      }
    }
    return false;
  }

  boolean verifyIfCircuit(CircuitComponent part, CircuitComponent prev, Boolean prevDirection, CircuitComponent start) {
    if (part instanceof Battery) {
      return true;
    } else if (part.checkConnections()) {
      if (part instanceof Wire) {
        return verifyIfCircuit(((Wire)part).nextPart(prev), part, ((Wire)part).nextDir(prev), start);
      } else if (part instanceof Connector) {
        return true;
      } else {
        return verifyIfCircuit(((CircuitComponent)part).nextPart(prevDirection), part, !prevDirection, start);
      }
    } else {
      return false;
    }
  }
}
