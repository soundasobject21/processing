/*  Working with REST APIs
 ** References:
 ** - https://processing.org/tutorials/data/
 ** - https://processing.org/reference/thread_.html
 ** - https://processing.org/reference/JSONObject.html
 */

// URL of public API_HOST
String api_host = "https://example-123.loca.lt";

// request frequency
// this value should not be less than the INTERVAL in arduino-serial-fetch 
// If it was, we would be requesting data faster than it is updated.
Timer interval = new Timer(200);

// array to store all pin data
int[] pins; 

// smoother
Smoother mySmoother0 = new Smoother(20);
Smoother mySmoother1 = new Smoother(20);

int pinSmoothed0 = 0;
int pinSmoothed1 = 0;

void setup() {
  size(500, 500);
  // start the interval timer
  interval.start();
}

void draw() {
  
  // check if the interval has elapsed
  if (interval.isFinished()) {
    // request the data asynchronously in a thread.
    thread("retrieveData");
    interval.start();
  }
  
  background(255);
  
  // check first to make sure pins array is populated with data
  // anything using pin data will need to happen within this conditional
  if (pins != null && pins.length > 0) {
    
    // create smoothed values
    pinSmoothed0 = mySmoother0.average(pins[0]);
    pinSmoothed1 = mySmoother1.average(pins[1]);

    // map some values to use for colors
    float redVal = map(pinSmoothed0, 0, 1023, 0, 255);
    float greenVal = map(pinSmoothed1, 0, 1023, 0, 255);
    float blueVal = map(pins[8], 0, 1, 0, 255);
    
    // draw a background color based on data input
    background(redVal, greenVal, blueVal);
    
    // invert text and stroke colors so they will stay visible
    fill(255-redVal, 255-greenVal, 255-blueVal);
    stroke(255-redVal, 255-greenVal, 255-blueVal);
    
    // draw a line to show input values
    // A0: pins[0]
    float mappedVal0 = map(pinSmoothed0, 0, 1023, height, 0);
    line(0, mappedVal0, width/3, mappedVal0);
    
    // A1: pins[1]
    float mappedVal1 = map(pinSmoothed1, 0, 1023, height, 0);
    line(width/3, mappedVal1, 2*width/3, mappedVal1);
    
    // D2: pins[8]
    float mappedVal2 = map(pins[8], 0, 1, 0, height);
    line(2*width/3, mappedVal2, width, mappedVal2);
    
    // write the value of the mappedVals
    text(mappedVal1, 40, 100);
    text(mappedVal1, 40+width/3, 100);
    text(mappedVal2, 40+(2*width/3), 100);
    
    // draw a little animation to demonstrate that the draw() loop never pauses.
    translate(20, 95);
    rotate(frameCount*0.04);
    for (int i = 0; i<10; i++) {
      rotate(radians(36));
      line(5, 0, 10, 0);
    }
  }
}

// get the data
void retrieveData() {
  JSONArray allPins = loadJSONArray(api_host + "/pins");

  // init the pins array to be the same size as allPins
  pins = new int[allPins.size()];
  
  // step through allPins reassign to the pins array for global use
  for (int i = 0; i < allPins.size(); i++) {
    JSONObject pin = allPins.getJSONObject(i); 
    pins[i] = pin.getInt("value");
    // see which array index corresponds to which pin. comment this out when not needed.
    // println("["+i+"]" + "\t" + pin.getString("id") + "\t" + pin.getInt("value"));
  }

}
