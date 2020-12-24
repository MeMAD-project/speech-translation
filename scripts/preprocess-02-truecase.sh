#!/bin/bash

# USAGE: ./preprocess.sh TRUECASER_MODEL < INPUT > OUTPUT

TC_MODEL=$1

MOSES_DIR=/scratch/project_2000945/iwslt20/scripts/preprocessing/moses/scripts

${MOSES_DIR}/recaser/truecase.perl --model $TC_MODEL
