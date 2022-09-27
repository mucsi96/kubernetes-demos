#!/bin/bash

cd client
prev_commit=
prev_sha=
prev_tag=$(git describe --tags --match=client-image-*-* --abbrev=0)
retVal=$?
if [ $retVal -eq 0 ]
then
    prev_sha=$(echo "$prev_tag" | sed "s/^client-image-//" | cut -d "-" -f 2)
    prev_commit=$(git show $prev_tag | sed -n "1p" | cut -d " " -f 2)
fi
current_commit=$(git show HEAD | sed -n "1p" | cut -d " " -f 2)
current_sha=$(git ls-files -z | sed 's/^/\.\//' -z | sort -z | xargs -0 sha1sum | sha1sum | awk '{print $1}' | cut -c 1-8)

if [[ "$current_commit" == "$prev_commit" ]]
then
    echo "Current commit is already tagged $prev_tag"
    exit 0
fi

latest_version=$(git tag --list --sort=taggerdate client-image-*-* | tail -1 | sed "s/^client-image-//" | cut -d "-" -f 1)
new_version=
if [[ -z "$latest_version" ]]
then
    new_version=1
    echo "No previous version found for client-image. New version: $new_version"
else
    if [[ "$current_sha" == "$prev_sha" ]]
    then
        new_version=$latest_version
        echo "Same sha for client-image $prev_sha $current_sha. New version: $new_version"
    else
        new_version=$((latest_version + 1))
        echo "Different sha for client-image $prev_sha $current_sha. New version: $new_version"
    fi
fi

if [[ "$new_version" != "$latest_version" ]]
then
    git tag "client-image-$new_version-$current_sha"
    git push --tags
    echo -n "$new_version" > version.txt
fi

