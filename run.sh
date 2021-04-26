#!/bin/bash

# stop on error
set -e

# compile the original version
latexmk -xelatex -shell-escape main.tex

# compile the ready-for-word version
# - rasterized images
# - [TODO] fix text size after \cite{}
rm -rf for-word/
mkdir for-word/
cp -r chapters figures hnunumerical.bst hnuthesis.cls main.tex references.bib for-word/
python for-word.py --source=./for-word --download_path=./download
cd for-word/
latexmk -xelatex -shell-escape main.tex
mv main.pdf ../main-for-word.pdf
