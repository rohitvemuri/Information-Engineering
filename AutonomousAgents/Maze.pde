class Maze {
  int gridSize;
  
  int[][] grid;
  ArrayList<PVector> visitedCoords;
  
  public Maze(int gridSize) {
    this.gridSize = gridSize;
    
    grid = new int[gridSize][gridSize];
    
    for (int y = 0; y < gridSize; y++) {
      for (int x = 0; x < gridSize; x++) {
        grid[y][x] = 0; 
      }
    }
    
    visitedCoords = new ArrayList();
    
    generate(1, 1);
  }
  
  private void generate(int x, int y) {
    ArrayList<Integer> xDirections = new ArrayList(),
                       yDirections = new ArrayList();
                       
    xDirections.add(0);
    yDirections.add(0);
    
    if (x > 1)
      xDirections.add(-2);
    if (x < gridSize - 2)
      xDirections.add(2);
      
    if (y > 1)
      yDirections.add(-2);
    if (y < gridSize - 2)
      yDirections.add(2);
      
    while (xDirections.size() > 1 || yDirections.size() > 1) {
      int xNdx = int(random(xDirections.size())), yNdx = 0;
      
      if (xNdx == 0)
        yNdx = int(random(yDirections.size()));
        
      if (xNdx == 0 && yNdx == 0)
        continue;
      
      int newX = x + xDirections.get(xNdx), newY = y + yDirections.get(yNdx);
      
      if (!visitedCoord(newX, newY)) {    
         visitedCoords.add(new PVector(newX, newY));
         
         grid[newY][newX] = 1;
         grid[(newY + y) / 2][(newX + x) / 2] = 1;
         
         generate(newX, newY);
      }
      
      if (xNdx != 0)
        xDirections.remove(xNdx);
        
      if (yNdx != 0)
        yDirections.remove(yNdx);
    }
  }
  
  private boolean visitedCoord(int x, int y) {
    for (PVector vc : visitedCoords) {
      if (vc.x == x && vc.y == y)
        return true;
    }
    
    return false;
  }
  
  public void display() {
    float widthIncrem = (float)width / gridSize;
    float heightIncrem = (float)height / gridSize;
    
    for (int y = 0; y < gridSize; y++) {
      for (int x = 0; x < gridSize; x++) {
        int val = grid[y][x];
        
        if (val == 0) {
          fill(220);
          stroke(180);
        }
        else {
          fill(150);
          stroke(90);
        }
        
        rect(x * widthIncrem, y * heightIncrem, widthIncrem, heightIncrem);
      }
    }
  }
}
