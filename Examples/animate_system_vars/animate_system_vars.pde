void setup(){
 size(900, 600);
 background(255);
}

void draw(){
  // clear canvas with each draw
  if (mousePressed) {
    background(0); // black
  } else {
    background(255); // white
  }
  
  // no stroke for anything drawn after this point
  noStroke();
  
  // RECTANGLE STUFF ----------------------------------
  // rectangle fill changes if mouse is pressed
  if (mousePressed) {
    // green
    fill(140, 222, 82);
  } else {
    // purple
    fill(119, 84, 222);
  }
  // rectangle placed at center of mouse pointer
  // always 50x50 dimensions
  rect(mouseX-25, mouseY-25, 50, 50);
  
  // ELLIPSE STUFF ------------------------------------
  // ellipse fill changes if mouse is pressed
  if (mousePressed) {
    // light green, slightly transparent
    fill(236, 255, 224, 200);
  } else {
    // light purple, slightly transparent
    fill(232, 224, 255, 220);
  }
  // ellipse placed at center of canvas
  // dimensions based on mouse pointer
  ellipse(width/2, height/2, mouseX/2, mouseY/2);
  
}
