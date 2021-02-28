PImage cat;
PImage pizza;
PImage shop;
PImage space;

void setup() {
  size(500, 333);
  // load image files into PImage vars
  // image file location is relative to this .pde file
  cat = loadImage("cat.png");
  pizza = loadImage("pizza.png");
  shop = loadImage("pizzashop.jpg");
  space = loadImage("space.jpg");
  
} // end setup

void draw() {
  background(255);
  
  tint(255, 120, 30);
  image(shop, 0, 0);
  tint(255, 100);
  image(cat, mouseX-50, mouseY-50, mouseX, mouseY);
  tint(0, 255, 0, 255);
  image(pizza, mouseY, mouseX, 200, 100);
  
  if(mousePressed) {
    image(space, 0, 0);
    image(pizza, width/2-100, height/2-50, 200, 100);
    image(cat, width/2-50, height/2-50, 100, 100);
  } // end if
  
} // end draw
