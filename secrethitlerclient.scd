(

~nickname = "Blondie";

NetAddr.broadcastFlag = true;
// get your actual network ip via shell command
//~net = NetAddr.new(Pipe.new("ifconfig en1 | grep \"inet \" | awk '{print $2}'" , "r").getLine, 57120);
~net = NetAddr.new("192.168.178.25", 57120); //temporarily hard coded


OSCdef(\master, { |msg, time, addr|
	"ip versandt".postln;
	~net.sendMsg(\newPlayer, ~nickname);
}, \master);


)


~listOfPlayers
~playerNicknames

~net = NetAddr.new("192.168.178.58", 57120);


~master
~net.sendMsg(\master, 1)
~net.sendMsg(\newPlayer, ~nickname)

~net.sendMsg(\rest, 1)