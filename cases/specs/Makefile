
# Set path to pdfbox-app
PDFBOX = pdfbox-app-1.6.0.jar

%.txt: %.pdf
	java -jar ${PDFBOX} ExtractText -encoding UTF-8 $^

%.html: %.txt
	ruby parse.rb $^ > $@
