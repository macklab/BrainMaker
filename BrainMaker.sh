#!/bin/bash
export FREESURFER_HOME=/usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh

# Positional arguments
bids_dir=
output_dir=
level=

# Named arguments
participant_label=
gcode_scale=0.2
blender_config=/usr/local/blender_default.py
slicer_config=/usr/local/slicer_default.ini
skip_slice=false
freesurfer_output_loc=${bids_dir}/derivatives/freesurfer/

# Assign arguments
while [ "$1" != "" ]; do
  case $1 in
    --participant_label )
      shift
      participant_label=$1
      ;;
    --freesurfer_output_loc )
      shift
      freesurfer_output_loc=$bids_dir/$1
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
    --skip_slice )
      skip_slice=true
      ;;
    -h|--help )
      echo "usage: BrainMaker.sh [-h] bids_dir output_dir participant"
      echo "                     --participant_label PARTICIPANT_LABEL"
      echo "                     [--freesurfer_output_loc FREESURFER_OUTPUT_DIR]"
      echo "                     [--blender_config BLENDER_CONFIG] [--slicer_config SLICER_CONFIG]"
      echo "                     [--gcode_scale SCALE] [--skip_slice]"
      exit
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

# Check if participant_label argument was assigned.
if [ -z $participant_label ]; then
  echo "Error: Missing --participant_label name-value argument"
  exit 1
fi

# Apply freesurfer license if available, otherwise error out
if [ -f /configs/license.txt ]; then
  cp /configs/license.txt $FREESURFER_HOME/license.txt
else
  echo "Error: Missing freesurfer license file! Place it in the volume mounted to /configs"
  exit 1
fi

mkdir -p ${output_dir}/sub-${participant_label}
surf=$freesurfer_output_loc/sub-${participant_label}/surf/

echo "Converting lh.pial and rh.pial to .stl."
mris_convert ${surf}lh.pial \
  ${output_dir}/sub-${participant_label}/sub${participant_label}_lh.pial.stl
mris_convert ${surf}rh.pial \
  ${output_dir}/sub-${participant_label}/sub${participant_label}_rh.pial.stl

echo 'Importing STLs into Blender for translation and export.'
/usr/local/blender/blender --background -noaudio -Y \
  --python $blender_config \
  -- ${output_dir}/sub-${participant_label} ${participant_label}

if $skip_slice; then
  echo "Skipping Slic3r."
else
  echo "Generating G-Code with Slic3r."
  /usr/local/slic3r/slic3r \
    ${output_dir}/sub-${participant_label}/sub${participant_label}_PrintBrain.stl \
    --load $slicer_config --scale $gcode_scale
fi
