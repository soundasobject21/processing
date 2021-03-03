// using images
PImage myPhoto;

void setup() {
  size(1024,768);
  // fullScreen();
  myPhoto = loadImage("cat.jpeg");
  imageMode(CENTER);
}

void draw() {
  // draw here
  background(0);
  image(myPhoto, mouseX, mouseY);
}
