extends Control

@onready var clock_label: Label = $UI/ClockLabel
@onready var money_label: Label = $UI/MoneyLabel
@onready var hunger_label: Label = $UI/HungerLabel
@onready var stamina_label: Label = $UI/StaminaLabel
@onready var status_label: Label = $UI/StatusLabel

@onready var buy_food_button: Button = $Actions/BuyFoodButton
@onready var take_nap_button: Button = $Actions/TakeNapButton
@onready var work_button: Button = $Actions/WorkButton


func _ready() -> void:
	work_button.text = "Work"
	buy_food_button.text = "Buy Food ($20)"
	take_nap_button.text = "Take a Nap"

	work_button.pressed.connect(_on_work_pressed)
	buy_food_button.pressed.connect(_on_buy_food_pressed)
	take_nap_button.pressed.connect(_on_take_nap_pressed)

	update_ui()

	# Check whether the workday has already ended.
	if GameManager.hour >= 17:
		end_workday()


func update_ui() -> void:
	clock_label.text = "Time: " + GameManager.get_time_string()
	money_label.text = "Money: $" + str(GameManager.money)
	hunger_label.text = "Hunger: " + str(roundi(GameManager.hunger))
	stamina_label.text = "Stamina: " + str(roundi(GameManager.stamina))

	if GameManager.hunger <= 20.0:
		status_label.text = "Robert is very hungry!"
	elif GameManager.stamina <= 20.0:
		status_label.text = "Robert is exhausted!"
	else:
		status_label.text = "Robert is ready to work."


func _on_buy_food_pressed() -> void:
	if GameManager.hour >= 17:
		end_workday()
		return

	var previous_money: int = GameManager.money

	GameManager.buy_food(20, 40.0)

	if GameManager.money < previous_money:
		status_label.text = "Robert bought some food."
	else:
		status_label.text = "Not enough money!"

	update_ui()

	if GameManager.hour >= 17:
		end_workday()


func _on_take_nap_pressed() -> void:
	if GameManager.hour >= 17:
		end_workday()
		return

	GameManager.take_nap(30, 50.0)

	status_label.text = "Robert took a 30-minute nap."
	update_ui()

	if GameManager.hour >= 17:
		end_workday()


func _on_work_pressed() -> void:
	if GameManager.game_over or GameManager.ending_triggered:
		return

	GameManager.work(60)

	# Stop if Robert collapsed during work.
	if GameManager.ending_triggered:
		return

	GameManager.complete_work()

	if GameManager.ending_triggered:
		return

	status_label.text = "Robert worked for one hour."

	update_ui()

	if GameManager.hour >= 17:
		end_workday()

func end_workday() -> void:
	if GameManager.game_over or GameManager.ending_triggered:
		return

	# Pay Robert his salary.
	GameManager.money += GameManager.daily_salary

	print("Robert received his salary: $", GameManager.daily_salary)
	print("Current money: $", GameManager.money)

	# Check whether Robert has earned enough money.
	GameManager.check_money_ending()

	if GameManager.ending_triggered:
		return

	# Advance the clock by 8 hours.
	GameManager.advance_time(480)

	# Mark the workday as finished.
	GameManager.game_over = true

	update_ui()
	status_label.text = "Work is finished! Time to go home."

	work_button.disabled = true
	buy_food_button.disabled = true
	take_nap_button.disabled = true

	print("Robert finished work.")

	get_tree().change_scene_to_file(
		"res://Scenes/Gameplay/BedroomScene.tscn"
	)
