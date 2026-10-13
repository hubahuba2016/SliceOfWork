extends Control

@onready var narrator_label: Label = $DialogueBox/NarratorLabel
@onready var dialogue_label: Label = $DialogueBox/DialogueLabel

var dialogue_lines: Array[String] = [
	"Your name is Robert.",
	"You are a programmer working at a corporate company.",
	"You are not married yet.",
	"Every day, you write code, solve problems, and meet deadlines.",
	"Your life revolves around work, and tomorrow promises to be another ordinary day.",
	"But how long can you keep living like this?",
	"Your story begins."
]

var current_line: int = 0
var introduction_finished: bool = false


func _ready() -> void:
	narrator_label.text = "Narrator"
	show_dialogue()


func show_dialogue() -> void:
	if current_line < dialogue_lines.size():
		dialogue_label.text = dialogue_lines[current_line]
	else:
		finish_introduction()


func _input(event: InputEvent) -> void:
	if introduction_finished:
		return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			next_dialogue()

	elif event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_SPACE or event.keycode == KEY_ENTER:
			next_dialogue()


func next_dialogue() -> void:
	current_line += 1
	show_dialogue()


func finish_introduction() -> void:
	introduction_finished = true
	dialogue_label.text = "End of introduction."
	print("SliceOfWork: Introduction finished!")
	
