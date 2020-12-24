#!/bin/bash

# USAGE: ./postprocess.sh LANG < INPUT > OUTPUT

LANG=$1

SCRIPTS_DIR=/scratch/project_2000945/iwslt20/scripts/preprocessing

MOSES_DIR=${SCRIPTS_DIR}/moses/scripts
SP_DIR=${SCRIPTS_DIR}/sentencepiece

sed 's/  */ /g;s/^ *//g;s/ *$//g' |
${SP_DIR}/sentencepiece-deseg.sh |
${MOSES_DIR}/recaser/detruecase.perl |
${MOSES_DIR}/tokenizer/detokenizer.perl -l $LANG
