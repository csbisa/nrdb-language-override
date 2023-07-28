userscript for overriding [NetrunnerDB](https://netrunnerdb.com) card data with translations.

Translated card data is sourced from [netrunner-cards-json](https://github.com/NetrunnerDB/netrunner-cards-json).

# Installation

This is a Tampermonkey user script. You will need to install the Tampermonkey extension
([firefox](https://addons.mozilla.org/en/firefox/addon/tampermonkey/),
[chrome](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo),
and other browsers should be supported). Then head to the Downloads section and click the link for
your desired language to install it.

# Usage

After installation, you should start seeing translations for cards on the card detail page,
decklists, and so on. There may also be additional UI elements translated.

Note the following caveats:
- When importing decks for Jinteki.net, lists that include translated card names cannot be
  imported. Switch to English (via 'English' on the top right of the page) before importing
  decklists.
- While searching for cards, autocompletion suggestions will include translated card names. However,
  the actual search will only search English card names.

# Adding a new language

Firstly, the card data will only be as good as the data in
[netrunner-cards-json](https://github.com/NetrunnerDB/netrunner-cards-json) so any available data
there under `translations/<lang>` should be verified first.

- Pick the language code for the language. It's (usually) the ISO 639-1 language code and should
  have a corresponding folder under `translations` in netrunner-cards-json.
- Add the language to `langs.json`.
- Add translations to the rest of the JSON files in the repo (e.g. `formats.json`) for your
  language code.
- Add the language code to `LANGS` in `Makefile`.

There then should be a new `nrdb-language-override.<LANG>.user.js` generated when you run `make`.
