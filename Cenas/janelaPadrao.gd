extends PanelContainer

@export var Titulo : Label
var offset : Vector2

func _criado(name="sem Nome"):
	Titulo.text = name

func _on_fechar_icone_button_down() -> void:
	queue_free()
	
func _get_drag_data(at_position: Vector2) -> Variant:
	offset = get_local_mouse_position()
	return self
	
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	position = get_global_mouse_position() - offset
	return true
