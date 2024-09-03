class_name HomeManager
extends Control

static var input_manager: InputManager

var debug_progress: float = 0

var daily_announcement_template_button: HomeButtonDailyAnnouncementTemplate
var daily_report_template_button: HomeButtonDailyReportTemplate
var debug_label: Label

# Main methods

func _ready() -> void:
	_set_up()


func _set_up():
	input_manager = $InputManager
	
	daily_announcement_template_button = $Button_DailyAnnouncementTemplate
	daily_report_template_button = $Button_DailyReportTemplate
	debug_label = $Label_Debug
	
	daily_announcement_template_button.set_up()
	daily_report_template_button.set_up()


func _process(delta: float) -> void:
	debug_progress += 0.001 * input_manager.cursor_pos_delta.x
	debug_progress = clampf(debug_progress, 0, 1)
	
	debug_label.text = "" \
		+ UtilString.get_progress_bar(debug_progress) \
		+ "\n%.4f" % debug_progress
