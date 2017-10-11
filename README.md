# obo-adoc
Provides scripts to transform obo files into linked asciidoc and from there to HTML or PDF output.

Please note that this is currently hardcoded to download the PSI-MS obo file.

Issues and pull requests welcome!

## Requirements

- Linux / OSX with bash
- Groovy >=2.4.12 (installation with SDKMAN (http://sdkman.io/))
- asciidoctor (http://asciidoctor.org)
- asciidoctor-pdf (https://github.com/asciidoctor/asciidoctor-pdf)

## How To Run
Open a terminal and run

	./dtr.sh

This will pull the latest version of the PSI-MS obo file from GitHub,
convert it to AsciiDoc and render it to HTML5 and PDF in the same directory.
