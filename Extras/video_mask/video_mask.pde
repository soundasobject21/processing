import processing.video.*;
Capture cam;
PGraphics mask;

void setup() {
  // set canvas size to same aspect ratio as camera
  // size(640, 480);
  fullScreen();
  
  // initialize mask
  mask = createGraphics(width, height, JAVA2D);
  
  // set up camera
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

    // The camera can be initialized directly using an element
    // from the array returned by list():
    cam = new Capture(this, width, height, cameras[0]);
    // Or, the settings can be defined based on the text in the list
    //cam = new Capture(this, 640, 480, "Built-in iSight", 30);
    
    // Start capturing the images from the camera
    cam.start();
        
  }
}

void draw() {
  background(0);
  
  // Read the video feed
  if (cam.available() == true) {
    cam.read();
  } 
  
  // Create the mask drawing in memory
  mask.beginDraw();
  mask.background(0);
  mask.noStroke();
  mask.ellipseMode(CENTER);
  mask.ellipse(width/2, height/2, mouseX/2, mouseY/2);
  mask.endDraw();
  
  // Mask the camera feed data
  cam.mask(mask);
  
  // Draw the masked feed
  image(cam, 0, 0, width, height);
}
