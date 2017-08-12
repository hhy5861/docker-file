#!/bin/bash

# Quick & dirty batch build wrapper for producing minimal Debian base images
#
# This is intended to be used on an existing Debian system, requiring: 
#   apt-get install docker.io debootstrap

# Set TAGPREFIX based on your desired naming; e.g.,
# for jdoe/debian:<suite> use
#   TAGPREFIX=jdoe/debian: 
# and for jdoe/somerepo:debian-<suite> use
#   TAGPREFIX=jdoe/somerepo:debian-
TAGPREFIX=debian:

# Set SUITES to the space-delimited list of suites you wish to build
SUITES="oldstable stable testing wheezy jessie stretch sid"

# Set PUSH to 0 (the default) to build without pushing, or
# set PUSH to 1 to push each image after it's built, or
# set PUSH to 2 to push the repo ($TAGPREFIX up to the first colon) after
PUSH=0

# Enjoy!
#
# -Ed

for suite in ${SUITES}; do 
  /usr/share/docker.io/contrib/mkimage.sh -t ${TAGPREFIX}${suite} debootstrap --variant=minbase ${suite} http://httpredir.debian.org/debian
  if [ ${PUSH} -eq 1 ]; then
    /usr/bin/docker push ${TAGPREFIX}${suite}
  fi
done

if [ ${PUSH} -eq 2 ]; then
  /usr/bin/docker push $(echo ${TAGPREFIX}${suite} |cut -f1 -d:)
fi

