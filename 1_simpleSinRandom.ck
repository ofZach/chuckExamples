

SinOsc s => dac; //chuck a sin oscillator to the dac

440 => s.freq; // set the frequency to 440


while( true ) //infinite loop
{
	Std.rand2f( 50, 5000) => s.freq; // chuck a random value to the freq

	(Std.rand2i( 1, 4) * 100)::ms => now; //increment the current time
}