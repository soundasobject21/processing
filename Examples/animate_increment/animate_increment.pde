int i = 0;

void setup(){
 size(900, 600);
 background(255);
}

void draw(){
  
  // ellipse colors
  stroke(119, 84, 222);
  fill(232, 224, 255);
  
  // draw an ellipse with position and dimensions based on `i`
  ellipse(width-i, i, width, i); 
  
  // increment
  i += 3; // like i++ but increment by 3;
  
  // reset if out of visible range
  if (i > height*2) {
    i = 0;
  }
  
}
