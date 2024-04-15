# For when auto-rotation in tablet mode dies
Restart-Service -Name SensorService
Read-Host -Prompt "Sensor Service restarted, press any key to continue"

# Additional setup:
# 1. Modify the script to open with PowerShell:
#   `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe`
# 2. Create a shortcut for the file and move it to the start menu.
#   - Adding it to `C:\ProgramData\Microsoft\Windows\Start Menu\Programs` will
#       add it to the start menu's "Programs" list; from there, you can pin it
#       to the start menu proper.
#   a. Change the target to `powershell -f <script's absolute path>`.
#   b. Modify it to run as admin (Properties > Shortcut > Advanced...).
# 3. (Optional?) Set execution policy in elevated PowerShell terminal.
#   - `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned`
#   - Alternatively, just live with the prompt to run an unsigned script?
