extends PanelContainer

@export var Titulo : Label

var start : Vector2
var initialPosition : Vector2
var isMoving : bool
var isResizing : bool
var ResizeX : bool
var ResizeY : bool
var InitialSize : Vector2
@export var grabThreshold := 20
@export var resizeThreshold := 5

func _criado(_name="sem Nome"):
	Titulo.text = name

func _set_name(_name="null"):
	Titulo.text = name

func _on_fechar_icone_button_down() -> void:
	queue_free()
	

func _input(event):
	if Input.is_action_just_pressed("LeftMouseDown"):
		var rect = get_global_rect()
		var localMousePos = event.position - get_global_position()
		if localMousePos.y < grabThreshold:
			start = event.position
			initialPosition = get_global_position()
			isMoving = true
		else:
			if abs(localMousePos.x - rect.size.x) < resizeThreshold:
				start.x = event.position.x
				InitialSize.x = get_size().x
				ResizeX = true
				isResizing = true
			if abs(localMousePos.y - rect.size.y) < resizeThreshold:
				start.y = event.position.y
				InitialSize.y = get_size().y
				ResizeY = true
				isResizing = true
			
			if localMousePos.x < resizeThreshold && localMousePos.x > -resizeThreshold:
				start.x = event.position.x
				initialPosition.x = get_global_position().x
				InitialSize.x = get_size().x
				isResizing = true
				ResizeX = true
			if localMousePos.y < resizeThreshold && localMousePos.y > -resizeThreshold:
				start.y = event.position.y
				initialPosition.y = get_global_position().y
				InitialSize.y = get_size().y
				isResizing = true
				ResizeY = true

	if Input.is_action_pressed("LeftMouseDown"):
		if isMoving:
			set_position(initialPosition + (event.position - start))
		
		if isResizing:
			var newLargura = get_size().x
			var newAltura = get_size().y
			
			if ResizeX:
				newLargura = InitialSize.x - (start.x - event.position.x)
			if ResizeY:
				newAltura = InitialSize.y - (start.y - event.position.y)
			
			if initialPosition.x != 0:
				newLargura = InitialSize.x + (start.x - event.position.x)
				set_position(Vector2(initialPosition.x - (newLargura - InitialSize.x), get_position().y))
			if initialPosition.y != 0:
				newAltura = InitialSize.y + (start.y - event.position.y)
				set_position(Vector2(get_position().y, initialPosition.y - (newAltura - InitialSize.y)))
			
			set_size(Vector2(newLargura, newAltura))
			
	if Input.is_action_just_released("LeftMouseDown"):
		isMoving = false
		isResizing = false
		initialPosition = Vector2(0,0)
		ResizeX = false
		ResizeY = false
		
		
