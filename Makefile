SRC := $(shell find code -maxdepth 1 -type f -name '*.elm')
DST := $(patsubst %.elm, %.elm.html, $(SRC))

default: all

.PHONY: all default

%.elm.html: %.elm
	elm-make $^ --output=$@

slides.md: slides.md.j2 $(DST)
	j2 slides.md.j2 > slides.md


slides:  slides.md

all: slides slides.html

clean:
	rm -f code/*.elm.html
	rm -f *.md
