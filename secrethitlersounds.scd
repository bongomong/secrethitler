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

b = Buffer.read(s, "/Users/admin/Desktop/Sebastian/Musik und Medien/MI/2016 VM/secrethitler/Flag in wind sound effect.wav");


(
g = Ndef.new(\penis213, {var sig;
	//sig = Out.ar(0, PlayBuf.ar(1, b));
	sig = PlayBuf.ar(2, b, 1);
	sig = sig;
	//sig = sig * EnvGen.kr(Env.perc(3, 1), doneAction: 1);
	sig = sig.distort.distort.distort.clip;
	sig = sig * sig;
})
)

g.play

PlayBuf.ar(2, b)

{SoundIn.ar(0).fold2(0.3) * 0.2}.play

using fold2 works well, as does clip

{SoundIn.ar(0).clip2(0.3) * 0.2}.play

and there's also the obviously titled distort

{SoundIn.ar(0).distort}.play