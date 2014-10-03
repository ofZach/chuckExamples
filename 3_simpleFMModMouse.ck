
0 => int device; //initialize the mouse

SinOsc m => SinOsc c => Envelope e => dac; //we will use an envelope to control the sound so we don't get clicking

// hid objects
Hid mouse;
HidMsg eventMessage;

//floats to store mouse position
float mouseX;
float mouseY;

500 => m.freq; //modulator
220 => c.freq; //carrier

1000 => m.gain; //modulation index

2 => c.sync; //phase driven sync

10::ms => e.duration; //10ms attack and decay
.5 => e.gain; //0.5 strength gain


//try to set up device0 as a mouse, otherwise exit the program
if( !mouse.openMouse( device ) ) me.exit();

while( true )
{
    	mouse => now; // advance time by event

	while(mouse.recv( eventMessage ) )
	{
		if( eventMessage.isMouseMotion() ){
			//set the new mouseX and mouseY changes. 
			//set very low to keep them between -1.0, 1.0
			
			eventMessage.deltaX * .001 + mouseX => mouseX;
			eventMessage.deltaY * .001 + mouseY => mouseY;
			
			//set the frequency and gain based on mouse position
			500 + mouseX*500 => m.freq;
			1000 + mouseY + 1 => m.gain;
		}
		else if( eventMessage.isButtonDown() ){
			e.keyOn();
		}
		else if( eventMessage.isButtonUp() ){
			e.keyOff();
		}
	
		//print the carrier, modulation, and index to the terminal
		<<< "carrier:", c.freq(), "modulator:", m.freq(), "index:", m.gain() >>>;
	}

}