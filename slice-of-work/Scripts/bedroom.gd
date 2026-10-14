extends Control

@onready var character_name: Label = $UI/DialoguePanel/CharacterName
@onready var dialogue_text: Label = $UI/DialoguePanel/DialogueText

var dialogue = [
	{
		"name": "Narrator",
		"text": "You went home after an exhausting day of working in your new job."
	},
	{
		"name": "Robert",
		"text": "*Sleep might be nice.*"
	},
	{
		"name": "Narrator",
		"text": "You went to sleep."
	}
]

var current_line: int = 0

func _ready() -> void:
	show_dialogue()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			advance_dialogue()

	elif event is InputEventKey:
		if event.pressed and not event.echo:
			if event.keycode == KEY_SPACE or event.keycode == KEY_ENTER:
				advance_dialogue()

func show_dialogue() -> void:
	if current_line >= dialogue.size():
		finish_introduction()
		return

	character_name.text = dialogue[current_line]["name"]
	dialogue_text.text = dialogue[current_line]["text"]

func advance_dialogue() -> void:
	current_line += 1
	show_dialogue()

func finish_introduction() -> void:
	character_name.text = "Narrator"
	dialogue_text.text = "End of Introduction."
	get_tree().change_scene_to_file("res://Scenes/Gameplay/MorningScene.tscn")
