#!/bin/bash

current_version=$(awk '/^version/{print $2}' META.yml)

if [ -z "$1" ]; then
	echo "Usage: new_version"
	exit 1
fi
new_version=$1
if ! [[ $new_version =~  [0-9].[0-9]+ ]]; then
        echo "Invalid version format"
        exit 1
fi

sed -i "/^version/s/$current_version/$new_version/" META.yml
sed -i "/our\s*\$VERSION/s/$current_version/$new_version/" lib/Linux/Unshare.pm
