extends Node

# Game clock
var hour: int = 7
var minute: int = 0

# Player resources
var money: int = 100
var hunger: float = 100.0
var stamina: float = 100.0

# Game state
var current_day: int = 1
var game_over: bool = false
# Work
var daily_salary: int = 100
# Work progress
var work_completed: int = 0
var work_target: int = 10
# Money target
var money_target: int = 1000

# Ending state
var ending_triggered: bool = false
var ending_type: String = ""
func advance_time(minutes: int) -> void:
	minute += minutes

	while minute >= 60:
		minute -= 60
		hour += 1

	print("Time: ", get_time_string())


func get_time_string() -> String:
	return "%02d:%02d" % [hour, minute]


func spend_money(amount: int) -> bool:
	if money < amount:
		print("Not enough money!")
		return false

	money -= amount
	return true


func buy_food(price: int, hunger_restore: float) -> void:
	if spend_money(price):
		hunger = minf(hunger + hunger_restore, 100.0)
		print("Food purchased!")
		print("Money: ", money)
		print("Hunger: ", hunger)


func take_nap(minutes: int, stamina_restore: float) -> void:
	advance_time(minutes)
	stamina = minf(stamina + stamina_restore, 100.0)
	print("Stamina restored: ", stamina)


func work(minutes: int) -> void:
	advance_time(minutes)

	hunger -= minutes * 0.2
	stamina -= minutes * 0.3

	print("Hunger: ", hunger)
	print("Stamina: ", stamina)

	# Check whether Robert has collapsed.
	if hunger <= 0.0:
		trigger_ending("starvation")
	elif stamina <= 0.0:
		trigger_ending("exhaustion")


func start_new_day() -> void:
	current_day += 1

	hour = 7
	minute = 0

	hunger = 100.0
	stamina = 100.0

	game_over = false

func complete_work() -> void:
	if game_over or ending_triggered:
		return

	work_completed += 1

	print("Work completed: ", work_completed, "/", work_target)

	if work_completed >= work_target:
		trigger_ending("work_success")


func check_money_ending() -> void:
	if game_over or ending_triggered:
		return

	if money >= money_target:
		trigger_ending("money_success")


func trigger_ending(type: String) -> void:
	if ending_triggered:
		return

	ending_triggered = true
	ending_type = type

	if type == "work_success" or type == "money_success":
		get_tree().change_scene_to_file(
			"res://Scenes/Gameplay/SuccessfulEnding.tscn"
		)
	elif type == "starvation" or type == "exhaustion":
		get_tree().change_scene_to_file(
			"res://Scenes/Gameplay/BadEnding.tscn"
		)
