rem https://stackoverflow.com/questions/7690994/powershell-running-a-command-as-administrator

@echo off

set scriptFileName=%~n0
set scriptFolderPath=%~dp0.
set powershellScriptFileName=PasswordResetter.ps1

powershell -Command "Start-Process powershell \"-ExecutionPolicy Bypass -NoProfile -NoExit -Command `\"cd \`\"%scriptFolderPath%\`\"; & \`\".\%powershellScriptFileName%\`\"`\"\" -Verb RunAs"