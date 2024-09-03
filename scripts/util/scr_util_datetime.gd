class_name UtilDatetime

static var weekday_name_list: Array[String] = [
	"Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"]

static var month_name_list: Array[String] = [
	"Januari", "Februari", "Maret", "April", "Mei", "Juni",
	"Juli", "Agustus", "September", "Oktober", "November", "Desember",
]

static var month_days_list: Array[int] = [
	31, 28, 31, 30, 31, 30, 31,
	31, 30, 31, 30, 31,
]

# Methods

static func get_current_date_as_string() -> String:
	var time_updated: Dictionary = Time.get_date_dict_from_system()
	var time_updated_string: String = "%d/%d/%d" % [time_updated["year"], time_updated["month"], time_updated["day"]]
	return time_updated_string


static func get_weekday_name(index: int) -> String:
	return weekday_name_list[index]


static func get_month_name(index: int) -> String:
	return month_name_list[index]


static func get_month_days(index: int) -> int:
	return month_days_list[index]
