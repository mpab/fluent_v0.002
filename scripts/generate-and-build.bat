@echo off

if "%1x" == "x" (
    echo usage %0 project
    goto :eof
)

if not exist %1 (
    echo ERROR: folder %1 not found
    goto :eof
)

if not exist %1\CMakeLists.txt (
    echo ERROR: file %1\CMakeLists.txt not found
    goto :eof
)

if "%2x" == "newx" (
    rmdir /s /q %1-build
    mkdir %1-build
)

if not exist %1-build (
    echo ERROR: folder %1-build not found, use %0 project new to create 
    goto :eof
)

pushd %1-build
cmake ..\%1
call env-vs
call msbuild %1.sln
popd