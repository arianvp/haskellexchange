#!/bin/bash

export SOURCE=$(cat slides.md)
cat slides.html.env | envsubst > slides.html
