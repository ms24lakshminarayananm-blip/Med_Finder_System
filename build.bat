@echo off
setlocal

REM ==================================================
REM MEDICINE AVAILABILITY FINDER SYSTEM - BUILD SCRIPT
REM Compiles Java source files and creates WAR file
REM ==================================================

echo.
echo ==================================================
echo MEDICINE AVAILABILITY FINDER SYSTEM - BUILD
echo ==================================================

echo.
echo [1/4] Creating WEB-INF/classes directory...

if not exist "src\main\webapp\WEB-INF\classes" (
    mkdir "src\main\webapp\WEB-INF\classes"
)

echo Done.

echo.
echo [2/4] Collecting Java source files...

dir /s /b "src\main\java\*.java" > sources.txt

echo Done.

echo.
echo [3/4] Compiling Java classes with javac...

javac -d "src\main\webapp\WEB-INF\classes" -cp "src\main\webapp\WEB-INF\lib\*;lib\*" @sources.txt

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ==================================================
    echo BUILD FAILED!
    echo Check the Java error messages above.
    echo ==================================================
    if exist sources.txt del sources.txt
    pause
    exit /b 1
)

echo.
echo ==================================================
echo JAVA COMPILATION SUCCESSFUL!
echo ==================================================

if exist sources.txt del sources.txt

echo.
echo [4/4] Creating WAR file...

if exist "medicine-availability-finder.war" (
    del /f /q "medicine-availability-finder.war"
)

jar -cf "medicine-availability-finder.war" -C "src\main\webapp" .

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ==================================================
    echo WAR CREATION FAILED!
    echo ==================================================
    pause
    exit /b 1
)

echo.
echo ==================================================
echo BUILD SUCCESSFUL!
echo ==================================================
echo.
echo WAR file created:
echo medicine-availability-finder.war
echo.
echo Location:
echo %CD%\medicine-availability-finder.war
echo.
echo ==================================================

pause
endlocal