:: Get the current location path and replace backward slashes with forward slashes
SET CURRENT_PATH=%cd:\=/%
SET F_VALUE=
SET IS_FORCED_BUILD=%1
IF NOT "%IS_FORCED_BUILD%"=="" (SET F_VALUE=-f)

:: Build the image:
call docker build . -t cryptton2004/ubuntu18 %F_VALUE% Dockerfiles/ubuntu/Dockerfile --progress plain
call docker build . -t cryptton2004/ubuntu18 %F_VALUE% Dockerfiles/steamcmd/Dockerfile --progress plain

:: TO DO make foreach in Dockerfiles/*/build.bat