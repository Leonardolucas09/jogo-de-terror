extends TextureButton
class_name Icons

@export var Name : String
var JanelaPadrao = preload("res://Recursos/JanelaPadrao.tscn")
@export var node_janelas : Control

func _init(p_name = "Null"):
	Name = p_name
	
func _ready() -> void:
	self.button_down.connect(_callNameButton)
	
func _callNameButton():
	print("Nome do botao é ", Name)
	var janela = JanelaPadrao.instantiate()
	node_janelas.add_child(janela)
	janela._criado(Name)
	
