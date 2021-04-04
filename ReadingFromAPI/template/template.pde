/*  Template for working with REST APIs */

// URL of public API_HOST
String api_host = "https://example-123.loca.lt";

// request frequency
// this value should not be less than the INTERVAL in arduino-serial-fetch 
// If it was, we would be requesting data faster than it is updated.
Timer interval = new Timer(200);

// array to store all pin data
int[] pins; 

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
  
  // check first to make sure pins array is populated with data
  // anything using pin data will need to happen within this conditional
  if (pins != null && pins.length > 0) {
    
    // use pins[] as needed
    
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
