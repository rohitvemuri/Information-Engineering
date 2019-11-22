class Node {
  public PVector nodePos;
  public ArrayList<Integer> connections;
  
  public Node(PVector np) {
    nodePos = np;
    connections = new ArrayList();
  }
  
  public String toString() {
    return "{" + nodePos.toString() + ": " + connections.toString() + "}"; 
  }
}

float MOVE_SPEED = 0.25;

class Solver {
  PVector location, desired;
  ArrayList<Node> graph;
  
  float squareSize;
  
  ArrayList<Node> cameFrom;
  Node next;
  
  boolean done;
  
  public Solver(PVector loc, PVector des) {
    squareSize = (float)width / maze.gridSize;
    done = false;
    
    location = loc;
    desired = des;
    
    graph = new ArrayList();
    constructGraph(location);
    
    cameFrom = new ArrayList();
    
    next = graph.get(0);
    cameFrom.add(next);
  }
  
  private int constructGraph(PVector current) {    
    for (Node n : graph) {
      if (n.nodePos.equals(current))
        return -1;
    }
    
    Node n = new Node(current);
    graph.add(n);
    
    int pos = graph.size() - 1;
    
    expandDirection(1, 0, n);
    expandDirection(-1, 0, n);
    expandDirection(0, 1, n);
    expandDirection(0, -1, n);

    int ndx = n.connections.indexOf(pos);
    
    if (ndx != -1)
      n.connections.remove(ndx);
    
    return pos;
  }
  
  private void expandDirection(int xDir, int yDir, Node n) {
    int posX = int(n.nodePos.x), posY = int(n.nodePos.y);
    int nextX = posX, nextY = posY;
    
    do {
      posX = nextX;
      posY = nextY;
      
      if (maze.grid[posY + xDir][posX + yDir] == 1 || maze.grid[posY - xDir][posX - yDir] == 1)
        addNode(n, posX, posY);
      
      nextX += xDir;
      nextY += yDir;
    } while (maze.grid[nextY][nextX] == 1);
    
    addNode(n, posX, posY);
  }
  
  private void addNode(Node n, int posX, int posY) {
    int pos = constructGraph(new PVector(posX, posY));
        
    if (pos != -1 && !n.connections.contains(pos))
      n.connections.add(pos);
  }
  
  public void update() {
    if (done)
      return;
    
    if (at(desired)) {
      done = true;
      return; 
    }
    
    if (at(next.nodePos))
      next = getNext();
    
    PVector diffVec = PVector.sub(next.nodePos, location);
    
    if (diffVec.x != 0 && diffVec.y != 0)
      diffVec.y = 0 ;
      
    location.add(diffVec.normalize().mult(MOVE_SPEED));
  }
  
  private boolean at(PVector dest) {      
    return dest.x == location.x && dest.y == location.y;
  }
  
  private Node getNext() {    
    Node nn = null;
    
    if (next.connections.size() == 0) {
      int lastNdx = cameFrom.size() - 1;
     
      cameFrom.remove(lastNdx);
      nn = cameFrom.get(lastNdx - 1);
      
      return nn;
    }
    
    for (int conn : next.connections) {
      Node cn = graph.get(conn);
      
      if (nn == null || h(cn) < h(nn))
        nn = cn;       
    }
    
    int connNdx = graph.indexOf(nn);  
    next.connections.remove(next.connections.indexOf(connNdx));   
    cameFrom.add(nn);
    
    return nn;
  }
  
  private float h(Node n) {
    return desired.dist(n.nodePos); 
  }
  
  public void display() {
    noStroke();
    
    fill(255, 0, 0, 30);
    rect(squareSize, squareSize, squareSize, squareSize);
    
    fill(0, 255, 0, 30);
    rect(desired.x * squareSize, desired.y * squareSize, squareSize, squareSize);
    
    fill(0, 0, 255);
    rect(location.x * squareSize, location.y * squareSize, squareSize, squareSize);
    
    if (done) {
      fill(255, 125, 0, 50);
      
      for (int i = 0; i < cameFrom.size() - 1; i++) {
        PVector a = PVector.mult(cameFrom.get(i).nodePos, squareSize), b = PVector.mult(cameFrom.get(i + 1).nodePos, squareSize);
        
        rect(a.x, a.y, squareSize, squareSize);
        
        /*float xsBound = a.x < b.x ? a.x : b.x, ysBound = a.y < b.y ? a.y : b.y;
        rect(xsBound, ysBound, abs(a.x - b.x), abs(a.y - b.y));*/
      }
    }
  }
}
