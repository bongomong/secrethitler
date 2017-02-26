(

NetAddr.broadcastFlag = true;
~net = NetAddr("255.255.255.255", 57120);



OSCdef(\secrethitler, { |msg|
	//Masterfunktion für eingehende OSC-Message, zu Beginn des Spiels (~status == -1) werden die Funktionen initialisiert
	//TODO -> Nachrichtenfilter (jetzt kann noch jeder Client immer Nachrichten senden); Election nach Kanzlerwahl
	msg.postln;
	if(~status == -1) {~init.value} {
		if(~status == 0) {~chooseChancellor.value(msg[1])} {
			if(~status == 1) {~draw.value} {
				if(~status == 2) {~passTwo.value(msg[1])} {
					if(~status == 3) {~reveal.value(msg[1])}
				}
			}
		}
	}
}, \secrethitler);			//variabler recvport definierbar?


)

/* TEST AREA

~status = -1;						//setzt das Spiel auf den Zustand vor Beginn zurück
~net.sendMsg(\secrethitler, 2)		//Standardmessage mit der die Spieler mit dem Spiel kommunizieren
~net.sendMsg(\secrethitler, 0)


~whoIsChancellor
~whoIsPresident

*/

/* TODO

-> Initiales ermitteln der Spieler-IPs (Wir haben etwas ähnliches mal irgendwann mit Tobias und den Arduinos  gemacht)
-> Aufforderung an Spieler, etwas zu tun: Wie sende ich OSC-messages an einzelne Spieler?
-> Election: Alle Spieler müssen einmal "ja" oder "nein" wählen (ohne Enthaltungen). Wie finde ich heraus, von wem eine Nachricht ist? Wie fange ich es ab, wenn ein Client nicht antwortet oder einen Disconnect hat?
-> Soundlogik: Ich möchte auf jeden Fall final generative "faschistische" und "liberale" Sounds haben, sodass das Spiel jedes Mal anders klingt. Zunächst code ich einfach ein paar Testsounds hart. Ich weiß nur noch nicht, ob ich Ndefs oder SynthDefs oder vielleicht was ganz anderes nehmen sollte...
-> Soundrouting: Wie kann ich einzelnen Spielern über das Netzwerk meine Sounds zum Prelistening zur Verfügung stellen?
-> Ereignisse definieren: Was passiert, wenn eine Karte aufgedeckt wird?
-> Spiellogik verfeinern (z.B. wird dreimal eine Wahl verloren, wird die oberste karte aufgedeckt)


*/