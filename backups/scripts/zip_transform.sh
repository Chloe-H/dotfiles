#!/bin/bash

# This script will zip up the release version of the DLL and PDB file for the
# specified transform.

echo -e "\nEnter the site name abbreviation as it appears in the repo folder name (e.g. 'tmc' for 'cls.impl.tmc')."
read -p "Site name: " siteName
repoFolder="cls.impl.${siteName}"

echo -e "Enter a suffix for the archive's name or leave it blank to use the short commit hash." 
read -p "Output archive suffix: " archiveSuffix

if [ -d ${repoFolder} ]; then
    # Pattern to find the release binaries
    searchPattern="*[REDACTED].Cls.Impl.*/bin/Release/[REDACTED].Cls.Impl.*"

    # Get the path to the release directory
    releaseDirectory=$(dirname $(find ${repoFolder} -not -path *[REDACTED].Cls.Impl.*.Test/* -wholename ${searchPattern}.dll))

    # Get the names of the DLL and PDB files
    declare -a files
    for file in $(find ${repoFolder} -wholename ${searchPattern})
        do files+=($(basename ${file}))
    done

    # By getting only the base names of the files and changing to the release
    # binaries directory, I am able to avoid duplicating the structure of the
    # transform's repository in the archive I create.
    outputDirectory=$(pwd)
    cd ${releaseDirectory}

    # Get the short commit hash (must be in the Git repository)
    if [ -z "${archiveSuffix}" ]; then
        archiveSuffix=$(git rev-parse --short HEAD)
    fi

    archiveName="${outputDirectory}/${siteName}-transform-${archiveSuffix}.tar"

    echo -e "\nZipping up files..."
    tar -cvf ${archiveName} ${files[@]}

    echo -e "\nOutput archive: ${archiveName}"
else
    echo "The directory '${repoFolder}' does not exist!"
fi

