/* 
 ** Read one sensor from an Arduino
 ** 
 ** - This code will read only one sensor from the Arduino (i.e. will NOT work for more than one)
 ** - One-way communication
 ** - Assumes the Arduino is set to baudrate 9600 and only printing a single sensor reading on each line
*/

import processing.serial.*; // import depedencies
Serial arduinoPort;         // The serial port, named arduinoPort
int lf = 10;                // ASCII control character for linefeed or \n

int sensorValue = 0;        // to store the sensor value

Smoother sensorSmoother;    // call the smoother and declare as sensorSmoother
int sensorSmoothed = 0;     // to store the smoothed value

void setup() { 
  size(1024,1024); 
  // List all the available serial ports: 
  // printArray(Serial.list()); 
  // Open port by list number or name. Match baudrate to Arduino (i.e. 9600)
  arduinoPort = new Serial(this, "/dev/tty.SLAB_USBtoUART", 9600);
  // trigger serialEvent() when a linefeed is read
  arduinoPort.bufferUntil(lf);
  
  // initialize smoother
  // argument is resolution. higher number = more smooth but slower response
  sensorSmoother = new Smoother(10);
} 
 
void draw() { 
  background(0); 
  sensorSmoothed = sensorSmoother.average(sensorValue);
  println(sensorSmoothed);
  ellipse(width/2, height/2, sensorSmoothed, sensorSmoothed);
} 

// serialEvent is called when data is incoming
// see: https://processing.org/reference/libraries/serial/serialEvent_.html
void serialEvent(Serial arduinoPort) { 
  // read a line of data
  String inString = arduinoPort.readString(); 
  // remove whitespace and linefeed
  inString = trim(inString);
  // cast as integer and assign to sensorValue so we can use it in draw()
  sensorValue = int(inString);
}
