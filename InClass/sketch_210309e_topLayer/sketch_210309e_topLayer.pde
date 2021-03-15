import processing.video.*; 
 
Capture cam;

PGraphics topLayer;

void setup() 
{ 
  size(640, 480); 
  String[] cameras = Capture.list();
  cam = new Capture(this, cameras[0]);
  topLayer = createGraphics(width, height);
} 

void draw() 
{ 
  cam.start();
  if (cam.available() == true) {
    cam.read();
  }
  
  // draw the camera feed first
  image(cam, 0, 0, width, height);
  
  // draw inside the topLayer (not yet visible)
  topLayer.beginDraw();
  topLayer.noFill();
  topLayer.stroke( 255 );
  topLayer.line(pmouseX, pmouseY, mouseX, mouseY);
  topLayer.endDraw();
  
  // draw the topLayer last (now visible)
  image( topLayer, 0, 0 );
} 
 
 
