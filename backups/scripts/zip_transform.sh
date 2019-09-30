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

    # Pattern to exclude the test directory
    excludePattern="*[REDACTED].Cls.Impl.*.Test/*"

    # Get the path to the release directory
    releaseDirectory=$(dirname $(find ${repoFolder} -not -path ${excludePattern} -wholename ${searchPattern}.dll))

    # Get the names of the DLL and PDB files
    declare -a files
    for file in $(find ${repoFolder} -not -path ${excludePattern} -wholename ${searchPattern})
        do files+=($(basename ${file}))
    done

    outputDirectory=$(pwd)

    # Get the short commit hash (must be in the Git repository)
    if [ -z "${archiveSuffix}" ]; then
        cd ${repoFolder}
        archiveSuffix=$(git rev-parse --short HEAD)
    fi

    archiveName="${outputDirectory}/${siteName}-transform-${archiveSuffix}.tar"

    echo -e "\nZipping up files..."
    tar -cvf ${archiveName} -C ${releaseDirectory} ${files[@]}

    echo -e "\nOutput archive: ${archiveName}"
else
    echo "The directory '${repoFolder}' does not exist!"
fi

