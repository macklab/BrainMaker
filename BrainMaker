#!/bin/bash
cd Desktop/BrainMaker/

export FREESURFER_HOME=/Applications/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh

mris_convert lh.pial lh.pial.stl
mris_convert rh.pial rh.pial.stl

/Applications/blender-2.79-macOS-10.6/blender.app/Contents/MacOS/blender \
--background --python BrainMaker.py

/Applications/Slic3r.app/Contents/MacOS/slic3r PrintBrain.stl \
--load BrainMaker.ini --scale 0.2 --layer-height 0.2 --fill-density 0% \
--support-material-pattern honeycomb --raft-layers 2 \
--support-material-buildplate-only yes
