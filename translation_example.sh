#!/bin/bash

#
# Audio to text translation example:
#

python translate_multimodel.py -data_type audio \
                             -src_lang  en_a \
                             -tgt_lang  de_t \
                             -model models/translate_a-t.pt \
                             -src_dir examples/audio \
                             -src examples/audio/en-de_audio_list.txt \
                             -output examples/a-t_output.norm.true.xbpe32k \
                             -use_attention_bridge \
                             -gpu 0 \
                             -n_stacked_mels 3 \
                             -n_mels 80 \
                             -verbose

scripts/postprocess.sh de < examples/a-t_output.norm.true.xbpe32k > examples/a-t_output.txt

#
# Text to text translation example:
#

tc_model=models/truecaser-en.model
seg_model=models/sentencepiece-en-bpe-32K.model

scripts/preprocess-01-normalize.sh en < examples/text/en-de_example.txt > examples/input.norm
scripts/preprocess-02-truecase.sh $tc_model < examples/input.norm > examples/input.norm.true
scripts/preprocess-03-segment.sh $seg_model examples/input.norm.true examples/input.norm.true.xbpe32k

python translate_multimodel.py -data_type text \
                             -src_lang  en_t \
                             -tgt_lang  de_t \
                             -model models/translate_at-t.pt \
                             -src examples/input.norm.true.xbpe32k \
                             -output examples/t-t_output.norm.true.xbpe32k \
                             -use_attention_bridge \
                             -gpu 0 \
                             -verbose

/scratch/project_2000945/iwslt20/scripts/postprocessing/postprocess.sh de < examples/t-t_output.norm.true.xbpe32k > examples/t-t_output.txt

