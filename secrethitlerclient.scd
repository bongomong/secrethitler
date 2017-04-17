(

~nickname = "Blondie";

NetAddr.broadcastFlag = true;
// get your actual network ip via shell command
//~net = NetAddr.new(Pipe.new("ifconfig en1 | grep \"inet \" | awk '{print $2}'" , "r").getLine, 57120);
~net = NetAddr.new("192.168.178.58", 57120); //temporarily hard coded

//this OSCdef sends ip and nickname to the server
OSCdef(\master, { |msg, time, addr|
    "ip versandt".postln;
    ~net.sendMsg(\newPlayer, ~nickname);
}, \master, ~net);

//this OSCdef prints all commands from the server
OSCdef(\depesche, { |msg|
    msg[1].postln;
}, \depesche, ~net);

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
~net.sendMsg(\depesche, 1);
~net.sendMsg(\master, 1);
~net.sendMsg(\secrethitler, 0)
~net.sendMsg(\secrethitler, "Blondie")
~net.sendMsg(\secrethitler, "nein")
~election.value(1, ["ja", "ja", "ja", "nein", "nein", "nein"])
)

~whoIsChancellor
~whoIsPresident
~lastPresident
~lastChancellor
~lastDepesche.value

~nextFuntion

~listOfPlayers.indexOfEqual(NetAddr("192.168.178.27", 57120))

*/