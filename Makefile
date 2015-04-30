all: index.html bookmarklet.min.js bookmarklet.js

index.html: bookmarklet.min.js
	sed 's/javascript:(function(){/function colourblind(){/;s/})();/}/' $< > tmp
	perl -i -pe '$$text=`cat tmp`; chomp($$text); s/function colourblind.*/$$text/' $@
	rm tmp

bookmarklet.min.js: bookmarklet.js
	echo -n 'javascript': > $@
	uglifyjs $< >> $@

bookmarklet.js: colourblind.svg
	sed ':a;N;$$!ba;s/\s\+/ /g;s/\s\+$$//;s/.*\(<svg\)/\1/' $< > tmp
	perl -i -pe '$$text=`cat tmp`; chomp($$text); s/<svg.*svg>/$$text/' $@
	rm tmp
