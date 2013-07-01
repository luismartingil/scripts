all:
	pdflatex -shell-escape main.tex
	pdflatex -shell-escape main.tex # doing twice for the toc file...
#	enscript --line-numbers -f "Courier7.2" -Gr -E --color -p source_code.ps ../src/*.py
#	ps2pdf source_code.ps; rm -f source_code.ps
#	pdftk main.pdf source_code.pdf cat output main_tmp.pdf
#	mv main_tmp.pdf main.pdf
#	rm -f source_code.pdf
clean:
	find . -type f -name "*.vrb" -exec rm -f '{}' \;
	find . -type f -name "*.out" -exec rm -f '{}' \;
	find . -type f -name "*.snm" -exec rm -f '{}' \;
	find . -type f -name "*.mtc*" -exec rm -f '{}' \;
	find . -type f -name "*.toc" -exec rm -f '{}' \;
	find . -type f -name "*.aux" -exec rm -f '{}' \;
	find . -type f -name "*.log" -exec rm -f '{}' \;
	find . -type f -name "*.maf" -exec rm -f '{}' \;
	find . -type f -name "*.nav" -exec rm -f '{}' \;
	find . -type f -name "*.pyg" -exec rm -f '{}' \;
	find . -type f -name "*~" -exec rm -f '{}' \;
