####
#### Makefile for Quarto documents
####

QMD   := $(wildcard *.qmd)
MD    := $(QMD:.qmd=.md)
IPYNB := $(QMD:.qmd=.ipynb)

.PHONY: all md nb clean
all: md nb
md: $(MD)
nb: $(IPYNB)

%.md: %.qmd _quarto.yml
	quarto render "$<" --to gfm --output "$@"

%.ipynb: %.qmd _quarto.yml
	quarto render "$<" --to ipynb --no-execute --output "$@"

clean:
	rm -f $(MD) $(IPYNB)
