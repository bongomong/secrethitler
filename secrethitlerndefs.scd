(

Ndef(\fascist01, {

    var car, mod;
    mod = SinOsc.kr(2);
    car = SinOsc.ar(mod * 1933 + 18);

    car * 0.03 ! 2

}).add;

Ndef(\fascist02, {

    var car, mod;
    mod = SinOsc.kr(2);
    car = SinOsc.ar(mod * 1933 + 88);

    car * 0.03 ! 2

}).add;

Ndef(\fascist03, {

    var car, mod;
    mod = SinOsc.kr(2);
    car = SinOsc.ar(mod * 1933 + 420);

    car * 0.03 ! 2

}).add;

Ndef(\fascist04, {

    var car, mod;
    mod = SinOsc.kr(2);
    car = SinOsc.ar(mod * 1933 + 911);

    car * 0.03 ! 2

}).add;

Ndef(\fascist05, {

    var car, mod;
    mod = SinOsc.kr(2);
    car = SinOsc.ar(mod * 1933 + 1000);

    car * 0.03 ! 2

}).add;

Ndef(\fascist06, {

    var car, mod;
    mod = SinOsc.kr(2);
    car = SinOsc.ar(mod * 1933 + 900);

    car * 0.03 ! 2

}).add;

Ndef(\fascist07, {

    var car, mod;
    mod = SinOsc.kr(2);
    car = SinOsc.ar(mod * 1933 + 723);

    car * 0.03 ! 2

}).add;

Ndef(\fascist08, {

    var car, mod;
    mod = SinOsc.kr(2);
    car = SinOsc.ar(mod * 1933 + 245);

    car * 0.03 ! 2

}).add;

Ndef(\fascist09, {

    var car, mod;
    mod = SinOsc.kr(2);
    car = SinOsc.ar(mod * 1933 + 3490);

    car * 0.03 ! 2

}).add;

Ndef(\fascist10, {

    var car, mod;
    mod = SinOsc.kr(2);
    car = SinOsc.ar(mod * 1933 + 317);

    car * 0.03 ! 2

}).add;

Ndef(\fascist11, {

    var car, mod;
    mod = SinOsc.kr(2);
    car = SinOsc.ar(mod * 1933 + 2016);

    car * 0.03 ! 2

}).add;

Ndef(\liberal01, {

    var car, mod, depth, freq;

    mod = SinOsc.ar([282, 314.15, 188]);
    depth = SinOsc.kr(0.2).exprange(0.01, 10) * [1, 0.3, 2];
    freq = [122.4, 320, 701.5] * 0.2;
    car = SinOsc.ar(freq, mod * depth);

    Splay.ar(car) * 0.1

}).add;

Ndef(\liberal02, {

    var car, mod, depth, freq;

    mod = SinOsc.ar([282, 314.15, 188]);
    depth = SinOsc.kr(0.2).exprange(0.01, 10) * [1, 0.3, 2];
    freq = [417, 809, 1211] * 0.2;
    car = SinOsc.ar(freq, mod * depth);

    Splay.ar(car) * 0.1

}).add;

Ndef(\liberal03, {

    var car, mod, depth, freq;

    mod = SinOsc.ar([282, 314.15, 188]);
    depth = SinOsc.kr(0.2).exprange(0.01, 10) * [1, 0.3, 2];
    freq = [160, 584, 1894] * 0.2;
    car = SinOsc.ar(freq, mod * depth);

    Splay.ar(car) * 0.1

}).add;

Ndef(\liberal04, {

    var car, mod, depth, freq;

    mod = SinOsc.ar([282, 314.15, 188]);
    depth = SinOsc.kr(0.2).exprange(0.01, 10) * [1, 0.3, 2];
    freq = [1111, 1222, 1333] * 0.2;
    car = SinOsc.ar(freq, mod * depth);

    Splay.ar(car) * 0.1

}).add;

Ndef(\liberal05, {

    var car, mod, depth, freq;

    mod = SinOsc.ar([282, 314.15, 188]);
    depth = SinOsc.kr(0.2).exprange(0.01, 10) * [1, 0.3, 2];
    freq = [318, 517, 716] * 0.2;
    car = SinOsc.ar(freq, mod * depth);

    Splay.ar(car) * 0.1

}).add;

Ndef(\liberal06, {

    var car, mod, depth, freq;

    mod = SinOsc.ar([282, 314.15, 188]);
    depth = SinOsc.kr(0.2).exprange(0.01, 10) * [1, 0.3, 2];
    freq = [700, 2118, 5841] * 0.2;
    car = SinOsc.ar(freq, mod * depth);

    Splay.ar(car) * 0.1

}).add;

)
Ndef.clear
NdefMixer(s)
Ndef(\liberal01).stop
Ndef(\liberal06).stop;
Ndef(\fascist08).play;

Ndef(\fascist01).stop;
Ndef(\fascist02).stop;