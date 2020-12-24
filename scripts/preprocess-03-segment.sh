#!/bin/bash

# USAGE: ./preprocess.sh SEGMENTATION_MODEL INPUT OUTPUT

SP_MODEL=$1
INPUT=$2
OUTPUT=$3

SP_DIR=/scratch/project_2000945/iwslt20/scripts/preprocessing/sentencepiece

${SP_DIR}/sentencepiece-apply.py --input $INPUT --output $OUTPUT --model $SP_MODEL
