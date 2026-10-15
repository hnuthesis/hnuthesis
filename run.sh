#!/usr/bin/env bash

set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

latexmk -xelatex -halt-on-error main.tex
