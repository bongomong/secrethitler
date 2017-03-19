// https:// secrethitler.online/
// https:// de.wikipedia.org/wiki/Secret_Hitler

(

~initGame = {
	~stack = List.new;		// Nachziehstapel (.at(0) --> oberste Karte)
	~trash = List.new;		// Ablagestapel	(.at(0) --> unterste Karte)
	~hand = List.new;		// Hand wird jede Runde überschrieben
	~amountf = 11;			// Anzahl Faschistenkarten
	~amountl = 6;			// Anzahl Liberalenkarten
	~fasstack = List.new;	// Stapel der Faschistenkarten
	~libstack = List.new;	// Stapel der Liberalenkarten
	~listOfPlayers = [\0, \1, \2, \3, \4, \5];		//contains ip addresses of players as symbols TEMPORARILY HARDCODED
	~playerNicknames = [\0, \1, \2, \3, \4, \5];		//contains nicknames of players as symbols TEMPORARILY HARDCODED
	~listOfRoles = List.new;
	~whoHasHand = nil;
	~whoIsPresident = nil;
	~whoIsChancellor = nil;
	~nextFunction = ~gamestart;
};

~gamestart = {
	~giveRoles.value;
	~createStack.value;
	~rolePresident.value;
	~nextFunction = ~chooseChancellor;
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
	~whoIsPresident = ~listOfPlayers.choose;
	"Der erste Präsident ist:".postln;
	~whoIsPresident.postln;
};

~chooseChancellor = { |chancellor|
	//präsident wählt kanzler, check1 ob spieler existiert, check2 ob spieler letzter kanzler oder präsident war (darf nicht wiedergewählt werden)
	//TODO: 5bis6 spieler darf letzter präsident gewählt werden
	"hallo".postln;
	chancellor.postln;
	if(~listOfPlayers.includes(chancellor.asSymbol)) {
		if(and(~whoIsChancellor != chancellor, ~whoIsPresident != chancellor)) {
			~whoIsChancellor = chancellor;
			chancellor.asString.postln;
			"is new chancellor".postln;
			~nextFunction = ~draw;
		} {
			"This player is not electable!".postln
		}
	} {
		"This player doesn't exist!".postln
	}
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
	// Sollten im Nachziehstapel weniger als 3 Karten sein, wird der Ablagestapel wieder in den Nachziehstapel gemischt
	if(~stack.size < 3, {
		~stack = ~stack.addAll(~trash).scramble;
		~trash.clear;
		"Der Ablagestapel wurde in den Nachziehstapel gemsicht:".postln;
		~check.value;
	});
	~nextFunction = ~chooseChancellor;
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
	"Faschistenstapel".postln;
	~fasstack.postln;
	"Liberalenstapel".postln;
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
~draw.value;
~passTwo.value(0);
~reveal.value(0);

~check.value;

*/

