SinOsc m => SinOsc c => Envelope e => dac; //we will use an envelope to control the sound so we don't get clicking


OscRecv recv; // create our OSC receiver
12345 => recv.port; // use port 12345
recv.listen(); // start listening (launch thread)

500 => m.freq; //modulator
220 => c.freq; //carrier

1000 => m.gain; //modulation index

2 => c.sync; //phase driven sync

10::ms => e.duration; //10ms attack and decay
.5 => e.gain; //0.5 strength gain

recv.event( "/mouse/button, i" ) @=> OscEvent mouseState; // boolean to store mouse state, true or false (up or down)
recv.event( "/mouse/x, f" ) @=> OscEvent mouseX; //x position of mouse
recv.event( "/mouse/y, f" ) @=> OscEvent mouseY; //y position of mouse

while( true )
{
	while ( mouseState.nextMsg() != 0 ){ //if there are mouseState messages
		if( mouseState.getInt() == 1 ){ //if the state is true
			e.keyOn(); //turn on our envelope
			<<<"mouse down">>>;
		} else {
			e.keyOff(); //turn off our envelope
			<<<"mouse up">>>;
		}
	}
	
	while ( mouseX.nextMsg() != 0 ){ //if there are mouseX messages
		mouseX.getFloat() => m.freq; //update the modulator frequency
	}
	
	while ( mouseY.nextMsg() != 0 ){ //if there are mouseY messages
		mouseY.getFloat() => c.freq; //update the carrier frequency
	}
	99::ms => now; //increment the current time
}