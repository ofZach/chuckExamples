

SinOsc m => SinOsc c => dac;

1 => m.freq; //modulator
500 => c.freq; //carrier

100 => m.gain; //modulation index

2 => c.sync; 
//explanation of sync:
// - -- - - -- - - - - - - - -- 
//0 => c.sync is Internal Time
// the oscillator phase comes from its own internal clock that increments 
// each time a sample is output

//1 => c.sync is Global Time
// the oscillator phase follows the global clock.

//2 => c.sync is Phase Driven
//the oscillator phase is specified by the value that has been chucked 
//to it. in this case, the m.freq.


while( true )
{
	99::ms => now;
}