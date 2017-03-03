if [%REPO_ROOT%] == [] (
  set REPO_ROOT=%cd%
)

set MSBUILD_EXE="C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe"
set NUGET_EXE=%REPO_ROOT%\tools\NuGet.exe

set TRINITY_C_SLN=%REPO_ROOT%\src\Trinity.C\Trinity.C.sln
set TRINITY_CORE_SLN=%REPO_ROOT%\src\Trinity.Core\Trinity.Core.sln
set LIKQ_SLN=%REPO_ROOT%\src\LIKQ\LIKQ.sln

:: Run msbuild to build Trinity.C
%MSBUILD_EXE% /p:Configuration=Release %TRINITY_C_SLN%
if %errorlevel% neq 0 exit /b %errorlevel%

:: Run nuget to restore nuget packages for Trinity.Core
%NUGET_EXE% restore %TRINITY_CORE_SLN%
if %errorlevel% neq 0 exit /b %errorlevel%

:: Run msbuild to build Trinity.Core
%MSBUILD_EXE% /p:Configuration=Release %TRINITY_CORE_SLN%
if %errorlevel% neq 0 exit /b %errorlevel%

:: Run nuget to restore nuget packages for LIKQ
%NUGET_EXE% restore %LIKQ_SLN%
if %errorlevel% neq 0 exit /b %errorlevel%

:: TODO: Fix the build of LIKQ\FanoutSerach\FanoutSearch.UnitTest
:: and then build LIKQ.sln as a whole

:: Run msbuild to build FanoutSearch
%MSBUILD_EXE% /p:Configuration=Release %REPO_ROOT%\src\LIKQ\FanoutSearch\FanoutSearch.csproj
if %errorlevel% neq 0 exit /b %errorlevel%

:: Run msbuild to build LIKQ nuget package
%MSBUILD_EXE% /p:Configuration=Release %REPO_ROOT%\src\LIKQ\BuildNuGetPkg\BuildNuGetPkg.csproj
if %errorlevel% neq 0 exit /b %errorlevel%

:: Run msbuild to build FanoutSearch.Server
%MSBUILD_EXE% /p:Configuration=Release %REPO_ROOT%\src\LIKQ\FanoutSearch.Server\FanoutSearch.Server.csproj
if %errorlevel% neq 0 exit /b %errorlevel%