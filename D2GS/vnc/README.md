

# https://stackoverflow.com/questions/49377744/how-to-run-docker-image-in-ubuntu-with-vnc


docker build --pull --no-cache --rm -f "xserver.Dockerfile" -t xserver:latest "."
docker run --rm -ti -i -t -d -p 5900:5900 --name xserver xserver:latest