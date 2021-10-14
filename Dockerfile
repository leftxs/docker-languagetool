#FROM openjdk:16-slim-buster
FROM openjdk:18-slim-bullseye

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

COPY spelling.txt /tmp/spelling.txt
RUN  (echo; cat /tmp/spelling.txt) >> /LanguageTool-$VERSION/org/languagetool/resource/en/hunspell/spelling.txt \
    && rm /tmp/spelling.txt

WORKDIR /LanguageTool-$VERSION

COPY misc/start.sh /start.sh
CMD [ "sh", "/start.sh" ]
#ENTRYPOINT [ "bash"]
USER nobody
EXPOSE 8010
