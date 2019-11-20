@ECHO OFF

SET /P import_file_name="Enter a name for the import file: "

IF EXIST "%import_file_name%" (
    ECHO '%import_file_name%' already exists in the current directory.
    ECHO Please choose a different name.
) ELSE (
    SET /P search_string="Enter the search string for the files to import: "

    (ECHO ^<?xml version="1.0" encoding="utf-8" ?^>) > %import_file_name%
    (ECHO ^<files^>) >> %import_file_name%

    REM Dump all of the file names in; I haven't figured out how to get the whole import file written correctly
    (DIR /B "%search_string%") >> %import_file_name%

    (ECHO ^<^/files^>) >> %import_file_name%

    ECHO '%import_file_name%' written; further modifications required before use.
)
