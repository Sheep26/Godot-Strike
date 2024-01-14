extends Node

class Menu:
	var name: String
	var id: int
	var open: bool
	var resource
	var instance
	
	func _init(name, id, resource):
		self.name = name
		self.id = id
		self.resource = resource

func _ready():
	pass

func _process(delta):
	pass
