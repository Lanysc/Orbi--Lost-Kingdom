extends MarginContainer

const MAX_WIDTH = 256

signal text_display_finished

@onready var label = $LabelMargin/Label
@onready var timer = $Timer

var text = ""
var letter_index = 0
var letter_diplay_timer = 0.07
var space_diplay_timer = 0.05
var punctuation_diplay_timer = 0.02


func _ready():
	timer.timeout.connect(on_timer_timeout)


func display_text(text_to_display: String):
	text = text_to_display
	label.text = text_to_display
	
	await resized
	
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		
		custom_minimum_size.y = size.y
	
	global_position.x -= size.x / 2
	global_position.y -= size.y + 24
	label.text = ""
	display_letter()


func display_letter():
	if letter_index >= text.length():
		text_display_finished.emit()
		return
	
	label.text += text[letter_index]
	
	match text[letter_index]:
		"!", "?", ",", ".":
			timer.start(punctuation_diplay_timer)
		" ":
			timer.start(space_diplay_timer)
		_:
			timer.start(letter_diplay_timer)
	
	letter_index += 1



func on_timer_timeout():
	display_letter()
