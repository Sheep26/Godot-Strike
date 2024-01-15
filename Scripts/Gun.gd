extends Node3D

var currentGun: GunType
@onready var glock18: GunType = GunType.new(0, "Glock-18", "Pistol", $Guns/pistol/firerateTimer, $Guns/pistol/reloadTimer, 23, false, 0.1)
@onready var ak47: GunType = GunType.new(1, "AK47", "Rifle", $Guns/ak47/firerateTimer, $Guns/ak47/reloadTimer, 35, true, 0.05)
var guns = []

class GunType:
	var id: int
	var gunName: String
	var category: String
	var firerate: Timer
	var reloadTimer: Timer
	var ammo: int
	var maxAmmo: int
	var auto: bool
	var canShoot: bool
	var recoil: float
	
	func _init(idArg: int, gunNameArg: String, categoryArg: String, firerateArg: Timer, reloadTimerArg: Timer, ammoArg: int, autoArg: bool, recoilArg: float):
		gunName = gunNameArg
		firerate = firerateArg
		reloadTimer = reloadTimerArg
		ammo = ammoArg
		maxAmmo = ammoArg
		auto = autoArg
		category = categoryArg
		canShoot = true
		id = idArg
		recoil = recoilArg
		firerate.connect("timeout", _firerateTimerEnded)
		reloadTimer.connect("timeout", _reloadTimerEnded)

	func _reload():
		canShoot = false
		reloadTimer.start()

	func _reloadTimerEnded():
		reloadTimer.stop()
		canShoot = true
		ammo = maxAmmo

	func _firerateTimerEnded():
		canShoot = true
		firerate.stop()

func _ready():
	guns.append(glock18)
	guns.append(ak47)
	currentGun = ak47

func _getGunFromID(id: int) -> GunType:
	for gun in guns:
		if gun.id == id:
			return gun
	return null
