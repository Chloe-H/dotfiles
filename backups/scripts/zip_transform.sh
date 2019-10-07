#!/bin/bash

# This script will zip up the release version of the DLL and PDB file for the
# specified transform.

echo -e "\nEnter the site name abbreviation as it appears in the repo folder name (e.g. 'tmc' for 'cls.impl.tmc')."
read -p "Site name: " siteName
repoFolder="cls.impl.${siteName}"

echo -e "Enter a description for the file." 
read -p "File description: " fileDescription

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
    cd ${repoFolder}
    archiveSuffix=$(git rev-parse --short HEAD)
    cd ${outputDirectory}

    archiveName="${outputDirectory}/${siteName}-transform-${archiveSuffix}.tar"

    echo -e "\nZipping up files..."
    tar -cvf ${archiveName} -C ${releaseDirectory} ${files[@]}

    echo -e "\nOutput archive: ${archiveName}"

    # Run the script that exports the auth tokens for [REDACTED]
    source ./[REDACTED]_auth.sh

    echo -e "\nUploading the archive to [REDACTED]..."
    curl \
        -H "X-User-Id: ${[REDACTED]UserId}" \
        -H "X-Auth-Token: ${[REDACTED]Token}" \
        -F "description=${fileDescription}" \
        -F file=@${archiveName} \
        "https://chat.[REDACTED].com/api/v1/rooms.upload/[REDACTED]"

    echo -e "\n"
else
    echo "The directory '${repoFolder}' does not exist!"
fi

