class Smoother {
  
  // init variables
  int numReadings;
  int[] readings;                     // the readings from the analog input (Array)
  int readIndex;                      // the index of the current reading
  int total;                          // the running total
  int average;                        // the average  
  
  // Constructor / Class Setup
  Smoother (int resolution) {
    numReadings = resolution;
    readings = new int[numReadings];  // the readings from the analog input (Array)
    readIndex = 0;                    // the index of the current reading
    total = 0;                        // the running total
    average = 0;                      // the average  
    
    for (int thisReading = 0; thisReading < numReadings; thisReading++) {
      readings[thisReading] = 0;
    } 
    
  }
 
  int average(int data) {
    total = total - readings[readIndex];          // subtract the last reading
    readings[readIndex] = data;                   // read from the sensor
    total = total + readings[readIndex];          // add the reading to the total
    readIndex = readIndex + 1;                    // advance to the next position in the array
    
    // if we're at the end of the array...
    if (readIndex >= numReadings) {
      // ...wrap around to the beginning:
      readIndex = 0;
    }
  
    average = total / numReadings;       // calculate the average
    
    return average;                    
  }  
}
