extends Control

const XBOX_BUTTON_TO_INDEX_MAPPING = {
	JOY_XBOX_A: 0,
	JOY_XBOX_B: 1,
	JOY_XBOX_X: 2,
	JOY_XBOX_Y: 3,
	JOY_START: 6,
	JOY_SELECT: 7
}

const KEYBOARD_BUTTON_TO_INDEX_MAPPING = {
	KEY_A: 13,
	KEY_B: 14,
	KEY_C: 15,
	KEY_D: 16,
	KEY_E: 17,
	KEY_F: 18,
	KEY_G: 19,
	KEY_H: 20,
	KEY_I: 21,
	KEY_J: 22,
	KEY_K: 23,
	KEY_L: 24,
	KEY_M: 25,
	KEY_N: 26,
	KEY_O: 27,
	KEY_P: 28,
	KEY_Q: 29,
	KEY_R: 30,
	KEY_S: 31,
	KEY_T: 32,
	KEY_U: 33,
	KEY_V: 34,
	KEY_W: 35,
	KEY_X: 36,
	KEY_Y: 37,
	KEY_Z: 38,
	KEY_ENTER: 39,
	KEY_SPACE: 40,
	KEY_ESCAPE: 41,
}

export(String) var action_name setget set_action_name

onready var icon = $Sprite
onready var name_label = $ActionName

var device_id = -1

func _ready():
	Input.connect("joy_connection_changed", self, "_joy_connection_changed")
	if Input.get_connected_joypads().size() > 0:
		self.device_id = Input.get_connected_joypads()[0]
	icon.frame = _get_current_icon_index(self.device_id, action_name)
	name_label.text = action_name
	
func _joy_connection_changed(device_id:int, connected:bool):
	if connected:
		self.device_id = device_id
	else:
		self.device_id = -1
	icon.frame = _get_current_icon_index(self.device_id, action_name)
	
func set_action_name(a):
	action_name = a
	if icon != null:
		icon.frame = _get_current_icon_index(device_id, action_name)
		name_label.text = action_name

func _get_current_icon_index(device_id:int,action_name:String):
	for action in InputMap.get_action_list(action_name):
		if action is InputEventKey and device_id == -1:
			return KEYBOARD_BUTTON_TO_INDEX_MAPPING[action.scancode]
		if action is InputEventJoypadButton and device_id != -1:
			if "XInput" in Input.get_joy_name(device_id):
				return XBOX_BUTTON_TO_INDEX_MAPPING[action.button_index]
	return -1
