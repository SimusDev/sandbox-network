extends Panel

@export var _line_edit: LineEdit
@export var _rich_text_label: RichTextLabel

func _ready() -> void:
	_rich_text_label.text = ""
	S_Chat.get_instance().on_message_recieved.connect(_on_message_recieved)

func _on_message_recieved(msg: String) -> void:
	_rich_text_label.text += msg + "\n"
	

func _on_line_edit_text_submitted(new_text: String) -> void:
	_line_edit.text = ""
	S_Chat.send_message(new_text)
