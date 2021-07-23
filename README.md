<h2 align="center">Docker LanguageTool</h2>

<!-- TABLE OF CONTENTS -->
## Table Of Contents

- [About the Project](#about-the-project)
- [Usage](#usage)

## About The Project

[LanguageTool](https://languagetool.org/) is an multilingual grammar, style, and spell checker.

## Usage

### Test

```shell
docker run --name languagetool-test -p 127.0.0.1:8081:8010 testthedocs/lt-test
```

**Focus on the browser setup!**

*Add examples about different browser plugins*

(The Server is running on port 8010, this port should exposed.)

*Check command below, not sure about the ports, default port of LT is 8081*

```shell
docker pull testthedocs/lt
docker run --rm -p 8010:8010 testthedocs/lt
```

Or you run it in background via `-d`-option.

Run with no minimum rights and RAM

*Check command below, not sure about the ports, default port of LT is 8081*

``` shell
docker run --name languagetool \
                        --cap-drop=ALL \
                        --user=65534:65534 \
                        --read-only \
                        --mount type=bind,src=/tmp/languagetool/tmp,dst=/tmp \
                        -p 127.0.0.1:8010:8010 \
                        --memory 412m --memory-swap 500m \
                        -e EXTRAOPTIONS="-Xmx382M" \
                        testthedocs/lt:latest
```

### N-gram support

To support [n-gram](https://dev.languagetool.org/finding-errors-using-n-gram-data)
you need an additional volume or directory mounted to the
`/ngrams` directory. For that add a `-v` to the `docker run`-command.

```shell
docker run ... -v /path/to/ngrams:/ngrams ...
```

Download English n-grams with the commands:

```shell
mkdir ngrams
wget https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip
(cd ngrams && unzip ../ngrams-en-20150817.zip)
rm -f ngrams-en-20150817.zip
```

One can use them using web browser plugin "Local server (localhost)" setting by running:

```shell
docker run -d --name languagetool -p 127.0.0.1:8081:8010 -v `pwd`/ngrams:/ngrams:ro --restart=unless-stopped testthedocs/lt
```

Using n-gram datasets
LanguageTool can make use of large n-gram data sets to detect errors with words that are often confused, like their and there.

Source: https://dev.languagetool.org/finding-errors-using-n-gram-data

Download the n-gram dataset(s) to your local machine and mount the local n-gram data directory to the /ngrams directory in the Docker container using the -v configuration and set the languageModel configuration to the /ngrams folder.


## Improving the spell checker

> You can improve the spell checker without touching the dictionary. For single words (no spaces), you can add your words to one of these files:
> * `spelling.txt`: words that the spell checker will ignore and use to generate corrections if someone types a similar word
> * `ignore.txt`: words that the spell checker will ignore but not use to generate corrections
> * `prohibited.txt`: words that should be considered incorrect even though the spell checker would accept them

*Source: [https://dev.languagetool.org/hunspell-support](https://dev.languagetool.org/hunspell-support)*

## Building

- docker buildx create --name multibuilder
- docker buildx use multibuilder
- make build

## Notes

https://forum.languagetool.org/t/disable-auto-language-detection/6852/8