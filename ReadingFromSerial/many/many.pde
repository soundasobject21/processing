/* 
 ** Read multiple pins from an Arduino
 ** 
 ** - One-way communication
 ** - Assumes the Arduino is set to baudrate 9600
 ** - Assumes \t as a separator between pins and a linefeed between reading cycles
 ** - Assumes you are using 3 pins and the third is a digital pin
*/

import processing.serial.*; // import depedencies
Serial arduinoPort;    // The serial port, named arduinoPort
String inString;  // Input string from serial port
int lf = 10;      // ASCII linefeed
int pinsUsed;

// store the sensor values in an array
int[] sensors;

void setup() { 
  size(1024,1024); 
  // List all the available serial ports: 
  // printArray(Serial.list()); 
  // Open port by list number or name. Match baudrate to Arduino (i.e. 9600)
  arduinoPort = new Serial(this, "/dev/tty.SLAB_USBtoUART", 9600);
  // trigger serialEvent() when a linefeed is read
  arduinoPort.bufferUntil(lf);
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
    rect((1000 - sensors[0])/2, (1000 - sensors[1])/2, sensors[0], sensors[1]);
  }
} 

// serialEvent() is called when data is incoming
// see: https://processing.org/reference/libraries/serial/serialEvent_.html
void serialEvent(Serial arduinoPort) { 
  // read the serial buffer:
  inString = arduinoPort.readStringUntil(lf);

  // remove the linefeed
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
