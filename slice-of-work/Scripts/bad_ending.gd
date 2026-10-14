extends Control

@onready var speaker_label: Label = $DialoguePanel/SpeakerLabel
@onready var dialogue_label: Label = $DialoguePanel/DialogueLabel

var dialogue: Array[Dictionary] = []
var dialogue_index: int = 0


func _ready() -> void:
	if GameManager.ending_type == "starvation":
		setup_starvation_ending()
	elif GameManager.ending_type == "exhaustion":
		setup_exhaustion_ending()
	else:
		setup_exhaustion_ending()

	show_dialogue()


func setup_starvation_ending() -> void:
	dialogue = [
		{
			"speaker": "Narrator",
			"text": "After working tirelessly, Robert suddenly collapsed. His vision blurred, and he fell to the floor."
		},
		{
			"speaker": "Narrator",
			"text": "His coworkers rushed to his side and immediately called an ambulance."
		},
		{
			"speaker": "Paramedic",
			"text": "Sir! Can you hear me? Stay with us!"
		},
		{
			"speaker": "Narrator",
			"text": "Robert was rushed to the nearest hospital."
		},
		{
			"speaker": "Narrator",
			"text": "Later, Robert woke up in a hospital bed. An IV drip was attached to his arm."
		},
		{
			"speaker": "Robert",
			"text": "Where... am I?"
		},
		{
			"speaker": "Doctor",
			"text": "You're in the hospital. Your body was severely deprived of food."
		},
		{
			"speaker": "Robert",
			"text": "But... I had work to do..."
		},
		{
			"speaker": "Doctor",
			"text": "Work? You nearly lost your life. You can't keep neglecting your basic needs like this."
		},
		{
			"speaker": "Narrator",
			"text": "Robert stared at the ceiling, realizing how much he had sacrificed just to keep his job."
		},
		{
			"speaker": "Robert",
			"text": "Was it really worth it?"
		},
		{
			"speaker": "Narrator",
			"text": "Sometimes, surviving the day is more important than finishing the work."
		},
		{
			"speaker": "Narrator",
			"text": "THE END — STARVATION."
		}
	]


func setup_exhaustion_ending() -> void:
	dialogue = [
		{
			"speaker": "Narrator",
			"text": "Robert continued working without giving himself enough time to rest. His body grew weaker with every passing hour."
		},
		{
			"speaker": "Narrator",
			"text": "Suddenly, his legs gave out. He collapsed right beside his desk."
		},
		{
			"speaker": "Coworker",
			"text": "Robert?! Hey! Somebody call an ambulance!"
		},
		{
			"speaker": "Narrator",
			"text": "Within minutes, paramedics arrived and rushed Robert to the hospital."
		},
		{
			"speaker": "Narrator",
			"text": "Hours later, Robert opened his eyes in a hospital bed."
		},
		{
			"speaker": "Robert",
			"text": "What happened?"
		},
		{
			"speaker": "Doctor",
			"text": "You collapsed from severe exhaustion. Your body simply couldn't keep going."
		},
		{
			"speaker": "Robert",
			"text": "But... I needed to finish my work..."
		},
		{
			"speaker": "Doctor",
			"text": "No job is worth destroying your health. Your body needs rest, no matter how important you think your work is."
		},
		{
			"speaker": "Narrator",
			"text": "Robert looked at his hands. He had worked so hard to build a better future that he had forgotten to take care of himself."
		},
		{
			"speaker": "Robert",
			"text": "I just wanted to succeed..."
		},
		{
			"speaker": "Narrator",
			"text": "But success means little when you sacrifice yourself to achieve it."
		},
		{
			"speaker": "Narrator",
			"text": "THE END — EXHAUSTION."
		}
	]


func show_dialogue() -> void:
	if dialogue_index >= dialogue.size():
		speaker_label.text = ""
		dialogue_label.text = "GAME OVER"
		return

	var current_line: Dictionary = dialogue[dialogue_index]

	speaker_label.text = current_line["speaker"]
	dialogue_label.text = current_line["text"]


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if dialogue_index < dialogue.size():
				dialogue_index += 1
				show_dialogue()
				get_viewport().set_input_as_handled()
