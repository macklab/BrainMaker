#!/bin/bash
export FREESURFER_HOME=/usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh

# mris_convert $1 lh.pial.stl
# mris_convert $2 rh.pial.stl

# /usr/local/blender/blender --background -noaudio -Y --python usr/local/BrainMaker.py

/usr/local/slic3r/slic3r /files/PrintBrain.stl \
  --load /usr/local/BrainMaker.ini --scale 0.2 --layer-height 0.2 --fill-density 0% \
  --support-material-pattern honeycomb --raft-layers 2 \
  --support-material-buildplate-only yes
