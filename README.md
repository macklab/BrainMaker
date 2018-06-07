# BrainMaker
Converts mri image to printable model

Current code to run:
```
docker run --rm \
  -v ~/Desktop/brainMakerTest/bids:/data:ro \
  -v ~/Desktop/brainMakerTest/bids/derivatives/BrainMaker/:/outputs \
  -v ~/Desktop/brainMakerTest/bids/code:/configs:ro \
  brainmaker:latest /data /outputs \
  participant \
  --participant_label 001 \
  --fs_license /configs/license.txt \
  --gcode_scale 0.1 \
```
