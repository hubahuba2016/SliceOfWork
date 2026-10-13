extends Control

@onready var character_name: Label = $UI/CharacterName
@onready var dialogue_text: Label = $UI/DialogueText

#@onready var next_button: Button = $UI/NextButton
@onready var choices: VBoxContainer = $UI/Choices

@onready var talk_button: Button = $UI/Choices/TalkToReceptionist
@onready var look_button: Button = $UI/Choices/LookAround


var dialogue = []
var dialogue_index = 0


func _ready():
	#next_button.pressed.connect(_on_next_button_pressed)
	talk_button.pressed.connect(_on_talk_button_pressed)
	look_button.pressed.connect(_on_look_button_pressed)

	start_introduction()


func start_introduction():
	dialogue = [
		{
			"speaker": "Narrator",
			"text": "This is the first day of your new job."
		}
	]

	dialogue_index = 0
	choices.visible = true
	show_dialogue()


func show_dialogue():
	if dialogue_index >= dialogue.size():
		return

	character_name.text = dialogue[dialogue_index]["speaker"]
	dialogue_text.text = dialogue[dialogue_index]["text"]


func _on_talk_button_pressed():
	dialogue = [
		{
			"speaker": "Lydia",
			"text": "Hi! My name is Lydia. How can I help you?"
		},
		{
			"speaker": "Robert",
			"text": "I'm the new employee, Robert."
		},
		{
			"speaker": "Lydia",
			"text": "Right this way, sir."
		}
	]

	dialogue_index = 0
	choices.visible = false
	show_dialogue()

func _on_look_button_pressed():
	dialogue = [
		{
			"speaker": "Robert",
			"text": "The office seems crowded yet comfortable."
		}
	]

	dialogue_index = 0
	choices.visible = false
	show_dialogue()


func _on_next_button_pressed():
	dialogue_index += 1

	if dialogue_index >= dialogue.size():
		get_tree().change_scene_to_file("res://office_scene.tscn")
	else:
		show_dialogue()


func _on_look_finished():
	_on_talk_button_pressed()

func finish_dialogue():
	#next_button.visible = false
	choices.visible = false

	character_name.text = "Narrator"
	dialogue_text.text = "Lydia leads Robert into the office."

	# You can change scenes here later.
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			advance_dialogue()

	elif event is InputEventScreenTouch:
		if event.pressed:
			advance_dialogue()

func advance_dialogue():
	if choices.visible:
		return

	dialogue_index += 1

	if dialogue_index < dialogue.size():
		show_dialogue()
	else:
		# If Robert was looking around, start Lydia's conversation.
		if dialogue.size() == 1 and dialogue[0]["speaker"] == "Robert":
			_on_talk_button_pressed()
		else:
			get_tree().change_scene_to_file("res://office_scene.tscn")
