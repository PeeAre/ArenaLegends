extends Node

const PORT: int = 6666
const ADDRESS: String = "localhost"
const MAX_CLIENTS: int = 4

var player_scene: PackedScene = preload("res://scenes/player.tscn")


func _ready():
	var peer = ENetMultiplayerPeer.new()
	
	if Hub.is_server:
		peer.create_server(PORT, MAX_CLIENTS)
	else:
		peer.create_client(ADDRESS, PORT)
	
	multiplayer.multiplayer_peer = peer
	
	if multiplayer.is_server():
		spawn_player(1)
	
	if multiplayer.is_server():
		peer.peer_connected.connect(
			func(peer_id):
				await get_tree().create_timer(1).timeout
				rpc("spawn_newly_player", peer_id)
				rpc_id(peer_id, "add_connected_players", Hub.players.keys())
				spawn_player(peer_id)
	)

func spawn_player(peer_id: int) -> void:
	Hub.palyer_spawn_position.x += 1
	var player: Player = player_scene.instantiate()
	player.name = str(peer_id)
	player.set_multiplayer_authority(peer_id)
	Hub.arena.add_child(player)
	Hub.players[peer_id] = player
	
	if peer_id == multiplayer.get_unique_id():
		Hub.player = player

@rpc
func spawn_newly_player(peer_id: int) -> void:
	spawn_player(peer_id)

@rpc
func add_connected_players(peer_ids: Array) -> void:
	for id in peer_ids:
		spawn_player(id)
