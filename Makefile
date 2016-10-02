default: all

%: %.j2
	j2 $^ > $@

.PHONY: code all
code:
	$(MAKE) -C code


slides: slides.md

all: code slides slides.html


clean:
	$(MAKE) -C code clean
	rm -f *.md
