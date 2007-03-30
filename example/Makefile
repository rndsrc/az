file=thesis

all:	
	latex ${file}
	bibtex ${file}
	latex ${file}
	latex ${file}

pdf:
	dvipdf ${file}

clean:
	rm -f ${file}.pdf ${file}.ps
	rm -f ${file}.dvi ${file}.log ${file}.bbl ${file}.blg
	rm -f ${file}.aux ${file}.toc ${file}.lof ${file}.lot
	rm -f */*.aux
	rm -f *~ */*~
