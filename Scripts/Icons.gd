extends TextureButton
class_name Icons

@export var Name : String
@export var Janela : Control
@export var Botao : TextureButton

func _init(p_name = "Null"):
	Name = p_name
	
func _ready() -> void:
	self.button_down.connect(_callNameButton)
	
func _callNameButton():
	print("Nome do botao é ", Name)
