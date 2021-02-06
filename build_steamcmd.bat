:: Get the current location path and replace backward slashes with forward slashes
SET CURRENT_PATH=%cd:\=/%

:: Build the image:
call docker build . -t cryptton2004/ubuntu18 Dockerfiles/steamcmd/Dockerfile --progress plain
