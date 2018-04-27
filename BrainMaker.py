import bpy

# Import both hemispheres as stl's into blender
bpy.ops.import_mesh.stl(filepath = 'lh.pial.stl')
bpy.ops.import_mesh.stl(filepath = 'rh.pial.stl')

# Select only the right hemisphere
bpy.ops.object.select_all(action = 'DESELECT')
bpy.data.objects['Rh.Pial'].select = True

# Translate the right hemisphere to ensure printability
bpy.ops.transform.translate(value = (-2.0, 0.0, 0.0))

# Select all for rotation then export
bpy.ops.object.select_all(action = 'SELECT')

# Rotate for slic3r
bpy.ops.transform.rotate(value = 1.57, axis = (90, 0, 0))

# Export as obj
bpy.ops.export_scene.obj(filepath = 'PrintBrain.obj')