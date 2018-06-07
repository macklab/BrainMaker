## BrainMaker
Converts reconstructed surfaces into printable 3D model.

### Description
By default, this docker will take a single participant's reconstructed surfaces
and create three .stl files (one for each hemisphere and one of both hemispheres combined).
It will then slice the .stl file of both hemispheres into a printable file.

By default, the docker will load .stl files into Blender to position, combine, and
export a complete model of the brain via a default python script. The right hemisphere is moved slightly closer
to the left hemisphere to ensure that a printable model is generated. The complete
model is sliced using Slic3r using a default configuration file built for a Prusa i3 MK2S
printer. The Python script for Blender and the .ini file for Slic3r can be replaced
for advanced controls of those components of the process.

#### Special Requirements
It is expected that there are reconstructed surfaces available to convert into .stl files.
Freesurfer's recon-all must be run before this docker. The recon-all outputs are by default expected
to be placed inside a subject specific bids directory /derivatives/sbj_{ID}/surf/.

A freesurfer license is necessary, it should be placed in a volume mounted to /configs. 

Current code to run:
```Shell
docker run --rm -it \
  -v ~/Desktop/brainMakerTest/bids:/data:ro \
  -v ~/Desktop/brainMakerTest/bids/derivatives/BrainMaker/:/outputs \
  -v ~/Desktop/brainMakerTest/bids/code:/configs:ro \
  brainmaker:latest /data /outputs participant \
  --participant_label 001 \
  --freesurfer_output_loc derivatives/freesurfer/
  --blender_config blender.py \
  --slicer_config slicer.ini \
  --slice true \
  --gcode_scale 0.1 \
```
