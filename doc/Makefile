

STEM= quanda
SRC = ${STEM}.text

build:
	pandoc --css="http://homepages.cwi.nl/~storm/teaching/bb.css" -t html ${SRC} > ${STEM}.html
	markdown2pdf -o ${STEM}.pdf ${SRC}

#upload:
#	scp ${STEM}.html storm@ssh.cwi.nl:/ufs/storm/public_html/teaching/${STEM}.html
#	scp ${STEM}.pdf storm@ssh.cwi.nl:/ufs/storm/public_html/teaching/${STEM}.pdf
