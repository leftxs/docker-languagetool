<h2 align="center">Docker LanguageTool</h2>

<!-- TABLE OF CONTENTS -->
## Table Of Contents

- [About the Project](#about-the-project)
- [Usage](#usage)

## About The Project

[LanguageTool](https://languagetool.org/) is an multilingual grammar, style, and spell checker.



## Building

- docker buildx create --name multibuilder
- docker buildx use multibuilder
- make build

## Usage

The Server is running on port 8010, this port should exposed.

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

### ngram support

To support [ngrams](http://wiki.languagetool.org/finding-errors-using-n-gram-data) you need an additional volume or directory mounted to the
`/ngrams` directory. For that add a `-v` to the `docker run`-command.

```shell
docker run ... -v /path/to/ngrams:/ngrams ...
```

Download English ngrams with the commands:

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