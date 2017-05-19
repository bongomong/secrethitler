

(
~fascist01 = Buffer.read(s, Document.current.path.replace("secrethitlersounds.scd", "sounddata/Breaking Glass Sounds [High Quality Free Download].wav"));
~fascist02 = Buffer.read(s, Document.current.path.replace("secrethitlersounds.scd", "sounddata/Cartoon Sound Effect - Group of Children Laughing.wav"));
~fascist03 = Buffer.read(s, Document.current.path.replace("secrethitlersounds.scd", "sounddata/Clockwork.wav"));
~fascist04 = Buffer.read(s, Document.current.path.replace("secrethitlersounds.scd", "sounddata/Fireplace sound effects.wav"));
~fascist05 = Buffer.read(s, Document.current.path.replace("secrethitlersounds.scd", "sounddata/Flag in wind sound effect.wav"));
~fascist06 = Buffer.read(s, Document.current.path.replace("secrethitlersounds.scd", "sounddata/Hammer SOUND EFFECT.wav"));
~fascist07 = Buffer.read(s, Document.current.path.replace("secrethitlersounds.scd", "sounddata/Metal chains rattling - Sound effects.wav"));
~fascist08 = Buffer.read(s, Document.current.path.replace("secrethitlersounds.scd", "sounddata/Military Marching Sound Effect.wav"));
~fascist09 = Buffer.read(s, Document.current.path.replace("secrethitlersounds.scd", "sounddata/snare drum march snare solo field march drum line snare drum solo.wav"));
~fascist10 = Buffer.read(s, Document.current.path.replace("secrethitlersounds.scd", "sounddata/Tank moving sound effect.wav"));
~fascist11 = Buffer.read(s, Document.current.path.replace("secrethitlersounds.scd", "sounddata/The Great Dictator Speech- Charlie Chaplin.wav"));
)

(
// chooses 3 randomized effects out of 6 for the buffer
g = Ndef.new(\test, { |blubb = 0.3|
	var sig, delay, clip, volosc, gverb, spaceverb, eq, effects, choice;
	//sig = Out.ar(0, PlayBuf.ar(1, b));
	sig = PlayBuf.ar(2, ~fascist02, 1, loop: 1);

	delay = {
		sig = AllpassN.ar(sig, 0.3, 0.25, 3)
	};

	clip = {
		sig = sig.clip;
	};

	volosc = {
		sig = sig * SinOsc.ar(1);
	};

	gverb = {
		sig = GVerb.ar(sig, 10, revtime: blubb);
	};

	spaceverb = {
		var z, y;
		// reverb predelay time :
		z = DelayN.ar(sig, 0.048);
		// 7 length modulated comb delays in parallel :
		y = Mix.ar(Array.fill(7,{ CombL.ar(z, 0.1, LFNoise1.kr(0.1.rand, 0.04, 0.05), 15) }));
		// two parallel chains of 4 allpass delays (8 total) :
		4.do({ y = AllpassN.ar(y, 0.050, [0.050.rand, 0.050.rand], 1) });
		// add original sound to reverb and play it :
		sig = sig+(0.2*y)
	};

	eq = {
		sig = BLowShelf.ar(sig, 1200, 1, -6);
		sig = BPeakEQ.ar(sig, 5000, 1, 3);
		sig = BHiShelf.ar(sig, 7000, 1, 6);
	};

	effects = [delay, clip, volosc, gverb, spaceverb, eq];
	3.do({
		choice = effects.choose.postln;
		choice.value;
		effects.removeAt(effects.indexOf(choice));
	});
		// effects.choose.value;

	sig = Limiter.ar(sig, 1, 0.01);
});
Ndef(\test).fadeTime = 1;
)


g.play
g.stop
g.set(\blubb, rrand(0.5, 4))
g.set

t = Task({ { "I'm loopy".postln; 1.wait;}.loop });
t = Task({ {a = rrand(1.5, 3); b = rrand(7, 10); g.play; a.wait; g.stop(a); b.wait}.loop });
t.play
t.stop


/*

fackel
charlie chaplin
marschieren
wehende fahne
glasbruch
militärtrommel
zahnräder
jugend -> kinderlachen

mitläufertum?

rhythmisch
geordnet

*/