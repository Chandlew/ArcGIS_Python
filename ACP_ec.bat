@echo off
set /p commit_message=Enter your commit message: 

:: Get the current branch name
for /f "tokens=*" %%A in ('git rev-parse --abbrev-ref HEAD') do set current_branch=%%A

:: Add and commit changes
git add .
git commit -m "%commit_message%"

if errorlevel 1 (
    echo Commit failed. Please resolve any issues and try again.
    exit /b 1
)

:: Push to the current branch
git push origin %current_branch%

if errorlevel 1 (
    echo Push failed. Please resolve any issues and try again.
    exit /b 1
)

echo Changes successfully committed and pushed to the %current_branch% branch.
