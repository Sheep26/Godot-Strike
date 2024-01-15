extends Node

const SERVERPORT = 4433
var SERVERIP: String = ""
var possibleSizeOptions = [Vector2(600, 400), Vector2(1152, 648), Vector2(1280, 720), Vector2(1366, 768), Vector2(1920, 1080), Vector2(2560, 1440), Vector2(3840, 2160)]
var sizeOptions = []

class Menu:
	var oname: String
	var oid: int
	var open: bool
	var oresource
	var instance: Node

	func _init(name, id, resource):
		self.oname = name
		self.oid = id
		self.oresource = resource
		
	func _instantiate():
		instance = oresource.instantiate()

func _ready():
	for size in possibleSizeOptions:
		if size.x <= DisplayServer.screen_get_size().x:
			if size.y <= DisplayServer.screen_get_size().y:
				sizeOptions.append(size)
	get_window().size = sizeOptions[sizeOptions.size() - 1]
	get_viewport().size = sizeOptions[sizeOptions.size() - 1]

func _process(_delta):
	pass

func _changeScene(path: String):
	get_tree().current_scene.queue_free()
	var s = ResourceLoader.load(path)
	var new = s.instantiate()
	get_tree().root.add_child(new)
	get_tree().current_scene = new
