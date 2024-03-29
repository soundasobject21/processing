/* 
 ** Read multiple pins from an Arduino
 ** 
 ** - One-way communication
 ** - Assumes the Arduino is set to baudrate 9600
 ** - Assumes \t as a separator between pins and a linefeed between reading cycles
 ** - Assumes you are using 3 pins and the third is a digital pin
*/

import processing.serial.*; // import depedencies
Serial arduinoPort;         // The serial port, named arduinoPort
int lf = 10;                // ASCII control character for linefeed or \n
int pinsUsed;               // Initializes when serial data is read. See serialEvent()

int[] sensors;              // to store the sensor values in an array

Smoother sensorSmoother0;   // call the smoother and declare as many as you need
Smoother sensorSmoother1;

int sensorSmoothed0 = 0;    // store smoothed values
int sensorSmoothed1 = 0;
  
void setup() { 
  size(1024,1024); 
  // List all the available serial ports: 
  // printArray(Serial.list()); 
  // Open port by list number or name. Match baudrate to Arduino (i.e. 9600)
  arduinoPort = new Serial(this, "/dev/tty.SLAB_USBtoUART", 9600);
  // trigger serialEvent() when a linefeed is read
  arduinoPort.bufferUntil(lf);
  
  // initialize smoothers w/ desired resolution
  sensorSmoother0 = new Smoother(10);
  sensorSmoother1 = new Smoother(10);
} 
 
void draw() { 
    // make sure sensors[] has enough data in it
  if (sensors != null && sensors.length == pinsUsed) {
    // sensors[0] is the reading from pin A0
    // sensors[1] is the reading from pin A1
    // sensors[2] is the reading from pin 2
    if (sensors[2] == 0) {
      background(0); 
      fill(255);
    } else {
      background(255);
      fill(0);
    }
    sensorSmoothed0 = sensorSmoother0.average(sensors[0]);
    sensorSmoothed1 = sensorSmoother1.average(sensors[1]);
    rect((1000 - sensorSmoothed0)/2, (1000 - sensorSmoothed1)/2, sensorSmoothed0, sensorSmoothed1);
  }
} 

// serialEvent is called when data is incoming
// see: https://processing.org/reference/libraries/serial/serialEvent_.html
void serialEvent(Serial arduinoPort) 
{ 
  // read a line of data
  String inString = arduinoPort.readStringUntil(lf);

  // remove whitespace and linefeed
  inString = trim(inString);
  // split the string at the tabs and convert the sections into integers, scoped locally
  int initialReading[] = int(split(inString, '\t'));
  // initialize our globally scoped sensor array with a matching array length
  pinsUsed = initialReading.length;
  sensors = new int[pinsUsed];
  for (int i=0; i < pinsUsed; i++) {
    // set sensor[i] value for use in draw()
    sensors[i] = initialReading[i];
    print(i + ": " + sensors[i] + "\t");
  }
  println();

}
