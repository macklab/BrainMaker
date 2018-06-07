#!/bin/bash
export FREESURFER_HOME=/usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh

# Named arguments
participant_label=
gcode_scale=0.2
blender_config=/usr/local/blender_default.py
slicer_config=/usr/local/slicer_default.ini

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
    --gcode_scale )
      shift
      gcode_scale=$1
      ;;
    --blender_config )
      shift
      blender_config=/configs/$1
      ;;
    --slicer_config )
      shift
      slicer_config=/configs/$1
      ;;
    * )
      if [ -z $bids_dir ]
      then
        bids_dir=$1
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

# Apply freesurfer license
cp /configs/license.txt $FREESURFER_HOME/license.txt

mkdir -p ${output_dir}/sub-${participant_label}
surf=${bids_dir}/derivatives/freesurfer/sub-${participant_label}/surf/

mris_convert ${surf}lh.pial \
  ${output_dir}/sub-${participant_label}/sub${participant_label}_lh.pial.stl
mris_convert ${surf}rh.pial \
  ${output_dir}/sub-${participant_label}/sub${participant_label}_rh.pial.stl

/usr/local/blender/blender --background -noaudio -Y \
  --python $blender_config \
  -- ${output_dir}/sub-${participant_label} ${participant_label}

/usr/local/slic3r/slic3r \
  ${output_dir}/sub-${participant_label}/sub${participant_label}_PrintBrain.stl \
  --load $slicer_config --scale $gcode_scale
