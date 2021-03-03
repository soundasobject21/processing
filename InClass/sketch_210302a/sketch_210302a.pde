void setup() {
  // run setup code
  size(500, 400);
  rectMode(CENTER);
}
void draw() {
  // main drawing program
  if (mousePressed) {
    background(255);
  } else {
    background(0);
  }
  
  noStroke();
  
  float mappedValue = map(mouseX, 0, width, 0, 255);
  if (mousePressed) {
    fill(mappedValue, mouseY, 7, 100);
  } else {
    fill(179, 41, 162);
  }

  ellipse(width/2, height/2, mouseY/2, mouseX/2);
  
  fill(mappedValue, mouseY, 7, 100);
  rect(mouseX, mouseY, 50, 150);
  
  
}
