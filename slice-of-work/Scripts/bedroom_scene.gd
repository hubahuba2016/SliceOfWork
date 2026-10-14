extends Control

@onready var speaker_label: Label = $SpeakerLabel
@onready var dialogue_label: Label = $DialogueLabel

var dialogues = [
	{
		"speaker": "Narrator",
		"text": "After a long day at work, Robert finally arrives home."
	},
	{
		"speaker": "Robert",
		"text": "*Sigh* What a tiring day..."
	},
	{
		"speaker": "Narrator",
		"text": "Robert eats dinner, walks into his bedroom, and approaches his bed."
	},
	{
		"speaker": "Robert",
		"text": "Finally, time to rest."
	},
	{
		"speaker": "Narrator",
		"text": "Robert lies down on his bed and closes his eyes."
	},
	{
		"speaker": "Robert",
		"text": "Tomorrow is another day..."
	},
	{
		"speaker": "Narrator",
		"text": "Robert falls asleep."
	}
]

var dialogue_index: int = 0
var scene_finished: bool = false


func _ready() -> void:
	show_dialogue()


func _input(event: InputEvent) -> void:
	if scene_finished:
		return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			next_dialogue()

	elif event is InputEventKey:
		if event.pressed and not event.echo:
			if event.keycode == KEY_SPACE or event.keycode == KEY_ENTER:
				next_dialogue()


func show_dialogue() -> void:
	if dialogue_index >= dialogues.size():
		finish_scene()
		return

	var dialogue = dialogues[dialogue_index]

	speaker_label.text = dialogue["speaker"]
	dialogue_label.text = dialogue["text"]


func next_dialogue() -> void:
	dialogue_index += 1
	show_dialogue()


func finish_scene() -> void:
	scene_finished = true

	print("Robert has gone to sleep.")

	GameManager.start_new_day()

	get_tree().change_scene_to_file(
		"res://Scenes/Gameplay/MorningScene.tscn"
	)
