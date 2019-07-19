#!/usr/bin/bash

for filename in $@;
do
  python -m json.tool "$filename" > "$filename".tmp;
  mv "$filename".tmp "$filename";
done;
