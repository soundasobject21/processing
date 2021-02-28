/**
 * Getting Started with Capture.
 * 
 * Reading and displaying an image from an attached Capture device. 
 */

float brightnessX = 0;

import processing.video.*;

Capture cam;

void setup() {
  size(640, 360);

  String[] cameras = Capture.list();

  if (cameras == null) {
    println("Failed to retrieve the list of available cameras, will try the default...");
    cam = new Capture(this, 640, 480);
  } if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    printArray(cameras);

    cam = new Capture(this, cameras[0]);

    cam.start();
  }
}
 
void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  
  brightnessX = map(mouseX, 0, width, 0, 255);
  tint(brightnessX);
  image(cam, 0, 0, width, height);
  
  tint(255,0,0);
  image(cam, mouseX, mouseY, 200, 100);

}