extends Node
@onready var settings = Client.Menu.new("Settings", 0, ResourceLoader.load("res://Scenes/ui/SettingsMenu.tscn"))
@onready var play = Client.Menu.new("Play", 0, ResourceLoader.load("res://Scenes/ui/PlayMenu.tscn"))
var menus = []
var i = 0

func _ready():
	menus.append(settings)
	menus.append(play)

func _closeMenu(menu: Client.Menu):
	menu.instance.queue_free()
	menu.open = false

func _settingsButtonPressed():
	for menu in menus:
		if menu.open:
			_closeMenu(menu)
	settings.open = true
	settings._instantiate()
	add_child(settings.instance)
	move_child(settings.instance, 0)

func _homeButtonPressed():
	for menu in menus:
		if menu.open:
			_closeMenu(menu)

func _playButtonPressed():
	for menu in menus:
		if menu.open:
			_closeMenu(menu)
	play.open = true
	play._instantiate()
	add_child(play.instance)
	move_child(play.instance, 0)
