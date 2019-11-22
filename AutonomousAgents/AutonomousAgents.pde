Maze maze;
Solver solver;

void setup() {
  size(800, 800);
  
  maze = new Maze(41);
  
  solver = new Solver(new PVector(1, 1), new PVector(39, 39)); 
}

void draw() {
  maze.display();
  
  solver.update();
  solver.display();
  
  fill(0);
  textSize(16);
  text(frameCount / frameRate, 16, 16);
}
