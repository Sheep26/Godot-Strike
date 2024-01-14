extends Node
@onready var settings = Client.Menu.new("Settings", 0, ResourceLoader.load("res://Scenes/ui/SettingsMenu.tscn"))
var menus = []

func _ready():
	menus.append(settings)

func _process(_delta):
	pass

func _settingsPressed():
	settings.instance = settings.resource.instantiate()
	get_tree().root.add_child(settings.instance)

func _homeButtonPressed():
	for menu in menus:
		if menu.open:
			menu.open = false
			get_tree().root.remove_child(menu.instance)
