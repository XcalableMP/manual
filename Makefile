# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SPHINXPROJ    = handbook
SOURCEDIR     = .
BUILDDIR      = _build

all: html-ja html-en
html-ja:
	$(SPHINXBUILD) -a -b html -d _build/doctrees ./ja /home/xmp/public_html/ja/handbook
html-en:
	$(SPHINXBUILD) -a -b html -d _build/doctrees ./en /home/xmp/public_html/handbook

local: local-ja local-en
local-ja:
	sphinx-build -a -b html -d _build/doctrees ./ja ./local-build/ja
local-en:
	sphinx-build -a -b html -d _build/doctrees ./en ./local-build/en

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
#%: Makefile
#	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
