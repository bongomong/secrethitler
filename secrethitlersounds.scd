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
b = Buffer.new;
b = Buffer.read(s, "D:/coding/bongomong/secrethitler/sounddata/The Great Dictator Speech- Charlie Chaplin.wav");
b = Buffer.read(s, "D:/coding/bongomong/secrethitler/sounddata/snare drum march snare solo field march drum line snare drum solo.wav");


(
g = Ndef.new(\penis213, {var sig;
    //sig = Out.ar(0, PlayBuf.ar(1, b));
    sig = PlayBuf.ar(2, b, 1);
    // sig = DelayN.ar(sig, 0.3, [0.4, 0.26]);
    // sig = AllpassN.ar(sig, 0.05, {Rand(0.01, 0.1)}.dup(2), 2);
    // sig = OnePole.ar(sig, 0.1, 200);
    sig = sig.clip;
    // sig = sig * SinOsc.ar(0.05)*0.5;
    sig = GVerb.ar(sig, 6, revtime:7);
    // sig = Phasor.ar(sig, 0.02);
    // sig = sig * EnvGen.kr(Env.perc(3, 5), doneAction: 1);
    sig = Limiter.ar(sig, 0.95, 0.01);
})
)

g.play

t = Task({ { "I'm loopy".postln; 1.wait;}.loop });
t = Task({ {a = 3.rand; g.play; a.wait; g.stop; a.wait}.loop });
t.start
(
loop {

    "hello".postln;
    1.wait;
}
).start
//
// PlayBuf.ar(2, b)
//
// {SoundIn.ar(0).fold2(0.3) * 0.2}.play
//
// using fold2 works well, as does clip
//
// {SoundIn.ar(0).clip2(0.3) * 0.2}.play
//
// and there's also the obviously titled distort
//
// {SoundIn.ar(0).distort}.play