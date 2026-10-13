extends Control

@onready var character_name: Label = $UI/CharacterName
@onready var dialogue_text: Label = $UI/DialogueText

var dialogue = [
	{
		"name": "Lydia",
		"text": "This will be your workspace."
	},
	{
		"name": "Robert",
		"text": "Thanks! Can I start working as soon as possible?"
	},
	{
		"name": "Lydia",
		"text": "Upper management says you can."
	},
	{
		"name": "Narrator",
		"text": "You work for the day."
	}
]

var current_line = 0

func _ready():
	show_dialogue()

func show_dialogue():
	if current_line < dialogue.size():
		character_name.text = dialogue[current_line]["name"]
		dialogue_text.text = dialogue[current_line]["text"]
	else:
		# Change to the next scene when the dialogue ends.
		get_tree().change_scene_to_file("res://DayEnd.tscn")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			current_line += 1
			show_dialogue()
