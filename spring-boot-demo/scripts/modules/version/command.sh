#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

eval "$(jq -r '@sh "tag_prefix=\(.tag_prefix)"')"

echo "tag_prefix: $tag_prefix"

prev_commit=
prev_sha=
prev_tag=$(git describe --tags --match=$tag_prefix-*-* --abbrev=0)
retVal=$?
if [ $retVal -eq 0 ]
then
    prev_commit=$(git show $prev_tag | head -1 | cut -d " " -f 2)
    prev_sha=$(echo "$prev_tag" | sed "s/^$tag_prefix-//" | cut -d "-" -f 2)
fi
current_commit=$(git show HEAD | head -1 | cut -d " " -f 2)
current_sha=$(git ls-files -z | sed 's/^/\.\//' -z | sort -z | xargs -0 sha1sum | sha1sum | awk '{print $1}' | cut -c 1-8)

if [[ "$current_commit" == "$prev_commit" ]]
then
    echo "Current commit is already tagged $prev_tag"
    exit 0
fi

latest_version=$(git tag --list --sort=taggerdate $tag_prefix-*-* | tail -1 | sed "s/^$tag_prefix-//" | cut -d "-" -f 1)
new_version=
if [[ -z "$latest_version" ]]
then
    new_version=1
    echo "No previous version found for $tag_prefix. New version: $new_version"
else
    if [[ "$current_sha" == "$prev_sha" ]]
    then
        new_version=$latest_version
        echo "Same sha for $tag_prefix $prev_sha $current_sha. New version: $new_version"
    else
        new_version=$((latest_version + 1))
        echo "Different sha for $tag_prefix $prev_sha $current_sha. New version: $new_version"
    fi
fi

if [[ "$new_version" != "$latest_version" ]]
then
    git tag "$tag_prefix-$new_version-$current_sha"
    git push --tags
fi

jq -n --arg verson "$new_version" '{"verson":"$verson"}'