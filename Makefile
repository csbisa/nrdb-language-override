# TODO
JSON_DIR=~/netrunner/cards/netrunner-cards-json
LANG=ja

define output_json
	jq -s add ${1} | jq 'del(..|nulls)' | jq 'INDEX(.code)' | jq -r tostring >> $@
endef

nrdb-language-override.${LANG}.user.js: nrdb-language-override.js.head.in nrdb-language-override.js.tail.in
	cat nrdb-language-override.js.head.in > $@
	echo >> $@
	echo "var locale = '${LANG}'" >> $@
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
	echo >> $@
	cat nrdb-language-override.js.tail.in >> $@

all: nrdb-language-override.${LANG}.user.js
