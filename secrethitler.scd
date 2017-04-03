// https:// secrethitler.online/
// https:// de.wikipedia.org/wiki/Secret_Hitler

(
~nextFunction = ~initGame;

~initGame = {
	~stack = List.new;		// Nachziehstapel (.at(0) --> oberste Karte)
	~trash = List.new;		// Ablagestapel	(.at(0) --> unterste Karte)
	~hand = List.new;		// Hand wird jede Runde überschrieben
	~amountf = 11;			// Anzahl Faschistenkarten
	~amountl = 6;			// Anzahl Liberalenkarten
	~fasstack = List.new;	// Stapel der Faschistenkarten
	~libstack = List.new;	// Stapel der Liberalenkarten
	~listOfPlayers = ['192.168.178.26', '192.168.178.27', '192.168.178.28', '192.168.178.29', '192.168.178.30', '192.168.178.31'];		//contains ip addresses of players as symbols TEMPORARILY HARDCODED
	~playerNicknames = [\0, \1, \2, \3, \4, \5];		//contains nicknames of players as symbols TEMPORARILY HARDCODED
	~listOfRoles = List.new;
	~whoHasHand = nil;
	~whoIsPresident = nil;
	~presidentNetAddress = NetAddr.new;
	~possiblePresidentIndizes = List.new;
	~presidentIndex = nil;
	~chancellor = nil;
	~chancellorNetAddress = NetAddr.new;
	~lastPresident = nil;
	~lastChancellor = nil;
	~listOfVotes = nil!6;
	~gamestart.value;
};

~gamestart = {
	~possiblePresidentIndizes = (..~listOfPlayers.size -1);
	~giveRoles.value;
	~createStack.value;
	~rolePresident.value;
	~setPresidentIP.value;
	~nextFunction = ~chooseChancellor;
	~sendToPresident.value("Du bist Präsident! Bitte wähle einen Kanzler!");
};

//roles the roles of the players: 0 = fascist, 1 = liberal, 2 = hitler
~giveRoles = {
	var numberOfPlayers, lib, fas;
	numberOfPlayers = ~listOfPlayers.size;
	if(numberOfPlayers.odd) {lib = numberOfPlayers + 1 / 2} {lib = numberOfPlayers +2 / 2};
	fas = numberOfPlayers - lib - 1;
	~listOfRoles = ((0 ! fas) ++ (1 ! lib) ++ 2).scramble;
	"Die Rollen wurden verteilt:".postln;
	~listOfRoles.postln;
};

~createStack = {
	// BROKEN wegen ~listOfPlayers
	// Erstellt gemischten Nachziehstapel (0 --> Faschistenkarte, 1 --> Lieberalenkarte)
	// Später können hier statt 0 und 1 Ndefs abgelegt werden
	~stack = ((0 ! ~amountf) ++ (1 ! ~amountl)).scramble;
	"Ein neues Spiel hat begonnen: ".postln;
	~check.value;
};

~rolePresident = {
	~presidentIndex = ~possiblePresidentIndizes.choose;
	~whoIsPresident = ~listOfPlayers[~presidentIndex];
	("Der erste Präsident ist:" + ~whoIsPresident).postln;
};

~setPresidentIP = {
	~presidentNetAddress = NetAddr(~whoIsPresident.asString, 57120);
	~presidentNetAddress.postln;
};

~sendToPresident = { |msg|
	~presidentNetAddress.sendMsg(\depesche, msg.asString);
};

~sendToChancellor = { |msg|
	~chancellorNetAddress.sendMsg(\depesche, msg.asString);
};

~sendToAll = { |msg|
	for (1, ~listOfPlayers.size, { arg i;
		NetAddr.new(~listOfPlayers[i - 1].asString, 57120).sendMsg(\depesche, msg.asString)
	})
};

~chooseChancellor = { |chancellor|
	var chancellorIP;
	// präsident wählt kanzler, check1 ob spieler existiert, check2 ob spieler letzter kanzler oder präsident war (darf nicht wiedergewählt werden)
	//TODO: 5bis6 spieler darf letzter präsident gewählt werden
	chancellorIP = ~listOfPlayers[~playerNicknames.indexOf(chancellor.asSymbol)];
	if(~playerNicknames.includes(chancellor.asSymbol)) {
		if(and(~whoIsChancellor != chancellorIP, ~whoIsPresident != chancellorIP)) {
			~whoIsChancellor = chancellorIP;	//TODO: Wahl geht noch immer durch
			//~getPolls(chancellor).value;
			(chancellor.asString + "is new chancellor").postln;
			~nextFunction = ~draw;
		} {
			"This player is not electable!".postln
		}
	} {
		"This player doesn't exist!".postln
	}
};

/*
~getPolls = { |candidat, playerIP|
	var votes;
	if(~listOfVotes.includes(nil) == false, {
		~election(candidat, votes)
	});
};
*/

~election = { |candidat, thePolls|
	// checks if the chancellor has been elected
	var ja = 0, nein = 0;
	thePolls.do({ arg item;
		if(item == "ja", {ja = ja + 1});
		if(item == "nein", {nein = nein + 1});
	});
	if(ja > nein, {
		"Der Kanzler wurde gewählt".postln;
		~lastChancellor = ~whoIsChancellor;
		~whoIsChancellor = candidat;
		~nextFunction = ~draw
	}, {
		"Der Kanzler wurde nicht gewählt".postln;
		~nextFunction = ~chooseChancellor
	});
	~listOfVotes = nil!6;
};

~draw = {
	// Zieht drei Karten vom Nachziehstapel und erstellt daraus eine Hand
	~hand = ~stack.keep(3);
	~stack = ~stack.drop(3);
	"Drei Karten wurden gezogen: ".postln;
	~nextFunction = ~passTwo;
	~check.value;
};

~passTwo = {|discard = 0|
	// Legt eine Karte aus der Hand auf den Ablagestapel
	~trash.add(~hand.removeAt(discard));
	"Zwei Karten wurden weitergegeben, eine abgelegt: ".postln;
	~nextFunction = ~reveal;
	~check.value;
};

~reveal = {|discard = 0|
	// Legt von den verbleibenden zwei Karten eine auf den Ablagestapel und legt die andere entweder auf den Liberalenstapel oder den Faschistenstapel
	~trash.add(~hand.removeAt(discard));
	if(~hand.at(0) == 0, {~fasstack.add(~hand.at(0))}, {~libstack.add(~hand.at(0))});
	~hand = List.new;
	"Eine Karte wurde aufgedeckt, eine abgelegt: ".postln;
	~check.value;
	//sets new president and remembers who was the last one
	~lastPresident = ~whoIsPresident;
	~presidentIndex = ~presidentIndex + 1 % ~possiblePresidentIndizes.size;
	~whoIsPresident = ~listOfPlayers[~presidentIndex];
	(~whoIsPresident.asString + "ist neuer Präsident").postln;
	// Sollten im Nachziehstapel weniger als 3 Karten sein, wird der Ablagestapel wieder in den Nachziehstapel gemischt
	if(~stack.size < 3, {
		~stack = ~stack.addAll(~trash).scramble;
		~trash.clear;
		"Der Ablagestapel wurde in den Nachziehstapel gemsicht:".postln;
		~check.value;
	});
	~nextFunction = ~chooseChancellor;
	//long game win conditions
	if(~fasstack.size == 6, {
		"Die Faschisten haben gewonnen!".postln;
		~nextFunction = ~initGame
	});
	if(~libstack.size == 5, {
		"Die Liberalen haben gewonnen!".postln;
		~nextFunction = ~initGame
	})
};

~check = {
	// Check the state!
	"------------------------------------------------".postln;
	"Nachziehstapel: ".postln;
	~stack.postln;
	"Ablagestapel: ".postln;
	~trash.postln;
	"Hand: ".postln;
	~hand.postln;
	"Faschistenstapel:".postln;
	~fasstack.postln;
	"Liberalenstapel:".postln;
	~libstack.postln;
	"------------------------------------------------".postln;
};

)

/* TEST AREA

~nextFunction
~initGame.value;
~giveRoles.value;
~createStack.value;

~chooseChancellor.value(3);
~election.value(["ja", "ja", "ja", "nein", "nein", "nein"])
~draw.value;
~passTwo.value(0);
~reveal.value(0);

~check.value;

*/
