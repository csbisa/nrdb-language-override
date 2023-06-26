# TODO
JSON_DIR=~/netrunner/cards/netrunner-cards-json
LANG=ja
LANG_TEXT="日本語"

define output_json
	jq -s add ${1} | jq 'del(..|nulls)' | jq 'INDEX(.code)' | jq -r tostring >> $@
endef

nrdb-language-override.${LANG}.user.js: nrdb-language-override.js.head.in nrdb-language-override.js.tail.in formats.json stats.json
	cat nrdb-language-override.js.head.in > $@
	echo "var locale = '${LANG}'" >> $@
	echo "var locale_text = '${LANG_TEXT}'" >> $@
	echo -n "var cards = " >> $@
	$(call output_json, ${JSON_DIR}/translations/${LANG}/pack/*.${LANG}.json) >> $@
	echo -n "var types = " >> $@
	$(call output_json, ${JSON_DIR}/translations/${LANG}/types.${LANG}.json) >> $@
	echo -n "var cycles = " >> $@
	$(call output_json, ${JSON_DIR}/translations/${LANG}/cycles.${LANG}.json) >> $@
	echo -n "var packs = " >> $@
	$(call output_json, ${JSON_DIR}/translations/${LANG}/packs.${LANG}.json) >> $@
	echo -n "var factions = " >> $@
	$(call output_json, ${JSON_DIR}/translations/${LANG}/factions.${LANG}.json) >> $@
	echo -n "var sides = " >> $@
	$(call output_json, ${JSON_DIR}/translations/${LANG}/sides.${LANG}.json) >> $@
	echo -n "var formats = " >> $@
	jq ".${LANG}" formats.json | jq -r tostring >> $@
	echo -n "var stats = " >> $@
	jq ".${LANG}" stats.json | jq -r tostring >> $@
	echo >> $@
	cat nrdb-language-override.js.tail.in >> $@

all: nrdb-language-override.${LANG}.user.js
