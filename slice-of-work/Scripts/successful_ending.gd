extends Control

@onready var speaker_label: Label = $UI/SpeakerLabel
@onready var dialogue_label: Label = $UI/DialogueLabel

var current_dialogue: int = 0

var dialogues: Array[Dictionary] = [
	{
		"speaker": "Narrator",
		"text": "After some time at the office, Lydia called and asked you to come to the upper management house."
	},
	{
		"speaker": "Ashley",
		"text": "Ah, you must be Robert. I'm your boss—or, as I like to call it, your upper management."
	},
	{
		"speaker": "Robert",
		"text": "What brings me here?"
	},
	{
		"speaker": "Ashley",
		"text": "I've been watching your work for some time, and I'm impressed. You've been promoted!"
	},
	{
		"speaker": "Narrator",
		"text": "THE END"
	}
]


func _ready() -> void:
	show_dialogue()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			next_dialogue()


func next_dialogue() -> void:
	current_dialogue += 1

	if current_dialogue >= dialogues.size():
		return_to_menu()
		return

	show_dialogue()


func show_dialogue() -> void:
	var dialogue: Dictionary = dialogues[current_dialogue]

	speaker_label.text = dialogue["speaker"]
	dialogue_label.text = dialogue["text"]


func return_to_menu() -> void:
	print("Successful ending completed!")
