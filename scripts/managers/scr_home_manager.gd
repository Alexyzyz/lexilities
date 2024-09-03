class_name HomeManager
extends Control

static var input_manager: InputManager
static var http_request: HTTPRequest

var debug_progress: float = 0

var daily_announcement_template_button: HomeButtonDailyAnnouncementTemplate
var daily_report_template_button: HomeButtonDailyReportTemplate
var debug_label: Label

# Main methods

func _ready() -> void:
	_set_up()
	_update_daily_quote()


func _set_up():
	input_manager = $InputManager
	http_request = $HTTPRequest
	
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


# Private methods

func _update_daily_quote():
	if FileAccess.file_exists("user://game_data.txt"):
		var data_file: FileAccess = FileAccess.open("user://game_data.txt", FileAccess.READ)
		var data: Dictionary = JSON.parse_string(data_file.get_as_text())
		
		# Only use existing local data if we're on the same date.
		if data["last_updated"] == UtilDatetime.get_current_date_as_string():
			daily_announcement_template_button.set_quote(data["quote"], data["author"])
	
	# Otherwise, it's time to make an API call.
	http_request.request_completed.connect(_update_daily_quote_from_response)
	http_request.request("https://zenquotes.io/api/today")


func _update_daily_quote_from_response(_result, _response_code, _headers, body):
	var response_json: Array = JSON.parse_string(body.get_string_from_utf8())
	
	var quote_data: Dictionary = {
		"quote": response_json[0]["q"],
		"author": response_json[0]["a"],
		"last_updated": UtilDatetime.get_current_date_as_string(),
	}
	
	var quote_data_string: String = JSON.stringify(quote_data)
	var data_file: FileAccess = FileAccess.open("user://game_data.txt", FileAccess.WRITE)
	data_file.store_string(quote_data_string)
	
	daily_announcement_template_button.set_quote(quote_data["quote"], quote_data["author"])
