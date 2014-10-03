


SinOsc s => dac; //chuck a sin oscillator to the dac
440 => s.freq; // set the frequency to 440

while( true ) //infinite loop
{
	99::ms => now; //increment the current time
}