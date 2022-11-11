clean: Notes.log _minted-Notes
	@echo "[+] Cleaning"
	rm -rf $?
	@echo "[+] Done"

build: Notes.tex
	@echo "[+] Building"
	xelatex -shell-escape $? > /dev/null
	xelatex -shell-escape $? > /dev/null
	@echo "[+] Done"

publish: Notes.pdf
	@echo "[+] Publishing"
	git add .
	git commit -m "Automatic Commit n.$(shell date)"
	git push -u origin main
	@echo "[+] Done"
