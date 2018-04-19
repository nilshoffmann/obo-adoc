#!/bin/bash
#if [ -f "psi-ms.obo" ]; then
#  echo "psi-ms.obo file exists, please remove or backup before running this script!"
#  exit 1
#fi
mkdir -p target
cd target/
while IFS='' read -r line || [[ -n "$line" ]]; do
    wget -v $line 
    rc=$?
    if [ $rc -ne 0 ]; then
      echo "Download exited with error code $rc" >&2
      exit $rc
    fi
done < "../ontology-urls.ini"
echo "Transforming obo to asciidoc"
for i in *.obo; do
  ../psi-obo-2-adoc.groovy -f "$i" 
  rc=$?
  if [ $rc -ne 0 ]; then
    echo "Transformation exited with error code $rc" >&2
    exit $rc
  fi
done
for i in *.adoc; do
echo "Rendering asciidoc as html"
asciidoctor -b html5 -o "$i.html" "$i"
rc=$?
if [ $rc -ne 0 ]; then
  echo "Rendering exited with error code $rc" >&2
  exit $rc
fi
#echo "Rendering asciidoc as pdf"
#asciidoctor-pdf "$i"
#rc=$?
#if [ $rc -ne 0 ]; then
#  echo "Rendering exited with error code $rc" >&2
#  exit $rc
#fi
done
echo "Done!"
cd ../
