extends Node

var network = NetworkedMultiplayerENet.new()
var port = 4802
var max_players = 100

var realTime = OS.get_time()

var levelSeed = 0

var currentHour = 1

var timeKept = {}

func _ready():
	randomize()
	levelSeed = (randi() % int(rand_range(500, 10000)))
	currentHour = realTime.hour
	StartServer()
	
func _physics_process(_delta):
	realTime = OS.get_time()

	if currentHour != realTime.hour:
		randomize()
		levelSeed = (randi() % int(rand_range(500, 10000)))
		currentHour = realTime.hour
		rpc("setSeedForAll", levelSeed)
		

	
	
func StartServer():
	network.create_server(port, max_players)
	get_tree().set_network_peer(network)
	print("Server started.")
	
	network.connect("peer_connected", self, "_Peer_Connected")
	network.connect("peer_disconnected", self, "_Peer_Disconnected")
	
func _Peer_Connected(player_id):
	print("User " + str(player_id) + " Connected")
	
func _Peer_Disconnected(player_id):
	print("User " + str(player_id) + " Disconnected")
	
remote func GenSeed(requester):
	var player_id = get_tree().get_rpc_sender_id()
	rpc_id(player_id, "ReturnSeed", levelSeed, requester)
	print("Sending level seed " + str(levelSeed) + " to player.")
	
remote func setSeedForAll(lSeed):
	if 1 == get_tree().get_rpc_sender_id():
		get_tree().setSeed(lSeed)
		
remote func AddTime(requester, time):
	print(time)
	if(timeKept.has(levelSeed)):
		var times = timeKept.get(levelSeed)
		times.append(time)
		timeKept[levelSeed] = times
		
	else:
		var times = [time]
		timeKept[levelSeed] = times
		
remote func BestTime(requester):
	var player_id = get_tree().get_rpc_sender_id()
	if(timeKept.has(levelSeed)):
		var times = timeKept.get(levelSeed)
		var bestTime = null
		for i in times:
			if(bestTime == null):
				bestTime = i
				
			else:
				if(bestTime.hour > i.hour):
					bestTime = i
				elif(bestTime.hour == i.hour):
					if(bestTime.minute > i.minute):
						bestTime = i
					elif(bestTime.minute == i.minute):
						if(bestTime.second > i.second):
							bestTime = i
						elif(bestTime.second == i.second):
							bestTime = i
			print("Sending best time")	
			print(bestTime)	
		rpc_id(player_id, "ReturnBestTime", requester, bestTime)
	else:
		print("Sending best time null")
		rpc_id(player_id, "ReturnBestTime", requester, null)
	
