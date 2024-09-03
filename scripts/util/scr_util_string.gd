class_name UtilString

static func get_random_char(string: String) -> String:
	var index: int = randi_range(0, string.length() - 1)
	return string[index]


static func get_progress_bar(progress: float, bar_length: int = 40) -> String:
	var decimal_bars: String = "⡀⡄⡆⡇⣇⣧⣷⣿"
	var progress_bar: String = ""
	
	var scaled_progress: float = progress * bar_length
	var floored_progress: int = int(floor(scaled_progress))
	
	var i: int = 0
	while i < floored_progress - 1:
		progress_bar += "⣿"
		i += 1
	
	if i < bar_length:
		var decimal_part: float = scaled_progress - float(floored_progress)
		var decimal_bar_index: int = int(round(decimal_part * (decimal_bars.length() - 1)))
		progress_bar += decimal_bars[decimal_bar_index]
		i += 1
	
	while i < bar_length:
		progress_bar += "⡀"
		i += 1
	
	return progress_bar
