class_name InputManager
extends Node

var prev_cursor_pos: Vector2
var cursor_pos_delta: Vector2

# Main methods

func _process(_delta: float) -> void:
	_update_cursor_data()


# Private methods

func _update_cursor_data():
	var curr_cursor_pos: Vector2 = get_viewport().get_mouse_position()
	cursor_pos_delta = curr_cursor_pos - prev_cursor_pos
	prev_cursor_pos = curr_cursor_pos
