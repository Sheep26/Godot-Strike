extends Node

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
