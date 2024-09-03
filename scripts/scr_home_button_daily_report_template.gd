class_name HomeButtonDailyReportTemplate
extends BaseButton

# Main methods

func set_up():
	pressed.connect(_on_pressed)


# Signal methods

func _on_pressed():
	var daily_report_template: String = "" \
		+ "**What I did yesterday!** " + UtilString.get_random_char(Emoji.FOODS) + "\n" \
		+ "- *Write down what you did yesterday here.*\n\n" \
		+ "**What I wanna do today!** " + UtilString.get_random_char(Emoji.FOODS) + "\n" \
		+ "- *Write down what you plan on doing today here.*"
	
	DisplayServer.clipboard_set(daily_report_template)
