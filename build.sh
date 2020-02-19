export IMG_NAME=rsyslog
export TAG=latest
export REPO=garybowers

make build
make tag
make push
