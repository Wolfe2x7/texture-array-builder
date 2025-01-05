# Texture Array Builder
Provides an importer for Godot 3 that creates TextureArray or Texture3D resources from a `JSON` build file.

Forked from [awkwardpolygons/better-texture-array](https://github.com/awkwardpolygons/better-texture-array) by Adrien de Pierres. This copy includes only the `JSON` importer for simplicity, avoiding undiagnosed errors in the inspector editor. For a complete fork with some bug fixes, see [Wolfe2x7/better-texture-array](https://github.com/Wolfe2x7/better-texture-array).

# Explanation
Godot 3.x has very buggy behaviour when attempting to save a TextureLayered (TextureArray and Texture3D), it also has poor support for TextureLayered (TextureArray and Texture3D) in the editor.

Attempting to save TextureArray and Texture3D inside the scene or as `.res` or `.tres`, produces errors.
This plugin provides a custom importer for TextureArray and Texture3D.

Godot's standard importer requires a large single image with each of the layers as a tile in a grid.

With the TextureArrayBuilder importer, you can use a simple `JSON` build format to create TextureArray and Texture3D from a list of image files.

# Guide
## Installation
1. To install copy the `texture-array-builder` from the `addons` folder to your project's `addons` folder.
2. Open your project in the editor and choose Project Settings... -> Plugins from the Project menu and enable TextureArrayBuilder.

## Importer
Create a `JSON` file with a `.ta-builder` file extension for TextureArray and `.t3d-builder` extension for Texture3D.
Select the file from the importer in the editor to customize import properties.

The `JSON` object must contain a `size` array property, and a `layers` array property.

The `size` property must have two values for the width and height the layers.

The `layers` will contain URLs to each image file or resource to use for each layer. You can use a `res://` or a `file://` reference.

A simple example file:
```json
{
  "size": [1024, 1024],
  "layers": [
    "res://assets/textures/rock1.jpg",
    "res://assets/textures/rock2.jpg",
    "res://assets/textures/rock3.jpg",
    "file://home/user/assets/snow1.jpg",
  ],
}
```

The `layers` property can also contain a more complex blending object instead of a simple URL if you want to mix channels from multiple sources into one layer.

A more complex channel mixing example:
```json
{
  "size": [1024, 1024],
  "layers": [
    {
      "rgb": ["res://assets/textures/albedo.jpg", "rgb"],
      "a": ["res://assets/textures/bump.jpg", "r"],
    },
  ],
}
```

The blending object property keys are the target channels, represented by `r`, `g`, `b`, and `a`, on their own or in combination.

The blending object property value is an array of two values, the first is the source file or resource, the second is string with the source channels or channel, again represented by `r`, `g`, `b`, and `a`.
