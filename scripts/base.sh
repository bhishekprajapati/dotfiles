#! /usr/bin/env bash
echo "######################################################################################"
echo "Installing base packages..."

sudo pacman -S --needed \
  base-devel \
  curl \
  wget \
  ca-certificates \
  openssl \
  sudo \
  which \
  unzip \
  zip \
  tar \
  gzip \
  zstd \
  file


echo "Base packages are installed"
echo "######################################################################################"
