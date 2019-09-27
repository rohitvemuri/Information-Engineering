float ATTR_COEFF = 15;
int BOX_SIZE = 300, NEUT_RAD_MIN = 20;

class Mover {
  public int id;
  
  private PVector position, velocity, accel;
  
  private float radius;
  private int level;
  
  public Mover(int id, float x, float y, float z) {
    this.id = id;
    
    position = new PVector(x, y, z);
    velocity = new PVector();
    accel = new PVector();
    
    radius = 5;
    level = id % 2;
  }
  
  public void display() {
    pushMatrix();
    
    translate(position.x, position.y, position.z);
    
    if (level == 2)
      fill(120, 120, 255);
    else if (level == 1)
      fill(255, 120, 120);
    else
      fill(120, 255, 120);
    
    noStroke();
    sphere(radius);
    
    popMatrix();
  }
  
  public void update() {
    if (level != 2 && radius > NEUT_RAD_MIN)
      level = 2;
    
    velocity.add(accel);
    position.add(velocity);
    
    if (position.x < -BOX_SIZE + radius) {
      position.x = -BOX_SIZE + radius;
      velocity.x *= -1;
    }
    else if (position.x > BOX_SIZE - radius) {
      position.x = BOX_SIZE - radius;
      velocity.x *= -1;
    }
    
    if (position.y < -BOX_SIZE + radius) {
      position.y = -BOX_SIZE + radius;
      velocity.y *= -1;
    }
    else if (position.y > BOX_SIZE - radius) {
      position.y = BOX_SIZE - radius;
      velocity.y *= -1;
    }
    
    if (position.z < -BOX_SIZE + radius) {
      position.z = -BOX_SIZE + radius;
      velocity.z *= -1;
    }
    else if (position.z > BOX_SIZE - radius) {
      position.z = BOX_SIZE - radius;
      velocity.z *= -1;
    }
    
    velocity.limit(ATTR_COEFF / radius);
    accel.mult(0);
  }
  
  public boolean react(Mover other) {
    PVector forceVec = PVector.sub(other.position, position).normalize();
    float dist = position.dist(other.position);
    
    forceVec.mult(ATTR_COEFF / (radius * dist));
    
    if (level == 0 && level < other.level)
      accel.sub(forceVec);
    else if (level == other.level + 1) {
      accel.add(forceVec);
      
      if (dist < radius + other.radius) {
        radius += other.radius;
        return true;
      }  
    }
    
    return false;
  }  
}
