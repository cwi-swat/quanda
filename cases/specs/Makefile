
# Set path to pdfbox-app
PDFBOX = pdfbox-app-1.6.0.jar

%.txt: %.pdf
	java -jar ${PDFBOX} ExtractText -encoding UTF-8 $^

%.dsl: %.txt
	ruby parse.rb to_dsl $^ | iconv -c -f UTF-8 -t US-ASCII > $@

%.html: %.txt
	ruby parse.rb to_html $^ > $@
