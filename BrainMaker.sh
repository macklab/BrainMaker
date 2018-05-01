#!/bin/bash
export FREESURFER_HOME=/usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh

#mris_convert $1 lh.pial.stl
#mris_convert $2 rh.pial.stl
ls 

/usr/local/blender/blender --background --python BrainMaker.py

/usr/local/slic3r/bin/slic3r
# /usr/local/slic3r/bin/slic3r PrintBrain.stl \
# --load BrainMaker.ini --scale 0.2 --layer-height 0.2 --fill-density 0% \
# --support-material-pattern honeycomb --raft-layers 2 \
# --support-material-buildplate-only yes
