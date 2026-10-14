extends Control

@onready var speaker_label: Label = $UI/SpeakerLabel
@onready var dialogue_label: Label = $UI/DialogueLabel

var dialogue_index: int = 0

var dialogues: Array[Dictionary] = [
	{
		"speaker": "Narrator",
		"text": "Morning arrives. Sunlight shines through Robert's bedroom window."
	},
	{
		"speaker": "Narrator",
		"text": "Robert wakes up and slowly gets out of bed."
	},
	{
		"speaker": "Robert",
		"text": "*Ah, what a night. Rise and shine!*"
	},
	{
		"speaker": "Narrator",
		"text": "Robert heads to the kitchen and prepares himself a simple breakfast."
	},
	{
		"speaker": "Narrator",
		"text": "He sits at the table and begins eating breakfast alone."
	},
	{
		"speaker": "Robert",
		"text": "*Another day, another dollar. I wonder what work has in store for me today.*"
	},
	{
		"speaker": "Narrator",
		"text": "After finishing his breakfast, Robert washes his dishes and gets ready for work."
	},
	{
		"speaker": "Narrator",
		"text": "With everything ready, Robert leaves home and heads to work."
	}
]


func _ready() -> void:
	show_dialogue()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			next_dialogue()


func next_dialogue() -> void:
	dialogue_index += 1

	if dialogue_index >= dialogues.size():
		finish_morning()
	else:
		show_dialogue()


func show_dialogue() -> void:
	var dialogue: Dictionary = dialogues[dialogue_index]

	speaker_label.text = dialogue["speaker"]
	dialogue_label.text = dialogue["text"]


func finish_morning() -> void:
	# Replace this with your next scene when it is ready.
	get_tree().change_scene_to_file("res://Scenes/Gameplay/OfficeReceptionist.tscn")
