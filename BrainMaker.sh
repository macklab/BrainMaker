#!/bin/bash
export FREESURFER_HOME=/usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh

# Named arguments
participant_label=

# Positional arguments
bids_dir=
output_dir=
level=

# Assign arguments
while [ "$1" != "" ]; do
  case $1 in
    --participant_label )
      shift
      participant_label=$1
      ;;
    * )
      if [ -z $bids_dir ]
      then
        input_dir=$1
      elif [ -z $output_dir ]
      then
        output_dir=$1
      elif [ -z $level ]
      then
        level=$1
      else
        exit
      fi
  esac
  shift
done

mkdir -p ${output_dir}/sub-${participant_label}
surf=${bids_dir}/derivatives/freesurfer/sub-${participant_label}/surf/

mris_convert ${surf}/lh.pial ${output_dir}/sub-${participant_label}/lh.pial.stl
mris_convert ${surf}/rh.pial ${output_dir}/sub-${participant_label}/rh.pial.stl

/usr/local/blender/blender --background -noaudio -Y --python usr/local/BrainMaker.py

/usr/local/slic3r/slic3r ${output_dir}/sub-${participant_label}/PrintBrain.stl \
  --load /usr/local/BrainMaker.ini --scale 0.2 --layer-height 0.2 --fill-density 0% \
  --support-material-pattern honeycomb --raft-layers 2 \
  --support-material-buildplate-only yes
