# BrainMaker
Converts mri image to printable model

Current code to run:
```Shell
docker run --rm -it \
  -v ~/Desktop/brainMakerTest/bids:/data:ro \
  -v ~/Desktop/brainMakerTest/bids/derivatives/BrainMaker/:/outputs \
  -v ~/Desktop/brainMakerTest/bids/code:/configs:ro \
  brainmaker:latest /data /outputs participant \
  --participant_label 001 \
  --blender_config blender.py \
  --slicer_config slicer.ini \
  --gcode_scale 0.1 \
```
