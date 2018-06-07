import bpy
import bmesh
import os
import sys

# Print out for debugging
print('Importing STLs into Blender for translation and export.')

# Get system argument
arguments = sys.argv
output_dir = arguments[arguments.index("--") + 1]
sbj = arguments[arguments.index('--') + 2]

print(output_dir)

# Delete the default objects of the startup scene
bpy.ops.object.select_all(action = 'SELECT')
bpy.ops.object.delete(use_global = True)

# Change working directory
os.chdir(output_dir)

# Import both hemispheres as stl's into blender
bpy.ops.import_mesh.stl(filepath = 'sub' + sbj + '_lh.pial.stl')
bpy.ops.import_mesh.stl(filepath = 'sub' + sbj + '_rh.pial.stl')

# Select only the right hemisphere and convert to bmesh
obj = bpy.data.objects['Sub' + sbj + ' Rh.Pial']
bm = bmesh.new()
bm.from_mesh(obj.data)

# Translate the right hemisphere to ensure printability
bmesh.ops.translate(bm, vec = (-2.0, 0.0, 0.0), verts = bm.verts)

# Convert bmesh back into mesh and update
bm.to_mesh(obj.data)
obj.data.update()

# Select all for rotation then export
bpy.ops.object.select_all(action = 'SELECT')

# Export as obj
bpy.ops.export_mesh.stl(filepath = 'sub' + sbj + '_PrintBrain.stl')
