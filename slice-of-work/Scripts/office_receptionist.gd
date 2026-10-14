extends Control

@onready var character_name: Label = $UI/CharacterName
@onready var dialogue_text: Label = $UI/DialogueText

var dialogues = [
	{
		"name": "Narrator",
		"text": "You arrived at the office, ready to start your workday."
	},
	{
		"name": "Lydia",
		"text": "Good morning, Robert! Ready for another day at work?"
	},
	{
		"name": "Robert",
		"text": "Good morning, Lydia. Yes, I'm ready to get started."
	},
	{
		"name": "Lydia",
		"text": "Great! Head to your workspace and get comfortable."
	},
	{
		"name": "Robert",
		"text": "Alright, let's get to work!"
	}
]

var dialogue_index: int = 0

func _ready() -> void:
	show_dialogue()

func show_dialogue() -> void:
	if dialogue_index >= dialogues.size():
		get_tree().change_scene_to_file("res://Scenes/Gameplay/Workspace.tscn")
		return

	character_name.text = dialogues[dialogue_index]["name"]
	dialogue_text.text = dialogues[dialogue_index]["text"]

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			dialogue_index += 1
			show_dialogue()
