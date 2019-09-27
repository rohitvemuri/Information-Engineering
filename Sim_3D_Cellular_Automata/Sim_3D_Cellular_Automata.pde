ArrayList<Mover> movers;
int count = 50;

void setup() {
  size(1280, 720, P3D);
  
  movers = new ArrayList();
  
  for (int i = 0; i < count; i++) {
    movers.add(new Mover(i, random(200) - 100, random(200) - 100, random(100) - 50)); 
  }
  
  setupCamera();
}

void draw() {
  background(125);
  
  for (int i = 0; i < count; i++) {
    Mover mov = movers.get(i);
    
    for (int j = count - 1; j >= 0; j--) {
      if (mov.id != j && mov.react(movers.get(j)))
        movers.remove(j);
    }
    
    mov.update();
    mov.display();
    
    count = movers.size();
  }
  
  stroke(255);
  noFill();
  box(BOX_SIZE * 2);
  
  handleCamera();
  
  if (frameCount % 100 == 0)
    movers.add(new Mover(count + 1, random(200) - 100, random(200) - 100, random(100) - 50));
}
