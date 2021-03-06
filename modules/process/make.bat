@echo off
setlocal enableextensions

:: build utility with some *nix make conventions
:: inspired by this comment: https://superuser.com/a/717465

if /I "%1" == "all" goto:all
if /I "%1" == "clean" goto:clean

:all
  pushd "%~dp0"
  :: download sysinternals utilities (not distributed with this package to comply with license)
  echo downloading sysinternals tools
  mkdir "tools\sysinternals"
  set _targets=handle.exe handle64.exe pslist.exe pslist64.exe Listdlls.exe Listdlls64.exe PsService.exe PsService64.exe
  for %%G in (%_targets%) do (
    if exist "tools\sysinternals\%%G" (
      echo %%G already exists at tools\sysinternals\%%G
    ) else (
      echo downloading %%G
      "..\..\util\curl.exe" --insecure https://live.sysinternals.com/%%G -o "tools\sysinternals\%%G"
    )
  )
  popd
  goto:eof

:clean
  :: TODO: consider removing downloaded (sysinternals) tools
  goto:eof
