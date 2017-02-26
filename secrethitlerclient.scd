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
		~init.value;		//kann später weg
	}, \master, ~master);

	OSCdef(\findPlayers, { |msg, time, addr|
		addr.postln;
		~net.sendMsg(\newPlayer, ~nickname)
	}, \findPlayers, ~master);



	OSCdef(\newPlayer, { |msg, time, addr|
		addr.ip.postln;
		msg[1].postln;
	}, \newPlayer);

}

)

~net

~master
~net.sendMsg(\master, 1)
~net.sendMsg(\findPlayers, 1)