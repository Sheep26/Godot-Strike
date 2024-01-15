extends Node

const SERVERPORT = 4433
var SERVERIP: String = ""

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
	pass

func _process(_delta):
	pass

func _changeScene(path: String):
	get_tree().current_scene.queue_free()
	var s = ResourceLoader.load(path)
	var new = s.instantiate()
	get_tree().root.add_child(new)
	get_tree().current_scene = new
