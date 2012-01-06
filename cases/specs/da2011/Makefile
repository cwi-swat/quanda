
# Assumes ruby and http://www.unixuser.org/~euske/python/pdfminer/
# to be installed and http://pdfbox.apache.org/ in the current dir.

PAGES = "5,6,7,8,9,10,11,12,13,14,15"

PARSE_TOC = parsetoc.rb
PARSE_TOC_CMD = ruby ${PARSE_TOC}
RMBREAKS = ./rmhtmlbr.sh

PARSE_CSV = parsecsv.rb
PARSE_CSV_CMD = ruby ${PARSE_CSV}

PDFBOX = pdfbox-app-1.6.0.jar
ENCODING = windows-1252
EXTRACT_TEXT = java -jar ${PDFBOX} ExtractText -encoding ${ENCODING}

all: da20110929.xml da20110929-toc.xml

%-toc-pdf.xml: %.pdf
	pdf2txt.py -t xml -p${PAGES} $< > $@

%-toc.xml: %-toc-pdf.xml ${PARSE_TOC}
	${PARSE_TOC_CMD} $< > $@

%-nobr.csv: %.csv
	cat $< | ${RMBREAKS} > $@

%.xml: %.txt %-nobr.csv ${PARSE_CSV}
	${PARSE_CSV_CMD} $*.txt $*-nobr.csv $@

%.txt: %.pdf
	${EXTRACT_TEXT} $<

clean:
	rm -f *.{xml,dot,txt}
	rm -f *-nobr.csv

.PRECIOUS: %.txt