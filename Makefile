# TODO
JSON_DIR=~/netrunner/cards/netrunner-cards-json

LANGS=ja

all: ${LANGS:%=nrdb-language-override.%.user.js}

define output_json
	jq -s add ${1} | jq 'del(..|nulls)' | jq 'INDEX(.code)' | jq -r tostring >> $@
endef

nrdb-language-override.%.user.js: nrdb-language-override.js.head.in nrdb-language-override.js.tail.in formats.json stats.json display.json ui.json langs.json
	@cat nrdb-language-override.js.head.in > $@
	@echo "var locale = '$*'" >> $@
	@echo -n "var locale_text = " >> $@
	@jq .$* langs.json >> $@
	@echo -n "var cards = " >> $@
	@$(call output_json, ${JSON_DIR}/translations/$*/pack/*.$*.json) >> $@
	@echo -n "var types = " >> $@
	@$(call output_json, ${JSON_DIR}/translations/$*/types.$*.json) >> $@
	@echo -n "var cycles = " >> $@
	@$(call output_json, ${JSON_DIR}/translations/$*/cycles.$*.json) >> $@
	@echo -n "var packs = " >> $@
	@$(call output_json, ${JSON_DIR}/translations/$*/packs.$*.json) >> $@
	@echo -n "var factions = " >> $@
	@$(call output_json, ${JSON_DIR}/translations/$*/factions.$*.json) >> $@
	@echo -n "var sides = " >> $@
	@$(call output_json, ${JSON_DIR}/translations/$*/sides.$*.json) >> $@
	@echo -n "var formats = " >> $@
	@jq ".$*" formats.json | jq -r tostring >> $@
	@echo -n "var stats = " >> $@
	@jq ".$*" stats.json | jq -r tostring >> $@
	@echo -n "var display = " >> $@
	@jq ".$*" display.json | jq -r tostring >> $@
	@echo -n "var ui = " >> $@
	@jq ".$*" ui.json | jq -r tostring >> $@
	@echo >> $@
	@cat nrdb-language-override.js.tail.in >> $@
	@echo "GEN	$@"
