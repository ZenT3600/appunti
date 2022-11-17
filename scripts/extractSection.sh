#!/usr/bin/bash

FILE="$1"
OUT="extracted"
BEGINFULL=$(cat "$FILE" | grep -nF '\begin{document}')
BEGINLINE=$(echo "$BEGINFULL" | cut -d':' -f 1)
SECTIONFULL=$(cat "$FILE" | grep -nF '\section{' | fzf -m)
SECTIONLINE=$(echo "$SECTIONFULL" | cut -d':' -f 1)
SECSECTIONFULL=$(tail -n +$(expr $SECTIONLINE + 1) "$FILE" | grep -nF '\section{')
SECSECTIONLINE=$(echo "$SECSECTIONFULL" | cut -d':' -f 1 | head -n 1)

echo "Yanking from start to line $BEGINLINE"
head -n $BEGINLINE "$FILE" > "$OUT/ext.tex"
echo "Yanking from line $SECTIONLINE to next section"
tail -n +$SECTIONLINE "$FILE" | head -n $SECSECTIONLINE >> "$OUT/ext.tex"
echo "Closing file"
echo '\end{document}' >> "$OUT/ext.tex"

echo "Compiling..."
cd "$OUT"
xelatex -shell-escape ext.tex
cd ..
