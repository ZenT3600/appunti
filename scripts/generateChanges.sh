#!/bin/bash

SCOMM=$(git log --oneline | fzf | awk '{print $1}')
DIFF=$(git diff $SCOMM^1:Notes.tex..HEAD:Notes.tex | grep '^+' | cut -c2-)

#echo "Sections:"
#echo "$DIFF" | grep -F '\section{' | cut -d "{" -f2 | cut -d "}" -f1
#echo "SubSections:"
#echo "$DIFF" | grep -F '\subsection{' | cut -d "{" -f2 | cut -d "}" -f1
echo "@everyone Gli appunti sono stati aggiornati!"
echo "Le seguenti sezioni sono state modificate/aggiunte:"
echo ""
echo "$DIFF" | grep -F '\subsubsection{' | while read line; do
	echo $line | cut -d "{" -f2 | cut -d "}" -f1 | tr -d '\n'
	echo " ($(echo $line | awk -F' % ' '{print $2}'))"
done
echo ""
echo "Il link al PDF e' https://raw.githubusercontent.com/ZenT3600/appunti/main/Notes.pdf"
echo ""
echo "||Questo messaggio e' stato generato automaticamente||"
