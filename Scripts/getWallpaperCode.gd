extends TextureRect

var user
var pathWallpaperNormal = "C:/Users/%s/AppData/Roaming/Microsoft/Windows/Themes/CachedFiles/CachedImage_1920_1080_POS4.jpg"

func _ready() -> void:
	
	if OS.has_environment("USERNAME"):
		user = OS.get_environment("USERNAME")
	else:
		user = "Player"
		
	var pathWallpaper = pathWallpaperNormal % user
	
	var image = Image.load_from_file(pathWallpaper)
	var textureI = ImageTexture.create_from_image(image)
	
	#texture = textureI
