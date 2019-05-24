#!/bin/bash

# This script will zip up the release version of the DLL and PDB file for the
# specified transform.

# Prompt for suffix of transform repository's directory name
echo -e "\nEnter the site name abbreviation as it appears in the repo folder name (e.g. 'tmc' for 'cls.impl.tmc')"
read -p "Site name: " siteName

if [ -d "cls.impl.$siteName" ]; then
    # Pattern to find the release binaries
    searchPattern="*[REDACTED].Cls.Impl.*[^Test]/bin/Release/[REDACTED].Cls.Impl.*"

    # Get the path to the release directory
    releaseDirectory=$(dirname $(find cls.impl.$siteName -wholename $searchPattern.dll))

    # Get the names of the DLL and PDB files
    declare -a files
    for file in $(find cls.impl.$siteName -wholename $searchPattern)
        do files+=($(basename $file))
    done

    # Zip up the DLL and PDB files
    currentDirectory=$(pwd)
    cd $releaseDirectory
    echo -e "\nZipping up files..."

    # By getting only the base names of the files and changing to the release
    # binaries directory, we are able to avoid duplicating the structure of the
    # transform's repository in the archive we create.
    tar -cvf $currentDirectory/$siteName-transform.tar ${files[@]}
else
    echo "The directory 'cls.impl.$siteName' does not exist!"
fi

