#!/bin/bash -e

GREEN='\033[0;32m'
RED='\033[0;31m'
NO_COLOR='\033[0m'

function log_failure {
  echo -e "${RED}FAILURE${NO_COLOR} $*"
  exit 1
}

function log_success {
  echo -e "${GREEN}SUCCESS${NO_COLOR} $*"
}

function is_supported_os {
  if [[ "$OSTYPE" != "linux-gnu" ]]; then
    log_failure "This script is only intended for Linux"
  fi
}
