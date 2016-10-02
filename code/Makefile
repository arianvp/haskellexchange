SRC := $(shell find -maxdepth 1 -type f -name '*.elm')
all: $(patsubst %.elm, %.elm.html, $(SRC))

%.elm.html: %.elm
	elm-make $^ --output=$@

clean:
	rm -f *.html
