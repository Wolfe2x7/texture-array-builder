tool
extends EditorPlugin

var import_array
var import_3d

func _enter_tree():
	import_array = preload("res://addons/texture-array-builder/texture_array_builder.gd").new()
	import_array.is_3d = false
	import_3d = preload("res://addons/texture-array-builder/texture_array_builder.gd").new()
	import_3d.is_3d = true
	add_import_plugin(import_array)
	add_import_plugin(import_3d)

func _exit_tree():
	remove_import_plugin(import_array)
	remove_import_plugin(import_3d)
