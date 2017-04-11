(

NetAddr.broadcastFlag = true;
// get your actual network ip via shell command
//~net = NetAddr.new(Pipe.new("ifconfig en1 | grep \"inet \" | awk '{print $2}'" , "r").getLine, 57120);
~net = NetAddr.new("192.168.178.25", 57120);

//main communication unit for the clients
OSCdef(\secrethitler, { |msg, time, addr|
	"____________________".postln;
	addr.postln;
	msg[1].postln;
	"____________________".postln;
	~nextFunction.value(msg[1], addr);		//geht das so für die wahl?
}, \secrethitler);

//gathers the ip-addresses and nicknames in the start of the game from the clients
OSCdef(\newPlayer, { |msg, time, addr|
	if(~listOfPlayers.includesEqual(addr) == false) {
		~listOfPlayers = ~listOfPlayers.add(addr);
		~playerNicknames = ~playerNicknames.add(msg[1].asString);
	}
}, \newPlayer);

)



/* TEST AREA

~initGame.value;
~net.sendMsg(\secrethitler, 2)		//Standardmessage mit der die Spieler mit dem Spiel kommunizieren
b.sendMsg(\secrethitler, 0)


~whoIsChancellor
~whoIsPresident

*/

/* TODO

-> Initiales ermitteln der Spieler-IPs (Wir haben etwas ähnliches mal irgendwann mit Tobias und den Arduinos  gemacht)
DONE	-> Aufforderung an Spieler, etwas zu tun: Wie sende ich OSC-messages an einzelne Spieler?
-> Election: Alle Spieler müssen einmal "ja" oder "nein" wählen (ohne Enthaltungen). Wie finde ich heraus, von wem eine Nachricht ist? Wie fange ich es ab, wenn ein Client nicht antwortet oder einen Disconnect hat?
-> Soundlogik: Ich möchte auf jeden Fall final generative "faschistische" und "liberale" Sounds haben, sodass das Spiel jedes Mal anders klingt. Zunächst code ich einfach ein paar Testsounds hart. Ich weiß nur noch nicht, ob ich Ndefs oder SynthDefs oder vielleicht was ganz anderes nehmen sollte...
-> Soundrouting: Wie kann ich einzelnen Spielern über das Netzwerk meine Sounds zum Prelistening zur Verfügung stellen?
-> Ereignisse definieren: Was passiert, wenn eine Karte aufgedeckt wird?
-> Spiellogik verfeinern (z.B. wird dreimal eine Wahl verloren, wird die oberste karte aufgedeckt)

-> node proxy

*/

/* FRAGEN

-> .includes gibt bei strings immer false. warum?
		ANTWORT: .includes checkt nach identity (===), nicht equality (==)

*/