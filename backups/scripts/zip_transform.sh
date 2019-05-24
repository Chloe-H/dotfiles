#!/bin/bash

# This script will zip up the release version of the DLL and PDB file for the
# specified transform.

# Prompt for suffix of transform repository's directory name
echo -e "\nEnter the site name abbreviation as it appears in the repo folder name (e.g. 'tmc' for 'cls.impl.tmc')"
read -p "Site name: " siteName

# Prompt for optional suffix for output archive's name (I like to use the commit hash)
read -p "(Optional) Enter a suffix for the archive's name: " archiveSuffix

if [ -d "cls.impl.${siteName}" ]; then
    # Pattern to find the release binaries
    searchPattern="*[REDACTED].Cls.Impl.*[^Test]/bin/Release/[REDACTED].Cls.Impl.*"

    # Get the path to the release directory
    releaseDirectory=$(dirname $(find cls.impl.${siteName} -wholename ${searchPattern}.dll))

    # Get the names of the DLL and PDB files
    declare -a files
    for file in $(find cls.impl.${siteName} -wholename ${searchPattern})
        do files+=($(basename ${file}))
    done

    # By getting only the base names of the files and changing to the release
    # binaries directory, I am able to avoid duplicating the structure of the
    # transform's repository in the archive I create.

    currentDirectory=$(pwd)
    cd $releaseDirectory
    echo -e "\nZipping up files..."

    archiveName="${currentDirectory}/${siteName}-transform"

    # Add suffix to archive name, if provided
    if [ -z "${archiveSuffix}" ]; then
        archiveName="${archiveName}-${archiveSuffix}"
    fi

    # Zip up the DLL and PDB files
    tar -cvf ${archiveName}.tar ${files[@]}
else
    echo "The directory 'cls.impl.${siteName}' does not exist!"
fi

