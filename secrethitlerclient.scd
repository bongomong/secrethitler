(

~nickname = "Blondie";

NetAddr.broadcastFlag = true;
// get your actual network ip via shell command
~net = NetAddr.new(Pipe.new("ifconfig en1 | grep \"inet \" | awk '{print $2}'" , "r").getLine, 57120);
// ~master will contain the server's ip address, only he is allowed to communicate with the client
~master = NetAddr.new;

OSCdef(\master, { |msg, time, addr|
	addr.postln;
	~master = addr;
	~init.value;
}, \master);

~init = {

	OSCdef(\master, { |msg, time, addr|
		~master = addr;
		~net.sendMsg(\newPlayer, ~nickname);
		//~init.value		//kann später weg
	}, \master, ~master);
}

)


~listOfPlayers
~playerNicknames

~net

~master
~net.sendMsg(\master, 1)