extends Node

var network = NetworkedMultiplayerENet.new()
var ip = "127.0.0.1"
var port = 4802


signal connected

func _ready():
	ConnectToServer()
	
func ConnectToServer():
	network.create_client(ip, port)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed", self, "_OnConnectionFailed")
	network.connect("connection_succeeded", self, "_OnConnectionSucceeded")
	
func _OnConnectionFailed():
	print("Failed to connect.")
	
func _OnConnectionSucceeded():
	print("Successfully connected.")
	
	emit_signal("connected")
	
	
remote func ReturnSeed(s_seed, requester):
	instance_from_id(requester).setSeed(s_seed)
	
remote func requestSeed(requester):
	var player_id = get_tree().get_rpc_sender_id()
	rpc_id(1, "GenSeed", requester)
	
remote func requestBestTime(requester):
	
	rpc_id(1, "BestTime", requester)
	
remote func ReturnBestTime(requester, s_time):
	instance_from_id(requester).setTime(s_time)

remote func SendTime(requester, time):
	rpc_id(1, "AddTime", requester, time)
	print(time)

	
