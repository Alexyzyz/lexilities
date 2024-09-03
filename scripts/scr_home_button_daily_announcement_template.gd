class_name HomeButtonDailyAnnouncementTemplate
extends Button

var quote: String
var quote_author: String

# Main methods

func set_up():
	disabled = true
	text = "Preparing daily announcement..."
	
	pressed.connect(_on_pressed)


# Public methods

func set_quote(quote: String, author: String):
	disabled = false
	text = "Copy daily announcement template"
	
	self.quote = quote
	quote_author = author


# Signal methods

func _on_pressed():
	# Ping everyone!
	var user_ids: Array[String] = [
		Discord.USER_ID["adem"],
		Discord.USER_ID["alex"],
		Discord.USER_ID["kopi"],
		Discord.USER_ID["rick"],
		Discord.USER_ID["toby"],
		Discord.USER_ID["toru"],
		Discord.USER_ID["yaur"],
	]
	var segment_pings: String = "<@%s> <@%s> <@%s> <@%s> <@%s> <@%s> <@%s>" % user_ids
	
	# Let everyone know the date and time!
	var time: Dictionary = Time.get_datetime_dict_from_system()
	var day: int = time["weekday"]
	var date: int = time["day"]
	var month: int = time["month"]
	var year: int = time["year"]
	var month_name: String = UtilDatetime.get_month_name(month - 1)
	var week: int = int(floor(float(date) / 7))
	
	var segment_day: String = "" \
		+ "Selamat pagi semuanya! Selamat hari **%s!**\n" % UtilDatetime.get_weekday_name(day - 1) \
		+ "Sekarang adalah tanggal **%d %s %d.**\n\n" % [date, month_name, year] \
		+ segment_pings + "\n\n" \
		+ "Kita sudah di\n**【 Minggu %d / 4 】\n               【 Hari %d / 7 】**\n" % [week + 1, day]
	
	var days_until_weekend: int = 5 - day
	var segment_weekend: String = ""
	if days_until_weekend > 1:
		segment_weekend = "Semangat!\nSisa **%d hari** lagi menuju akhir pekan!" % days_until_weekend
	else:
		var days_until_monday: int = (6 - day) + 1
		segment_weekend = "Masih ada **%d hari** sebelum Senin!" % days_until_monday
	
	# Calculate month progress!
	var month_day_count: int = UtilDatetime.get_month_days(month - 1)
	var progress: float = float(date) / float(month_day_count)
	
	var segment_progress: String = "" \
		+ "Bulan **%s** sudah **%.2f%% selesai!**\n" % [month_name, 100.0 * progress] \
		+ UtilString.get_progress_bar(progress) + "\n\n" \
		+ "Mari kita manfaatkan waktu kita dengan baik!"
	
	# Add in the quote of the day!
	
	var segment_quote: String = "" \
		+ "👑 **Quote of the day**\n" \
		+ "> \"%s\"\n" % quote \
		+ "    *—%s*" % quote_author
	
	# Put together the announcement!
	var daily_announcement_template: String = \
		"%s\n%s\n\n%s\n\n%s" % [segment_day, segment_weekend, segment_progress, segment_quote]
	
	DisplayServer.clipboard_set(daily_announcement_template)
