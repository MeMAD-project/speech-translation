# MeMAD end-to-end speech translation system

## Models

The translation, segmentation and truecasing models required by the system are available for download via **Zenodo**. You must download the models separately, and extract the archive into the `models` folder.

## Instructions

translation models:
(en=English, de=German, a=audio, t=text)

    models/translate_a-t.pt
        BLEU: 14.38
        src_tgt pairs:
            en_a-de_t
            en_a-en_t

    models/translate_at-t.pt
        BLEU: 11.71 
        src_tgt pairs:
            en_a-de_t
            en_t-de_t
            en_a-en_t
            de_t-en_t

translate_a-t.pt can only translate audio to text. translate_at-t.pt can translate both audio and text to text.
translation_example.sh script shows examples of translating audio to text and text to text using example data.

When translating text to text, the input text has to be preprocessed with normalization, truecasing and
segmentation scripts:

    scripts/preprocess-01-normalize.sh LANG_ID < INPUT > OUTPUT
    scripts/preprocess-02-truecase.sh TRUECASER_MODEL < INPUT > OUTPUT
    scripts/preprocess-03-segment.sh SEGMENTATION_MODEL INPUT OUTPUT

The preprocessing scripts use the following parameters:

    LANG_ID: en or de
    TRUECASER_MODEL: models/truecaser-{en,de}.model
    SEGMENTATION_MODEL: models/sentencepiece-{en,de}-bpe-32K.model

The translation output has to be postprocessed to produce plain text result:

    scripts/postprocess.sh LANG_ID < INPUT > OUTPUT

Where:
    
    LANG_ID: en or de

