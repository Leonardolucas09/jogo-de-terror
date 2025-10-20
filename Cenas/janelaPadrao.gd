extends PanelContainer

@export var Titulo : Label

var start : Vector2 # Vetor que vai receber a posição inicial do mouse 
var initialPosition : Vector2 # Vetor que vai receber a posição inicial da Janela, expecificamente a posição superior esquerdo
var isMoving : bool # Booleano que vai nos ajudar a saber quando estivermos movendo a janela
var isResizing : bool # Booleano que vai nos ajudar a saber quando estivermos dimensionando a janela
var ResizeX : bool # --
var ResizeY : bool # Booleanos que vão nos ajudar a saber em qual direção estamos dimensionando a janela
var InitialSize : Vector2 # Vetor com o tamanho inicial da janela
@export var grabThreshold := 25 # Espaço que o mouse vai detectar a possibilidade de mover a tela
@export var resizeThreshold := 5 # Espaço que o moude vai detectar a possiblidade de dimensionar a tela
@export var minLargura := 200 # Largura minimo que a Janela pode ter
@export var minAltura := 200 # Altura minimo que a Janela pode ter

func _criado(_name="sem Nome"): # Função que sera chamada pelo icone para setar as infomações iniciais
	Titulo.text = name

func _set_name(_name="null"): # Função usada para setar um novo nome para a janela
	Titulo.text = name

func _on_fechar_icone_button_down() -> void: # Função que é ativada quando o jogador clica no icone de fechar
	queue_free() #excluindo a janela
	

func _input(event): #função chamada quando um evento acontece
	if Input.is_action_just_pressed("LeftMouseDown"): # If para detectar se o evento ocorrido foi a o botão esquerdo do mouse sendo pressionado
		var rect = get_global_rect() # Retorna uma variavel do tipo Rect2 onde vai ter a posição da Janela e o Tamanho
		var localMousePos = event.position - get_global_position() # Retorna a posição do mouse em relação a Janela
		if localMousePos.y < grabThreshold: # Detecta se o Mouse está na area para ser movido 
			start = event.position # Captura a Posição Inicial do Mouse
			initialPosition = get_global_position() # Captura a Posição Inicial da Tela
			isMoving = true 
		else:
			if abs(localMousePos.x - rect.size.x) < resizeThreshold: # Detecta quando o Mouse esta na borda direita
				start.x = event.position.x # Captura a posição incial do mouse no eixo x
				InitialSize.x = get_size().x # Captura o tamanho horizontal atual da Janela
				ResizeX = true
				isResizing = true
			if abs(localMousePos.y - rect.size.y) < resizeThreshold: # Detecta quando o Mouse esta na borda inferior
				start.y = event.position.y # Captura a posição incial do mouse no eixo y
				InitialSize.y = get_size().y # Captura o tamanho vertical atual da Janela
				ResizeY = true
				isResizing = true
			
			if localMousePos.x < resizeThreshold && localMousePos.x > -resizeThreshold: # Detecta de o Mouse está na borda esquerda
				start.x = event.position.x
				initialPosition.x = get_global_position().x
				InitialSize.x = get_size().x
				isResizing = true
				ResizeX = true
			if localMousePos.y < resizeThreshold && localMousePos.y > -resizeThreshold: # Detecta de o Mouse está na borda Superior
				start.y = event.position.y
				initialPosition.y = get_global_position().y
				InitialSize.y = get_size().y
				isResizing = true
				ResizeY = true

	if Input.is_action_pressed("LeftMouseDown"): # É chamado enquanto o mouse estiver sendo precionado 
		if isMoving:
			set_position(initialPosition + (event.position - start)) # Seta a posição da Janela como sendo a diferença da posição atual do mouse menos a posição inicial e adiciona o valoor resultante na posição inicial da Janela
		
		if isResizing:
			var newLargura = get_size().x # Cria uma nova variavel com o tamanho atual da Janela
			var newAltura = get_size().y # --
			
			if ResizeX && (InitialSize.x - (start.x - event.position.x)) >= minLargura && initialPosition.x == 0:
				newLargura = InitialSize.x - (start.x - event.position.x) # Adiciona a diferença da posição inicial do mouse menos sua posição atual na variavel
			if ResizeY && (InitialSize.y - (start.y - event.position.y)) >= minAltura && initialPosition.y == 0:
				newAltura = InitialSize.y - (start.y - event.position.y) # --
			
			if initialPosition.x != 0 && (InitialSize.x + (start.x - event.position.x)) >= minLargura: # Condição chamada apenas quando estamos redimencionando a lateral esquerda
				newLargura = InitialSize.x + (start.x - event.position.x) 
				set_position(Vector2(initialPosition.x - (newLargura - InitialSize.x), get_position().y))
			if initialPosition.y != 0 && (InitialSize.y + (start.y - event.position.y)) >= minAltura: # Condição chamada apenas quando estamos redimencionando a borda superior
				newAltura = InitialSize.y + (start.y - event.position.y)
				set_position(Vector2(get_position().y, initialPosition.y - (newAltura - InitialSize.y)))
			
			set_size(Vector2(newLargura, newAltura)) # Seta o tamanho correto da tela
			
	if Input.is_action_just_released("LeftMouseDown"): # Chamado quando o botão do mouse for solto
		isMoving = false
		isResizing = false
		initialPosition = Vector2(0,0)
		ResizeX = false
		ResizeY = false
		#reseta todas as variáveis importantes
		
