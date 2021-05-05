# Send Data from Processing to the Server

This example adds functionality to the Processing patch that allows you to making API requests from Processing to the server, which allows you to update the values on the server from data you retrieve directly from Processing.

This will enable you to send:

- audio analysis data
- mouse pointer data
- keyboard entry data

This example patch has the following requirements to work:

- You must run [arduino-api-server](https://github.com/soundasobject21/arduino-api-server)
- You must _not_ be using an arduino (we are using the server as a way to communicate remotely between Processing programs)

As-is, the patch won't work well if you want to use an Arduino and Processing in this way, but it isn't impossible! If you are interested in using both, let me know and we can workshop it.

## Getting Started

1. In Processing, add the "HTTP Requests for Processing" library to your Processing libraries.

   ```
   Menu > Sketch > Import Library > Add Library...
   Search for and install "HTTP Requests for Processing"
   ```

2. Make sure you have downloaded the entire `template` folder in this repo and open `template.pde`.
3. Start your API server (this assumes you've done all the configuration as covered in the [quick start guide](https://github.com/soundasobject21/quick-start-api#2-start-your-server-and-api-service-arduino-api-server)
   ```bash
   # arduino-api-server/
   npm run start:tunnel
   ```
4. Run the Processing patch (`template.pde`).

## How it Works

The processing patch runs two threads to send and receive data:

1. sendData: the `sendData()` function creates a `PUT` request that updates data at a given endpoint with the value provided. In the example, the full endpoint is `http://localhost:3000/pins/A0` so we are updating "pin A0" with the `myData` variable, which is the same as `mouseX` data (see line 40).

2. retrieveData: this is the same as when we worked with the API the first time. The `retrieveData()` function retrieves all of the pin data at the API_HOST URL provided, and then parses it out into the `pins[]` array. The `pins[]` array can then be used in the `draw()` loop as needed.
