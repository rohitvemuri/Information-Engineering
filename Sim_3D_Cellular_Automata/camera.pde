import damkjer.ocd.*;

Camera camera;

void setupCamera() {
  camera = new Camera(this, 0, 0, 1200, 0, 0, 0);
}

void handleCamera() {
  if (keyPressed) {
    switch (key) {
      case 'w':
        camera.arc(-0.1);
        break;
      case 's':
        camera.arc(0.1);
        break;
      case 'a':
        camera.circle(0.1);
        break;
      case 'd':
        camera.circle(-0.1);
        break;
      case 'q':
        camera.dolly(-5);
        camera.aim(0, 0, 0);
        break;
      case 'e':
        camera.dolly(5);
        camera.aim(0, 0, 0);
        break;
    }
  }
  
  camera.feed();
}
