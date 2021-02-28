/*
 * Image with a mask created from an image file
 *
 * IMPORTANT: mask file must be the same
 * dimensions as the image it is masking
 *
 * Useful if the mask is a complex, but it's more limiting 
 * (can't change dimensions on the fly, etc.)
 *
 */

PImage myCoolPhoto;
PImage imgMask;
void setup() {
  size(800,800);
  myCoolPhoto = loadImage("schoolbus.jpg");
  imgMask = loadImage("mask_circle.jpg");
  myCoolPhoto.mask(imgMask);
  imageMode(CENTER);
}

void draw() {
  background(0);
  image(myCoolPhoto, mouseX, mouseY, mouseX, mouseY);
}
