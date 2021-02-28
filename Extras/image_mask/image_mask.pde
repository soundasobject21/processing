/*
 * Image with a dynamically drawn mask
 */

PImage myCoolPhoto;
PGraphics mask;

void setup() {
  size(900,700);
  
  // load image
  myCoolPhoto = loadImage("schoolbus.jpg");
  
  // initialize mask. dimenions must match that of the image file being masked
  mask = createGraphics(480, 360, JAVA2D);
  
  // coordinates are relative to the center of images rather than top left
  imageMode(CENTER);
}

void draw() {
  background(0);
  
  // Create the mask drawing in memory
  // all mask dimensions must match those of the image file it is masking
  mask.beginDraw();
  mask.background(0);
  mask.noStroke();
  mask.ellipseMode(CENTER);
  mask.ellipse(480/2, 360/2, mouseX/2, mouseY/2);
  if (mousePressed) {
    // click to reveal
    mask.rect(0, 0, 480, 360);
  }
  mask.endDraw();
  
  // mask the image
  myCoolPhoto.mask(mask);
  
  // draw the masked image in the center of the canvas and at the same size of the canvas
  image(myCoolPhoto, width/2, height/2, width, height);
}
