extends Node
@onready var settings = Menu.new("Settings", 0, ResourceLoader.load("res://Scenes/ui/SettingsMenu.tscn"))

class Menu:
	var name: String
	var id: int
	var resource
	var instance
	
	func _init(name, id, resource):
		pass

func _settingsPressed():
	settings.instance = settings.resource.instantiate()
	get_tree().root.add_child(settings.instance)
