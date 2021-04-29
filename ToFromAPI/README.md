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

## Getting Start

1. In Processing, add the "Simple Http Server" library to your Processing libraries.

   ```
   Menu > Sketch > Import Library > Add Library...
   Search for and install "Simple Http Server"
   ```

2. Make sure you have downloaded the entire `main` folder in this repo and open `main.pde`.
3. Start your API server (this assumes you've done all the configuration as covered in the [quick start guide](https://github.com/soundasobject21/quick-start-api#2-start-your-server-and-api-service-arduino-api-server)
   ```bash
   # arduino-api-server/
   npm run start:tunnel
   ```
