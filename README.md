# BrainMaker
Converts mri image to printable model

Current code to run:
```
docker run --rm \
  -v $bidsdir:/data:ro \
  -v $bidsdir/derivatives/BrainMaker/:/outputs \
  brainmaker /data /outputs participant \
  --participant_label $sbj
```
