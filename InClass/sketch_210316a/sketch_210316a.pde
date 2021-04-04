import processing.serial.*;

Serial arduinoPort;
int lf = 10;

int[] sensors;
int pinsUsed;

Smoother knobSmoother;
Smoother sensorSmoother;

void setup() {
  size(1000,1000);
  // setup
  // printArray(Serial.list());
  
  arduinoPort = new Serial(this, "/dev/tty.SLAB_USBtoUART", 9600);
  arduinoPort.bufferUntil(lf);
  
  rectMode(CENTER);
  
  // initialize smoother
  knobSmoother = new Smoother(50);
  sensorSmoother = new Smoother(50);
}

void draw() {
  // draw stuff
  // sensors[0] knob
  // sensors[1] sensor
  // sensors[2] button
  if (pinsUsed == 3) {
    int knobSmoothed = knobSmoother.average(sensors[0]);
    int sensorSmoothed = sensorSmoother.average(sensors[1]);
    
    float colorValue = map(knobSmoothed, 0, 1023, 0, 255);
    
    if (sensors[2] == 0) {
      background(0);
      fill(colorValue);
    } else {
      background(255);
      fill(255 - colorValue);
    }
  
    rect(width/2, height/2, knobSmoothed, sensorSmoothed);
  }
}

void serialEvent(Serial arduinoPort) {
  // what happens when serial data is received
  String inString = arduinoPort.readStringUntil(lf);
  inString = trim(inString);
  int initialReading[] = int(split(inString, '\t'));
  // printArray(initialReading);
  pinsUsed = initialReading.length;
  
  sensors = new int[pinsUsed];
  for (int i=0; i < pinsUsed; i++) {
    sensors[i] = initialReading[i];
    print(i + ": " + sensors[i] + "\t");
  }
  println();
  
  
 
}
