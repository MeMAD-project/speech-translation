#!/bin/bash

# USAGE: ./preprocess.sh LANG_ID < INPUT > OUTPUT

LANG=$1

MOSES_DIR=/scratch/project_2000945/iwslt20/scripts/preprocessing/moses/scripts

${MOSES_DIR}/tokenizer/detokenizer.perl -l $LANG |
${MOSES_DIR}/tokenizer/replace-unicode-punctuation.perl |
${MOSES_DIR}/tokenizer/remove-non-printing-char.perl |
${MOSES_DIR}/tokenizer/normalize-punctuation.perl -l $LANG |
${MOSES_DIR}/tokenizer/tokenizer.perl -a -threads 4 -l $LANG |
sed -r "s/\([^„“\"\'\)]+\)//g" |
sed 's/  */ /g;s/^ *//g;s/ *$//g'
