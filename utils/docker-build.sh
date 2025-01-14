#!/bin/bash
BUILD_IMAGE=quay.io/valdar/arch-build-aur
PULL_IMAGE=false
while [[ $# -gt 0 ]]; do
  case $1 in
    -i|--image)
      BUILD_IMAGE="$2"
      shift # past argument
      shift # past value
      ;;
    -p|--pull)
      PULL_IMAGE=true
      shift # past argument
      ;;
    *)
      echo "usage: docker_build.sh -i BUILD_IMAGE (default: quay.io/valdar/arch-build-aur:lates) -p (if you want to force image pull. default: false)"
      exit 1
      ;;
  esac
done

if $PULL_IMAGE; then
   docker pull $BUILD_IMAGE
fi

docker run --rm -v $(pwd):/pkg:Z -v $(pwd):/build:Z $BUILD_IMAGE /bin/bash -c /build-pkgbuild
