####
#### Makefile for Quarto documents
####

QMD   := $(wildcard *.qmd)
MD    := $(QMD:.qmd=.md)
IPYNB := $(QMD:.qmd=.ipynb)
TARGET := $(MD) $(IPYNB)

%.md: %.qmd _metadata.yml
	quarto render "$<" --to gfm --execute --no-cache --output "$@"

%.ipynb: %.qmd _metadata.yml
	quarto render "$<" --to ipynb --no-execute --output "$@"

.PHONY: all
all: $(TARGET)

.PHONY: clean
clean:
	rm -rf $(MD) $(IPYNB) *_files/
