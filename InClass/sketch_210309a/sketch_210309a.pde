/* 
 * Simple amplitude analyzer that will 
 * allow you to change draw parameters 
 * based on how loud the mic input is
 * 
 * I encourage you to browse other examples
 * using the Sound library by going to the 
 * File Menu > Examples > Libraries > Sound
 * 
*/

import processing.sound.*;


Amplitude amp;
AudioIn mic;
Sound s;

void setup() { 
  size(900,600); 

  // Audio setup
  
  // view the list of avilable inputs to know which input device you want
  // note: you may need to comment out the println(amp.analyze()); line in draw() to be able to read the list
  Sound.list();
  
  // init sound library and set input device
  s = new Sound(this);
  s.inputDevice(1);
  
  // init amplitude follower
  amp = new Amplitude(this);
  
  // init audio input
  mic = new AudioIn(this, 0);
  
  // start mic
  mic.start();
  
  // set amplitude follower to process the mic input
  amp.input(mic);
}

void draw() {
  // print out amplitude measurements
  // comment out this line when you are trying to view the Sound.list() in the setup function
  println(amp.analyze());
  
  // amplitude is a float that ranges between 0-1
  // map accordingly!
  // float multipliedValue = amp.analyze()*255;
  float mappedValue = map(amp.analyze(), 0, 1, 0, 255);
  background(mappedValue);
}
