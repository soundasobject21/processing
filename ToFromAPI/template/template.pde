/* Update and Receive data using REST APIs */
import http.requests.*;

// URL of your local api
String api_local = "http://localhost:3000";

// URL of the other person's api
String api_host = "https://stephanie-sao2021.serverless.social";

// request frequency
Timer interval = new Timer(200);

// array to store all received pin data
int[] pins; 

// globally scoped variable for whatever data
float myData = 0;

void setup() {
  size(500, 500);
  // start the interval timer
  interval.start();
}

void draw() {
  // check if the interval has elapsed
  if (interval.isFinished()) {
    
    // send the data asynchronously in a thread.
    thread("sendData");
    
    // request the other person's data asynchronously in a thread.
    // thread("retrieveData");
    
    interval.start();
  }
  
  // Update the data variable I am sending
  // (arbitrary example that is using mouseX data)
  myData = mouseX;
  
  // Use the data I am receiving:
  // first check to make sure pins array is populated with data
  // anything using pin data will need to happen within this conditional
  if (pins != null && pins.length > 0) {
    println("pin[0]: " + pins[0]);
    // use pins[] as needed
    
  }
}


// send data function, invoked in a thread
void sendData() {
  // this example updates pin A0 with the value of myData
  // this could update any pin endpoint, just change the request URL below
  // to update multiple pins, you will need to run multiple threads, each with a different PutRequest URL
  PutRequest put = new PutRequest(api_local + "/pins/A0");
  put.addHeader("Content-Type", "application/json");
  put.addData("{\"value\":" + myData + "}");
  put.send();
  
  // show me the data I sent
  System.out.println("Reponse Content: " + put.getContent());
  System.out.println("Reponse Content-Length Header: " + put.getHeader("Content-Length"));
}

// get data function, invoked in a thread
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
