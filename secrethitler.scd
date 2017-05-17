// https:// secrethitler.online/
// https:// de.wikipedia.org/wiki/Secret_Hitler
(
~listOfPlayers = [NetAddr("scip0", 57120), NetAddr("scip1", 57120), NetAddr("scip2", 57120), NetAddr("scip3", 57120), NetAddr("scip4", 57120), NetAddr("scip5", 57120)];
//~listOfPlayers = ['192.168.178.26', '192.168.178.27', '192.168.178.28', '192.168.178.29', '192.168.178.30', '192.168.178.31'];		//contains ip addresses of players as symbols TEMPORARILY HARDCODED
~playerNicknames = ["Adolf", "Bertha", "Claus", "Dagmar", "Erich", "Franz"];		//contains nicknames of players as symbols TEMPORARILY HARDCODED
)

(
//~nextFunction = ~initGame;

~initGame = {
    ~stack = List.new;		// Nachziehstapel (.at(0) --> oberste Karte)
    ~trash = List.new;		// Ablagestapel	(.at(0) --> unterste Karte)
    ~hand = List.new;		// Hand wird jede Runde überschrieben
    ~amountf = 11;			// Anzahl Faschistenkarten
    ~amountl = 6;			// Anzahl Liberalenkarten
    ~fasstack = List.new;	// Stapel der Faschistenkarten
    ~libstack = List.new;	// Stapel der Liberalenkarten
    ~listOfRoles = List.new;
    ~whoHasHand = nil;
    ~whoIsPresident = nil;
    ~possiblePresidentIndizes = List.new;
    ~presidentIndex = nil;
    ~lastPresident = nil;
    ~whoIsChancellor = nil;
    ~lastChancellor = nil;
    ~chancellorCandidate = nil;
    ~listOfVotes = nil ! ~listOfPlayers.size;
    ~unsuccessfulVoteCounter = 0;
    ~lastDepesche = nil;
    ~gamestart.value;
};

~gamestart = {
    ~possiblePresidentIndizes = (..~listOfPlayers.size -1);
    ~giveRoles.value;
    ~createStack.value;
    ~rolePresident.value;
    ~nextFunction = ~chooseChancellor;
};

// ~giveRoles.value
// roles the roles of the players
~giveRoles = {
    var numberOfPlayers, lib, fas;
    numberOfPlayers = ~listOfPlayers.size;
    if(numberOfPlayers.odd) {lib = numberOfPlayers + 1 / 2} {lib = numberOfPlayers +2 / 2};
    fas = numberOfPlayers - lib - 1;
    ~listOfRoles = (("Faschist" ! fas) ++ ("Liberaler" ! lib) ++ ["Hitler"]).scramble;
    "Die Rollen wurden verteilt:".postln;
    //~listOfRoles.postln;
    for(0, (~listOfPlayers.size - 1), { arg i;
        var role;
		role = ~listOfRoles[i];
		~listOfPlayers[i].sendMsg(\depesche, ("Du bist" + role ++ "!").asString);
		if(role == "Faschist", {
			for(0, (~listOfPlayers.size - 1), { arg j;
				~listOfPlayers[i].sendMsg(\depesche, (~playerNicknames[j] + "ist" + ~listOfRoles[j] + "!").asString)
			});
		});
       /* ~net.sendMsg(\depesche, ("Du bist" + role ++ "!").asString);
        if(role == "Faschist", {
            for(0, (~listOfPlayers.size - 1), { arg j;
                ~net.sendMsg(\depesche, (~playerNicknames[j] + "ist" + ~listOfRoles[j] + "!").asString)
            });
        });*/

    });
};

~createStack = {
    // Erstellt gemischten Nachziehstapel (0 --> Faschistenkarte, 1 --> Lieberalenkarte)
    // Später können hier statt 0 und 1 Ndefs abgelegt werden
    // ~stack = ((0 ! ~amountf) ++ (1 ! ~amountl)).scramble;
    ~stack = [Ndef(\fascist01), Ndef(\fascist02), Ndef(\fascist03), Ndef(\fascist04), Ndef(\fascist05), Ndef(\fascist06), Ndef(\fascist07), Ndef(\fascist08), Ndef(\fascist09), Ndef(\fascist10), Ndef(\fascist11), Ndef(\liberal01), Ndef(\liberal02), Ndef(\liberal03), Ndef(\liberal04), Ndef(\liberal05), Ndef(\liberal06)].scramble;
    //"Ein neues Spiel hat begonnen: ".postln;
    ~check.value;
};

~rolePresident = {
    ~presidentIndex = ~possiblePresidentIndizes.choose;
    ~whoIsPresident = ~listOfPlayers[~presidentIndex];
    //("Der erste Präsident ist:" + ~playerNicknames[~listOfPlayers.indexOf(~whoIsPresident)]).postln;
    ~sendToAll.value((~playerNicknames[~listOfPlayers.indexOf(~whoIsPresident)] + "ist neuer Präsident!"));
	~lastDepesche = { ~sendToPresident.value("Du bist Präsident! Bitte wähle einen Kanzler!") };
	~lastDepesche.value;
};

~sendToPresident = { |msg|
	~lastDepesche = {~whoIsPresident.sendMsg(\depesche, msg.asString)};
	// ~lastDepesche = { ~net.sendMsg(\depesche, msg.asString)};
    ~lastDepesche.value;
};

~sendToChancellor = { |msg|
	~lastDepesche = {~whoIsChancellor.sendMsg(\depesche, msg.asString)};
	// ~lastDepesche = {~net.sendMsg(\depesche, msg.asString)};
    ~lastDepesche.value;
};

~sendToAll = { |msg|
    ~lastDepesche = {
        for(0, (~listOfPlayers.size - 1), { arg i;
			~listOfPlayers[i].sendMsg(\depesche, msg.asString)
			// ~net.sendMsg(\depesche, msg.asString)
        })
    };
    ~lastDepesche.value;
};

//~playerNicknames.indexOfEqual("Peter")
//~chooseChancellor.value("Peter")
//~sendToPresident.value("penis")

~chooseChancellor = { |chancellor|
    var chancellorNetAddr;
    chancellor = chancellor.asString;
    // präsident wählt kanzler, check1 ob spieler existiert, check2 ob spieler letzter kanzler oder präsident war (darf nicht wiedergewählt werden)
    //TODO: 5bis6 spieler darf letzter präsident gewählt werden
    if(~playerNicknames.includesEqual(chancellor)) {
        chancellorNetAddr = ~listOfPlayers[~playerNicknames.indexOfEqual(chancellor)];
		// if((~lastChancellor != chancellorNetAddr) && (~lastPresident != chancellorNetAddr) && (~whoIsPresident != chancellorNetAddr)) {
		~chancellorCandidate = chancellorNetAddr;
		//(chancellor.asString + "ist neuer Kanzlerkandidat").postln;
		~sendToAll.value((chancellor + "ist neuer Kanzlerkandidat! Stimme mit \"ja\" oder \"nein\"!"));
		// set length of listOfVotes to the actual value shortly before the election
		~listOfVotes = nil ! ~listOfPlayers.size;
		~nextFunction = ~getPolls;
		/*        } {
		//"This player is not electable!".postln
            ~sendToPresident.value(chancellor + "darf nicht gewählt werden! Wähle jemand anderen!");
        }*/
    } {
        // "This player doesn't exist!".postln
        ~sendToPresident.value(chancellor + "existiert nicht!");
    }
};

~getPolls = { |vote, playerNetAddr|
    var votes;
    //votes = ["ja", "ja", "ja", "nein", "nein", "nein"];
    //playerNetAddr.postln;
    if(~listOfPlayers.includesEqual(playerNetAddr), {
        if(or(vote.asString == "ja", vote.asString == "nein"), {
            ~listOfVotes.put(~listOfPlayers.indexOfEqual(playerNetAddr), vote);
            playerNetAddr.sendMsg(\depesche, "Deine Wahlentscheidung wurde registriert!");
            ~listOfVotes.postln;
        }, {
            playerNetAddr.sendMsg(\depesche, "Ungültige Stimmabgabe! Wähle \"ja\" oder \"nein\"!")
        })
    });
    if(~listOfVotes.includes(nil) == false, {~election.value(~chancellorCandidate, ~listOfVotes)});
};

~election = { |candidate, thePolls|
    // checks if the chancellor has been elected
    var ja = 0, nein = 0;
    (candidate.asString + thePolls.asString).postln;
    thePolls.do({ arg item;
        item.postln;
        if(item == "ja", {ja = ja + 1});
        if(item == "nein", {nein = nein + 1});
    });
    if(ja > nein, {
        ~sendToAll.value((~playerNicknames[~listOfPlayers.indexOfEqual(candidate)] + "wurde zum Kanzler gewählt!"));
        "Der Kanzler wurde gewählt".postln;
        ~whoIsChancellor = candidate;
        ~unsuccessfulVoteCounter = 0;
        ~draw.value
    }, {
        ~sendToAll.value((~playerNicknames[~listOfPlayers.indexOfEqual(candidate)] + "wurde nicht zum Kanzler gewählt!"));
        //"Der Kanzler wurde nicht gewählt".postln;
        ~unsuccessfulVoteCounter = ~unsuccessfulVoteCounter + 1;
        ~sendToAll.value(("Anzahl der in Folge abgelehnten Regierungen:" + ~unsuccessfulVoteCounter.asString));
		if((~unsuccessfulVoteCounter % 3) == 0, {~forcedReveal.value});
        ~lastPresident = ~whoIsPresident;
        ~presidentIndex = ~presidentIndex + 1 % ~possiblePresidentIndizes.size;
        ~whoIsPresident = ~listOfPlayers[~presidentIndex];
        ~sendToAll.value((~playerNicknames[~listOfPlayers.indexOfEqual(~whoIsPresident)] + "ist neuer Präsident!"));
        ~sendToPresident.value("Du bist Präsident! Bitte wähle einen Kanzler!");
        ~nextFunction = ~chooseChancellor
    });
};

~draw = {
    // Zieht drei Karten vom Nachziehstapel und erstellt daraus eine Hand
    ~hand = ~stack.keep(3);
    ~stack = ~stack.drop(3);
    "Drei Karten wurden gezogen: ".postln;
    ~nextFunction = ~passTwo;
    ~sendToPresident.value("Wähle einen Sound und verwerfe ihn! Die verbleibenden Sounds werden dem Kanzler überreicht!");
	~whoIsPresident.sendMsg(\prelisten, ~hand[0].key, ~hand[1].key, ~hand[2].key);
    ~check.value;
};

~passTwo = {|discard = 0|
    // Legt eine Karte aus der Hand auf den Ablagestapel
    ~trash.add(~hand.removeAt(discard));
	~sendToChancellor.value("Wähle einen Sound und verwerfe ihn! Der verbleibende Sound wird Gesetz und für alle hörbar!");
	~whoIsPresident.sendMsg(\prelisten, ~hand[0].key, ~hand[1].key);
    // "Zwei Karten wurden weitergegeben, eine abgelegt: ".postln;
    ~nextFunction = ~reveal;
    ~check.value;
};

~reveal = {|discard = 0|
    // Legt von den verbleibenden zwei Karten eine auf den Ablagestapel und legt die andere entweder auf den Liberalenstapel oder den Faschistenstapel
    ~trash.add(~hand.removeAt(discard));
	if(~hand.at(0).key.asString.contains("fascist"), {
		~fasstack.add(~hand.at(0));
		~sendToAll.value("Ein faschistisches Gesetz wurde umgesetzt!\rAnzahl faschistischer Gesetze:" + ~fasstack.size + "\rAnzahl liberaler Gesetze:" + ~libstack.size);
	}, {
		~libstack.add(~hand.at(0));
		~sendToAll.value("Ein liberales Gesetz wurde umgesetzt!\rAnzahl faschistischer Gesetze:" + ~fasstack.size + "\rAnzahl liberaler Gesetze:" + ~libstack.size);
	});
    ~hand.at(0).play;
    ~hand = List.new;
    "Eine Karte wurde aufgedeckt, eine abgelegt: ".postln;
    ~check.value;
    //sets new president and remembers who was the last one
    ~lastPresident = ~whoIsPresident;
    ~lastChancellor = ~whoIsChancellor;
    ~whoIsChancellor = nil;
    ~presidentIndex = ~presidentIndex + 1 % ~possiblePresidentIndizes.size;
    ~whoIsPresident = ~listOfPlayers[~presidentIndex];
    ~sendToAll.value(~playerNicknames[~listOfPlayers.indexOfEqual(~whoIsPresident)] + "ist neuer Präsident!");
    ~sendToPresident.value("Du bist Präsident! Bitte wähle einen Kanzler!");
    // (~whoIsPresident.asString + "ist neuer Präsident").postln;
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

~forcedReveal = {
	~stack.at(0).play;
	~sendToAll.value("Es wurden drei Regierungen in Folge abgelehnt! Die Legislative muss reagieren!");
	if(~stack.at(0).key.asString.contains("fascist"), {
		~fasstack.add(~stack.removeAt(0));
		~sendToAll.value("Ein faschistisches Gesetz wurde umgesetzt!\rAnzahl faschistischer Gesetze:" + ~fasstack.size + "\rAnzahl liberaler Gesetze:" + ~libstack.size);
	}, {
		~libstack.add(~hand.removeAt(0));
		~sendToAll.value("Ein liberales Gesetz wurde umgesetzt!\rAnzahl faschistischer Gesetze:" + ~fasstack.size + "\rAnzahl liberaler Gesetze:" + ~libstack.size);
	});
	if(~stack.size < 3, {
        ~stack = ~stack.addAll(~trash).scramble;
        ~trash.clear;
        "Der Ablagestapel wurde in den Nachziehstapel gemsicht:".postln;
        ~check.value;
    });
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
