MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables

# Monarch release version
ARCHIVE ?= https://archive.monarchinitiative.org/beta

WGET = /usr/bin/wget --timestamping --no-verbose

WGET_GV = $(WGET) --accept ".gv" --recursive --no-parent --no-host-directories --level=1 --cut-dirs=3

QC_FILES = docs/.vuepress/public/gv/ \
	docs/.vuepress/public/gv/biolink/ \
	docs/.vuepress/public/gv/ns-change/ \
	docs/.vuepress/public/gv/ns-reduced/ \
	docs/.vuepress/public/gv/ns-release/ \
	docs/.vuepress/public/md/metadata.md \
	docs/.vuepress/public/md/scigraph-categories.md \
	docs/.vuepress/public/md/dipper_diff.md \
	docs/rules/monarch-rules.md \
	docs/solr/solr-diff.md

.PHONY: all clean

all: $(QC_FILES)

clean:
	rm --force --recursive --verbose --preserve-root --one-file-system \
		docs/.vuepress/public/gv/biolink/ \
        docs/.vuepress/public/gv/ns-change/ \
        docs/.vuepress/public/gv/ns-reduced/ \
        docs/.vuepress/public/gv/ns-release/ \
		docs/.vuepress/public/gv/ \
		docs/.vuepress/public/md/metadata.md \
		docs/.vuepress/public/md/scigraph-categories.md \
		docs/.vuepress/public/md/dipper_diff.md \
		docs/rules/monarch-rules.md \
		docs/solr/solr-diff.md

docs/.vuepress/public/gv/:
	mkdir -p $@

docs/.vuepress/public/gv/biolink/: docs/.vuepress/public/gv/
	mkdir -p $@
	cd $@ && $(WGET) https://github.com/biolink/biolink-model/archive/master.zip
	cd $@ && unzip -j master.zip "biolink-model-master/graphviz/*gv"

docs/.vuepress/public/gv/ns-change/: docs/.vuepress/public/gv/
	mkdir -p $@
	cd $@ && $(WGET_GV) $(ARCHIVE)/visual_reduction/changes/

docs/.vuepress/public/gv/ns-reduced/: docs/.vuepress/public/gv/
	mkdir -p $@
	cd $@ && $(WGET_GV) $(ARCHIVE)/visual_reduction/reduced/

docs/.vuepress/public/gv/ns-release/: docs/.vuepress/public/gv/
	mkdir -p $@
	cd $@ && $(WGET_GV) $(ARCHIVE)/visual_reduction/release/

docs/.vuepress/public/md/metadata.md:
	cd docs/.vuepress/public/md/ && $(WGET) $(ARCHIVE)/qc/metadata.md

docs/.vuepress/public/md/scigraph-categories.md:
	cd docs/.vuepress/public/md/ && $(WGET) $(ARCHIVE)/qc/scigraph-categories.md

docs/.vuepress/public/md/dipper_diff.md:
	cd docs/.vuepress/public/md/ && $(WGET) $(ARCHIVE)/visual_reduction/dipper_diff.md

docs/rules/monarch-rules.md:
	cd docs/rules/ && $(WGET) $(ARCHIVE)/qc/monarch-rules.md

docs/solr/solr-diff.md:
	cd docs/solr/ && $(WGET) $(ARCHIVE)/qc/solr-diff.md
