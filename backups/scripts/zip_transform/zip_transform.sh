#!/bin/bash

# This script will zip up the release version of the DLL and PDB file for the
# specified transform.

echo -e "\nEnter the site name abbreviation as it appears in the repo folder name (e.g. 'tmc' for 'cls.impl.tmc')."
read -p "Site name: " siteName
repoFolder="cls.impl.${siteName}"

echo -e "\nEnter a description for the file." 
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
    for file in $(find ${repoFolder} -not -path ${excludePattern} -wholename ${searchPattern}); do
        files+=($(basename ${file}))
    done

    outputDirectory=$(pwd)

    # Get names of more files to include in the archive
    echo -e "\n(Optional) Additional files"
    echo -e "Enter the name of another file in the release directory to include in the archive."
    read -p "File name (leave blank to continue): " additionalFileName

    while [ -n "${additionalFileName}" ]; do
        # Only add the file to the list if it exists
        if [ -e "${releaseDirectory}/${additionalFileName}" ]; then
            files+=(${additionalFileName})
        else
            echo -e "'${additionalFileName}' does not exist.\n"
        fi

        read -p "File name (leave blank to continue): " additionalFileName
    done

    # Get the short commit hash and branch name
    cd ${repoFolder}
    commitHash=$(git rev-parse --short HEAD)
    branchName=$(git rev-parse --abbrev-ref HEAD)
    cd ${outputDirectory}

    archiveName="${siteName}-transform-${branchName}-${commitHash}"
    archiveFullPath="${outputDirectory}/${archiveName}.tar"

    # Create the archive
    echo -e "\nZipping up files..."
    tar -cvf ${archiveFullPath} -C ${releaseDirectory} ${files[@]}

    echo -e "\nOutput archive: ${archiveFullPath}"

    # Run the script that exports the auth tokens for [REDACTED]
    source ./[REDACTED]_auth.sh

    echo -e "\nUploading the archive to [REDACTED]..."
    curl \
        -H "X-User-Id: ${[REDACTED]UserId}" \
        -H "X-Auth-Token: ${[REDACTED]Token}" \
        -F "description=${fileDescription}" \
        -F file=@${archiveFullPath} \
        "https://chat.[REDACTED].com/api/v1/rooms.upload/[REDACTED]"

    echo -e "\n\nRemoving local copy of archive..."
    rm ${archiveFullPath}

    echo -e "\nDone!"
else
    echo "The directory '${repoFolder}' does not exist!"
fi

