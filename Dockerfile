FROM openjdk:16-slim-buster

# See Makefile.version
ARG VERSION

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        wget \
        unzip  \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q https://www.languagetool.org/download/LanguageTool-$VERSION.zip \
    && unzip LanguageTool-$VERSION.zip \
    && rm LanguageTool-$VERSION.zip

COPY en_spelling_additions.txt /tmp/en_spelling_additions.txt
RUN  (echo; cat /tmp/en_spelling_additions.txt) >> /LanguageTool-$VERSION/org/languagetool/resource/en/hunspell/spelling.txt \
    && rm /tmp/en_spelling_additions.txt

WORKDIR /LanguageTool-$VERSION

COPY misc/start.sh /start.sh
CMD [ "sh", "/start.sh" ]
USER nobody
EXPOSE 8010
