# MeMAD end-to-end speech translation system

## Dependencies

* `python >= 3.0`
* Data processing scripts from [`moses`](https://github.com/moses-smt/mosesdecoder)
- [Attention bridge (OpenNMT-py fork)](https://github.com/Helsinki-NLP/OpenNMT-py/tree/att-brg)

## Models

The translation, segmentation and truecasing models required by the system are available for download via [Zenodo](https://zenodo.org/record/4392873). You must download the models separately, and extract the archive into the `models` folder.

## Instructions

translation models:
(`en`=English, `de`=German, `a`=audio, `t`=text)

```
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
```

`translate_a-t.pt` can only translate audio to text. `translate_at-t.pt` can translate both audio and text to text.
`translation_example.sh` script shows examples of translating audio to text and text to text using example data.

When translating text to text, the input text has to be preprocessed with normalization, truecasing and
segmentation scripts:

```
    scripts/preprocess-01-normalize.sh LANG_ID < INPUT > OUTPUT
    scripts/preprocess-02-truecase.sh TRUECASER_MODEL < INPUT > OUTPUT
    scripts/preprocess-03-segment.sh SEGMENTATION_MODEL INPUT OUTPUT
```

The preprocessing scripts use the following parameters:

```
    LANG_ID: en or de
    TRUECASER_MODEL: models/truecaser-{en,de}.model
    SEGMENTATION_MODEL: models/sentencepiece-{en,de}-bpe-32K.model
```

The translation output has to be postprocessed to produce plain text result:

```
    scripts/postprocess.sh LANG_ID < INPUT > OUTPUT
```

Where:

```
    LANG_ID: en or de
```

## Publications

* The University of Helsinki Submission to the IWSLT2020 Offline Speech Translation Task

```
@inproceedings{vazquez-etal-2020-university,
    title = "The {U}niversity of {H}elsinki Submission to the {IWSLT}2020 Offline {S}peech{T}ranslation Task",
    author = {V{\'a}zquez, Ra{\'u}l  and
      Aulamo, Mikko  and
      Sulubacak, Umut  and
      Tiedemann, J{\"o}rg},
    booktitle = "Proceedings of the 17th International Conference on Spoken Language Translation",
    month = jul,
    year = "2020",
    address = "Online",
    publisher = "Association for Computational Linguistics",
    url = "https://www.aclweb.org/anthology/2020.iwslt-1.10",
    doi = "10.18653/v1/2020.iwslt-1.10",
    pages = "95--102",
}
```
