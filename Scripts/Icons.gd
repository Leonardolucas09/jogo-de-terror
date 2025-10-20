extends TextureButton
class_name Icons

@export var Name : String # Nome do Icone
var JanelaPadrao = preload("res://Recursos/JanelaPadrao.tscn") # Objeto padrão da Janela
@export var node_janelas : Control # Grupo onde as janelas vão ficar

func _init(p_name = "Null"): #Quando o Icone é instanciado
	Name = p_name
	
func _ready() -> void: 
	self.button_down.connect(_callNameButton) #Conecta o sinal de quando o botão é clicado com a função _callNameButton
	
func _callNameButton():
	print("Nome do botao é ", Name)
	var janela = JanelaPadrao.instantiate() # Instancia uma Janela
	node_janelas.add_child(janela) # Adiciona a Janela criada ao grupo de janelas
	janela._criado(Name) # Aciona a Variável _criado da janela
	
