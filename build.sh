#!/usr/bin/env bash
cd ~/Projects/perl-containers/

proj='Linux-Unshare'
ver=$(awk '/^version:/{print $2}' $proj/META.yml)
excludes=( Makefile.old .git build.sh up-version.sh )

if [ -z "$ver" ]; then
	echo "Unable to get $proj version"
	exit 1
fi

echo "Building project $proj version $ver"

if [ ! -d "$proj" ]; then
	echo "Unable to find $proj dir"
	exit 2
fi

for i in "${excludes[@]}"; do
	exclude_option="$exclude_option --exclude $i"
done

if [ -f $proj-${ver}.tar.gz ]; then
	rm -f "$proj-${ver}.tar.gz"
fi

mv "$proj" "${proj}-$ver"
tar "$exclude_option" -czf "$proj-${ver}.tar.gz" "${proj}-$ver"
mv "${proj}-$ver" "$proj"
