

%.csv-nothmlbreak: %.csv
	cat $< | scripts/rmhtmlbr.sh > $@

%.xml: %.csv-nothmlbreak tax-spec.rb
	ruby tax-spec.rb to_xml $< $@

%.dot: %.csv-nothmlbreak tax-spec.rb
	ruby tax-spec.rb to_dot $< $@

