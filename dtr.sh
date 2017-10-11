#!/bin/bash
if [ -f "psi-ms.obo" ]; then
  echo "psi-ms.obo file exists, please remove or backup before running this script!"
  exit 1
fi
echo "Downloading latest PSI-MS CV version"
wget https://raw.githubusercontent.com/HUPO-PSI/psi-ms-CV/master/psi-ms.obo 
rc=$?
if [ $rc -ne 0 ]; then
  echo "Download exited with error code $rc" >&2
  exit $rc
fi
echo "Transforming obo to asciidoc"
./psi-obo-2-adoc.groovy -f psi-ms.obo
rc=$?
if [ $rc -ne 0 ]; then
  echo "Transformation exited with error code $rc" >&2
  exit $rc
fi
echo "Rendering asciidoc as html"
asciidoctor -b html5 -o psi-ms.html psi-ms.adoc
rc=$?
if [ $rc -ne 0 ]; then
  echo "Rendering exited with error code $rc" >&2
  exit $rc
fi
echo "Rendering asciidoc as pdf"
asciidoctor-pdf psi-ms.adoc
rc=$?
if [ $rc -ne 0 ]; then
  echo "Rendering exited with error code $rc" >&2
  exit $rc
fi
echo "Done!"
