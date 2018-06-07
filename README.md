## BrainMaker
BrainMaker converts reconstructed surfaces into a printable 3D model.

### Description
BrainMaker will take a single participant's reconstructed surfaces and create
.stl files (one for each hemisphere and one of both hemispheres combined). It
will then slice the .stl file of both hemispheres into a printable file.

By default, BrainMaker will use Freesurfer to convert left and right hemisphere
surfaces into a .stl files. These will be loaded into Blender to position,
combine, and export a complete model of the brain via a default python script.
The right hemisphere is moved slightly closer to the left hemisphere to ensure
that a printable file is produced. The complete model is sliced using Slic3r
using a default configuration file at 0.2 scale. The configuration is built for
a Prusa i3 MK2S printer. The Python script for Blender and the .ini file for
Slic3r can be replaced for advanced controls of those components of the process.

### Documentation
A Freesurfer license is necessary, it should be placed in the volume mounted to
/configs.

It is expected that there are reconstructed surfaces available to convert into
.stl files. Freesurfer's recon-all must be run before this docker. The recon-all
outputs are, by default, expected to be placed inside a subject specific bids
directory: `{bids_dir}/derivatives/freesurfer/sbj_{ID}/surf/`. The level of
analysis will always be at the participant level, therefore, the participant
label name-value argument is required.

The default configuration for Blender and Slic3r files can be overwritten by
placing the file in the volume mounted to /configs with the corresponding
name-value argument. The default configuration prints within two hours with the
Prusa i3 MK2S printer.

The Blender python script imports .stl files for manipulation and output using
the bpy and bmesh modules. These modules are built into Blender and do not
require further dependencies. However, these modules do not exist independently
to Blender and therefore must be tested using Blender. A custom Blender python
script must accept and output a similar format of .stl files. For more
information on these modules, refer to the
[documentation](https://docs.blender.org/api/2.79/).

The Slic3r configuration file controls the parameters that create the print
instructions. It should be noted that Slic3r only generates G-Code files and
some printers require other formats. The automated slicing can be disabled in
this case. As the default configuration file was built with the Prusa i3 MK2S
printer in mind, the generated G-Code may not be usable for some printers.
Slic3r is highly configurable for many printers, using the its GUI to generate a
customized configuration.ini file is recommended. For more information on
Slic3r, refer to the [manual](http://manual.slic3r.org/advanced/command-line).

### Usage
BrainMaker has the following command line arguments:
```Shell

```
Basic usage:
```Shell
docker run --m -it \
  -v ~/Desktop/brainMakerTest/bids:/data:ro \
  -v ~/Desktop/brainMakerTest/bids/derivatives/BrainMaker/:/outputs \
  -v ~/Desktop/brainMakerTest/bids/code:/configs:ro \
  brainmaker:latest /data /outputs participant
  --participant_label 001
```
An example usage of using BrainMaker with all possible arguments:
```Shell
docker run --rm -it \
  -v ~/Desktop/brainMakerTest/bids:/data:ro \
  -v ~/Desktop/brainMakerTest/bids/derivatives/BrainMaker/:/outputs \
  -v ~/Desktop/brainMakerTest/bids/code:/configs:ro \
  brainmaker:latest /data /outputs participant \
  --participant_label 001 \
  --freesurfer_output_loc derivatives/freesurfer/ \
  --blender_config blender.py \
  --slicer_config slicer.ini \
  --slice true \
  --gcode_scale 0.1
```
