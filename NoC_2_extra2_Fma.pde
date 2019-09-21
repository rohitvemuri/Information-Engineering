/* James S 9/20/19
Newton's Laws
Information Engineering  '19-20     St. Mark's School of Texas 

Code Abstract: Newton's Second Law: F=ma

Source(s): Created using https://natureofcode.com/book/

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License v3 as published by the Free
Software Foundation
*/

float mass;
PVector position;
PVector velocity;
PVector acceleration;
PVector newForce;
PVector i = new PVector (0.1,0);
PVector j = new PVector (0,0.1);
int size = 20;

void setup() {
  surface.setResizable(true);
  size(1600,900);
  background(0);
  frameRate(60);
  
  mass = 1;
  position = new PVector (width/2,height/2);
  velocity = new PVector (0,0);
  acceleration = new PVector (0,0);
  newForce = new PVector (0,0);
  ellipse(position.x,position.y,size,size);
}

void draw() {
  background(0);
  
  //bounce the ball
  if ((position.x>width) || (position.x<0)) {
    velocity.x=velocity.x*-1;
  }
  if ((position.y>height) || (position.y<0)) {
    velocity.y=velocity.y*-1;
  }
  
  //respawn the ball if it accidentally exits the boundaries
  if ((position.x>0 || position.x<width) || (position.y>0 || position.y<height)) {
    velocity.add(acceleration);
    position.add(velocity);
  } else {
    position = new PVector (width/2,height/2);
  }
  
  //draw the ball
  stroke(0);
  fill(255);
  ellipse(position.x,position.y,size,size);
  
  //calculate the amount of force applied to the ball
  newForce.x = acceleration.x*mass;
  newForce.y = acceleration.y*mass;
  
  //show instructions and how much acceleration, mass, and force is currently on the ball
  textSize(20);
  text("Press up or down to change the x component of acceleration", 200, 780);
  text("Press left or right to change the y component of acceleration", 200, 800);
  text("Press period or comma to change the masss", 200, 820);
  text("Press r to reset the program", 200, 840);
  text("acceleration = ("+acceleration.x+", "+(acceleration.y*-1)+") N",1000,780);
  text("mass = "+mass+" g",1000,800);
  text("force = ("+newForce.x+", "+(newForce.y*-1)+") N",1000,820);
  textSize(50);
  text("F=ma Demonstration", width/2-250, 100);
}

void keyPressed() {
  //increase/decrease acceleration
  if (key == CODED) {
    if (keyCode == RIGHT) {
      acceleration.add(i);
    } if (keyCode == LEFT) {
      acceleration.sub(i);
    } if (keyCode == UP) {
      acceleration.sub(j);
    } if (keyCode == DOWN) {
      acceleration.add(j);
    } 
  }
  
  //increase mass or reset the program
  if (keyPressed) {
    if (key == '.') {
      mass = mass+0.1;
    } if (key == ',') {
      if (mass > 0) {
      mass = mass-0.1;
      } else if (mass < 0) {
        mass = 0;
      }
    }
    if (key == 'r' || key == 'R') {
      mass = 1;
      velocity = new PVector (0,0);
      position = new PVector (width/2,height/2);
      acceleration = new PVector (0,0);
      newForce = new PVector (0,0);
    }
  }
}
