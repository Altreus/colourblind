all: index.html bookmarklet.min.js bookmarklet.js

index.html: bookmarklet.min.js
	perl -i -MHTML::Entities -pe '$$text=HTML::Entities::encode_entities(`cat $<`); chomp($$text); s/href=".*"/href="$$text"/' $@

bookmarklet.min.js: bookmarklet.js
	echo -n 'javascript': > $@
	uglifyjs $< >> $@

bookmarklet.js: colourblind.svg
	sed ':a;N;$$!ba;s/\s\+/ /g;s/\s\+$$//;s/.*\(<svg\)/\1/' $< > tmp
	perl -i -pe '$$text=`cat tmp`; chomp($$text); s/<svg.*svg>/$$text/' $@
	rm tmp
