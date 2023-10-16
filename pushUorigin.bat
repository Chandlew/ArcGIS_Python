@echo off
setlocal

:: Set the name of your remote (usually "origin" by default)
set remote=origin

:: Get the name of the current branch
for /f "tokens=*" %%a in ('git symbolic-ref --short HEAD') do set branch=%%a

:: Check if the branch exists on the remote repository
git ls-remote --exit-code %remote% refs/heads/%branch%

if %errorlevel% neq 0 (
    echo Branch "%branch%" does not exist on remote "%remote%".
    :: Create the branch on the remote repository and set up tracking
    git push -u %remote% %branch%
    :: Check if the push was successful
    if %errorlevel% equ 0 (
        echo Branch "%branch%" has been created on remote "%remote%" and set up tracking.
    ) else (
        echo Failed to create branch "%branch%" on remote "%remote%".
        exit /b 1
    )
) else (
    :: Push the current branch to the remote repository and set up tracking
    git push -u %remote% %branch%
    :: Check the exit code of the git push command
    if %errorlevel% equ 0 (
        echo Successfully pushed branch "%branch%" to "%remote%" and set up tracking.
    ) else (
        echo Failed to push branch "%branch%" to "%remote%".
        exit /b 1
    )
)

endlocal
