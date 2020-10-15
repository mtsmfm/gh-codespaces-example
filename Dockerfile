FROM ruby:2.7.2

LABEL org.opencontainers.image.source https://github.com/mtsmfm/gh-codespaces-example

ARG USERNAME=app
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV SHELL=/bin/bash

RUN groupadd --gid $USER_GID $USERNAME \
  && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
  && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get update \
  && apt-get install -y sudo postgresql-client nodejs \
  && echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
  && chmod 0440 /etc/sudoers.d/$USERNAME

ENV BUNDLE_PATH=/app/vendor/bundle
RUN mkdir -p /app /original /persisted $BUNDLE_PATH
RUN chown -R $USERNAME /app /original /persisted $BUNDLE_PATH

USER $USERNAME

WORKDIR /app
