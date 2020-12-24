#!/bin/bash
#SBATCH --job-name=translate
#SBATCH --account=project_2003288
#SBATCH --time=00:15:00
#SBATCH --mem=4G
#SBATCH --gres=gpu:v100:1
#SBATCH --partition=gputest
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

module purge

source /projappl/project_2000945/.bashrc
conda activate attbrg
export PYTHONUSERBASE=/projappl/project_2000945
export PATH=/projappl/project_2000945/bin:$PATH

# branch att-brg at commit b7a2c411e2afda7fb8e8ae9586cb6cf0c8e79399
cd /projappl/project_2000945/OpenNMT_att-brg

directory=/scratch/project_2000945/iwslt20/models/ONMT/saved_models/end-to-end_pkg

#
# Audio to text translation example:
#

python translate_multimodel.py -data_type audio \
                             -src_lang  en_a \
                             -tgt_lang  de_t \
                             -model ${directory}/models/translate_a-t.pt \
                             -src_dir ${directory}/examples/audio \
                             -src ${directory}/examples/audio/en-de_audio_list.txt \
                             -output ${directory}/examples/a-t_output.norm.true.xbpe32k \
                             -use_attention_bridge \
                             -gpu 0 \
                             -n_stacked_mels 3 \
                             -n_mels 80 \
                             -verbose

${directory}/scripts/postprocess.sh de < ${directory}/examples/a-t_output.norm.true.xbpe32k > ${directory}/examples/a-t_output.txt

#
# Text to text translation example:
#

tc_model=${directory}/models/truecaser-en.model
seg_model=${directory}/models/sentencepiece-en-bpe-32K.model

${directory}/scripts/preprocess-01-normalize.sh en < ${directory}/examples/text/en-de_example.txt > ${directory}/examples/input.norm
${directory}/scripts/preprocess-02-truecase.sh $tc_model < ${directory}/examples/input.norm > ${directory}/examples/input.norm.true
${directory}/scripts/preprocess-03-segment.sh $seg_model ${directory}/examples/input.norm.true ${directory}/examples/input.norm.true.xbpe32k

python translate_multimodel.py -data_type text \
                             -src_lang  en_t \
                             -tgt_lang  de_t \
                             -model ${directory}/models/translate_at-t.pt \
                             -src ${directory}/examples/input.norm.true.xbpe32k \
                             -output ${directory}/examples/t-t_output.norm.true.xbpe32k \
                             -use_attention_bridge \
                             -gpu 0 \
                             -verbose

/scratch/project_2000945/iwslt20/scripts/postprocessing/postprocess.sh de < ${directory}/examples/t-t_output.norm.true.xbpe32k > ${directory}/examples/t-t_output.txt

