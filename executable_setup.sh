#!/bin/bash

color() {
  local -r COLOR_RESET="\033[0m"
  local -r COLOR_BLACK="\033[30m"
  local -r COLOR_RED="\033[31m"
  local -r COLOR_GREEN="\033[32m"
  local -r COLOR_YELLOW="\033[33m"
  local -r COLOR_BLUE="\033[34m"
  local -r COLOR_MAGENTA="\033[35m"
  local -r COLOR_CYAN="\033[36m"
  local -r COLOR_WHITE="\033[37m"

  local -r flag="$1"
  local -r text=("${@:2}")
  local color=""

  case "$flag" in
  -red)
    color="$COLOR_RED"
    ;;
  -green)
    color="$COLOR_GREEN"
    ;;
  -yellow)
    color="$COLOR_YELLOW"
    ;;
  -blue)
    color="$COLOR_BLUE"
    ;;
  -magenta)
    color="$COLOR_MAGENTA"
    ;;
  -cyan)
    color="$COLOR_CYAN"
    ;;
  -white)
    color="$COLOR_WHITE"
    ;;
  -black)
    color="$COLOR_BLACK"
    ;;
  esac

  echo "$color${text[*]}$COLOR_RESET"
}

log() {
  local -r FIRST_ARG="$1"
  local tag=""
  local rest_args=""
  local is_error=false

  case "$FIRST_ARG" in
  -d)
    tag=$(color -magenta "debug")
    rest_args=$(color -magenta "${@:2}")
    ;;
  -e)
    tag=$(color -red "error")
    is_error=true
    rest_args=$(color -red "${@:2}")
    ;;
  -w)
    tag=$(color -yellow "warn")
    rest_args=$(color -yellow "${@:2}")
    ;;
  -i)
    tag=$(color -cyan "info")
    rest_args=$(color -cyan "${@:2}")
    ;;
  *)
    tag=$(color -cyan "info")
    rest_args=$(color -cyan "$@")
    ;;
  esac

  local message="[$tag]: ${rest_args[*]}"

  if [[ "$is_error" == true ]]; then
    echo -e "$message" >&2
  else
    echo -e "$message"
  fi
}

banner() {
  text=("$(
    cat <<EOF
$(printf '%0.s#' {1..81})
$(figlet -f ascii12 "setup.sh")
$(printf '%0.s=' {1..81}) 
 Author: Abhishek Prajapati $(printf '%0.s-' {1..5})   Github: https://github.com/bhishekprajapati
$(printf '%0.s#' {1..81})
EOF
  )")

  local -r colored=$(color -cyan "${text[*]}")
  echo -e "${colored[*]}"
}

main() {
  banner
}

main
