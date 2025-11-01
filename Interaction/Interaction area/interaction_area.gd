extends Area2D
class_name InteractionArea

@export var action_name : String = "interact" # Um texto que é mostrado acima de um objeto para indicar que é interativo.

var interact : Callable = func():
	pass


func _on_body_entered(body):
	InteractionManager.register_area(self)


func _on_body_exited(body):
	InteractionManager.unregister_area(self)
