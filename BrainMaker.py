import bpy
import os
import sys

# Get system argument
output_dir = sys.argv
output_dir = output_dir[output_dir.index("--") + 1]

# Delete the default objects of the startup scene
bpy.ops.object.select_all(action = 'SELECT')
bpy.ops.object.delete(use_global = True)

# Change working directory
os.chdir(output_dir)

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
bpy.ops.export_mesh.stl(filepath = 'PrintBrain.stl')
