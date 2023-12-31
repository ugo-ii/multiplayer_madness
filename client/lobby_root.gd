extends Node2D

var enemy_freed = false

func _ready():
	Globals.player_dead.connect(set_show_lobby)

func set_show_lobby(should_show: bool = true):
	if !enemy_freed:
		enemy_freed = true
		$preloadshaders/Enemy.queue_free()
	visible = should_show
	if (should_show):
		$lobby_ui.server_joined = false
		$lobby_ui.connect_room_id = null
		$lobby_ui/join_button.disabled = false
		$lobby_ui/join_button.text = "Join"
		$lobby_ui/host_button.disabled = false
		$lobby_ui/host_button.text = "host"
		$Camera2D.make_current()
		var game_instance = get_tree().root.get_node("GameInstance")
		if game_instance != null:
			game_instance.queue_free()
