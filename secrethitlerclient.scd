(

~nickname = "Blondie";

NetAddr.broadcastFlag = true;
// get your actual network ip via shell command
// ~net = NetAddr.new(Pipe.new("ifconfig en1 | grep \"inet \" | awk '{print $2}'" , "r").getLine, 57120);
~net = NetAddr.new("192.168.178.69", 57120); //temporarily hard coded

// this OSCdef initially sends ip and nickname to the server
OSCdef(\master, { |msg, time, addr|
    "ip versandt".postln;
    ~net.sendMsg(\newPlayer, ~nickname);
}, \master, ~net);

// this OSCdef prints all commands from the server
OSCdef(\depesche, { |msg|
    msg[1].postln;
}, \depesche, ~net);

// this OSCdef opens a gui for the sounds that can be selected as president or chancellor
OSCdef(\prelisten, { |msg|
	var selection;
	selection = msg.drop(1).postln;
	{~prelisten.value(selection)}.defer;
}, \prelisten, ~net);

// this OSCdef opens a gui for the sounds that can be selected as president or chancellor
OSCdef(\choose, { |msg|
	var selection;
	selection = msg.unfoldOSC[1];
	{~choose.value(selection)}.defer;
}, \choose, ~net);

)

~net.sendMsg(\choose, *[["Adolf", "Bertha", "Claus", "Dagmar", "Erich", "Franz"]].foldOSC);

(
// prelisten gui
~prelisten = { |selection|
	var win, but1, but2, but3;
	selection.postln;
	win = Window.new("Prelisten", Rect(200,200,360,100));

	but1 = Button.new(win,Rect(30,40,80,30)).states_([["Play"],["Stop"]]);
	StaticText.new(win,Rect(53,15,80,30)).string_("Sound1");
	but1.action = { if (but1.value.asBoolean) { Ndef(selection[0]).play } { Ndef(selection[0]).free } };

	but2 = Button.new(win,Rect(140,40,80,30)).states_([["Play"],["Stop"]]);
	StaticText.new(win,Rect(163,15,80,30)).string_("Sound2");
	but2.action = { if (but2.value.asBoolean) { Ndef(selection[1]).play } { Ndef(selection[1]).free } };

	if (selection.size == 3) {
		but3 = Button.new(win,Rect(250,40,80,30)).states_([["Play"],["Stop"]]);
		StaticText.new(win,Rect(273,15,80,30)).string_("Sound3");
		but3.action = { if (but3.value.asBoolean) { Ndef(selection[2]).play } { Ndef(selection[2]).free } };
	};

/*	win.onClose = {
		Ndef(selection[0]).free;
		Ndef(selection[1]).free;
		Ndef(selection[2]).free
	};*/

	win.front;
};

// choosePlayer gui
~choose = { |selection|
	selection.postln;
	w = Window.new("Wähle einen Spieler", Rect(200, 400, 30 + (110 * selection.size), 100));

	a = Button.new(w,Rect(30,40,80,30)).states_([[selection[0]]]);
	a.action = {~net.sendMsg(\secrethitler, selection[0])};

	b = Button.new(w,Rect(140,40,80,30)).states_([[selection[1]]]);
	b.action = {~net.sendMsg(\secrethitler, selection[1])};

	if (selection.size > 2) {
		c = Button.new(w,Rect(250,40,80,30)).states_([[selection[2]]]);
		c.action = {~net.sendMsg(\secrethitler, selection[2])};
	};

	if (selection.size > 3) {
		c = Button.new(w,Rect(360,40,80,30)).states_([[selection[3]]]);
		c.action = {~net.sendMsg(\secrethitler, selection[3])};
	};

	if (selection.size > 4) {
		c = Button.new(w,Rect(470,40,80,30)).states_([[selection[4]]]);
		c.action = {~net.sendMsg(\secrethitler, selection[4])};
	};

	if (selection.size > 5) {
		c = Button.new(w,Rect(580,40,80,30)).states_([[selection[5]]]);
		c.action = {~net.sendMsg(\secrethitler, selection[5])};
	};

	if (selection.size > 6) {
		c = Button.new(w,Rect(690,40,80,30)).states_([[selection[6]]]);
		c.action = {~net.sendMsg(\secrethitler, selection[6])};
	};

	if (selection.size > 7) {
		c = Button.new(w,Rect(800,40,80,30)).states_([[selection[7]]]);
		c.action = {~net.sendMsg(\secrethitler, selection[7])};
	};

	if (selection.size > 8) {
		c = Button.new(w,Rect(910,40,80,30)).states_([[selection[8]]]);
		c.action = {~net.sendMsg(\secrethitler, selection[8])};
	};

	if (selection.size > 9) {
		c = Button.new(w,Rect(1020,40,80,30)).states_([[selection[9]]]);
		c.action = {~net.sendMsg(\secrethitler, selection[9])};
	};


	w.front;
};

)




/*

(
~listOfPlayers.postln;
~listOfPlayers[0].sendMsg(\secrethitler, 0);
~playerNicknames.postln;
~listOfRoles.postln;
)

~listOfPlayers[5];
~playerNicknames[5];

~unsuccessfulVoteCounter
~election.value(1, ("nein"!3)
~listOfVotes = "nein"!7
~listOfVotes = "ja"!7
~listOfVotes.postln

~net = NetAddr.new("192.168.178.58", 57120);
~net = NetAddr.new("255.255.255.255", 57120);

(
~initGame.value;
~listOfPlayers[0].sendMsg(\depesche, [1].asOSCArgArray);
~net.sendMsg(\master, 1);
~net.sendMsg(\secrethitler, 1)
~net.sendMsg(\secrethitler, "Franz")
~net.sendMsg(\secrethitler, "nein")
~election.value(1, ["ja", "ja", "ja", "nein", "nein", "nein"])

~net.sendMsg(\prelisten, ~stack[3].key, ~stack[2].key, ~stack[0].key);
~net.sendMsg(\choose, ~playerNicknames);

)




~whoIsChancellor
~whoIsPresident
~lastPresident
~lastChancellor
~lastDepesche.value

~nextFunction.value(0)

~listOfPlayers.indexOfEqual(NetAddr("192.168.178.27", 57120))

NdefMixer(s)
*/
