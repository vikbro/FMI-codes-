extends LineEdit

var num

func _ready() -> void:
	$".".text_submitted.connect(_on_text_submitted)
	
func _on_text_submitted(text):
	if text.is_valid_float():
		num = float(text)
		print("User: ", text)
		$".".clear()
		Event.angle_input.emit(num)
		$".".visible = false
	else:
		$".".clear()
		$".".visible = false
