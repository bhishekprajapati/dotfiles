#!/usr/bin/env bash

set -Eeuo pipefail

is_root() {
  if [[ $(id -u) -eq 0 ]]; then
    return 0
  else
    return 1
  fi
}

maybe_sudo() {
  if ! is_root; then
    sudo "$@"
  else
    "$@"
  fi
}

str_trim() {
  echo "$*" | xargs
}

str_to_lowercase() {
  echo "$*" | tr '[:upper:]' '[:lower:]'
}

str_is_empty() {
  local -r input="$*"

  if [[ -z "$input" ]]; then
    return 0
  else
    return 1
  fi
}

readonly OS="$(uname -s)"
readonly ARCH="$(uname -m)"
readonly NORMALIZED_OS="$(str_trim "$(str_to_lowercase "$OS")")"
readonly NORMALIZED_ARCH="$(str_trim "$(str_to_lowercase "$ARCH")")"
has_updated_apt=false

update_apt() {
  if [[ $has_updated_apt == false ]]; then
    if maybe_sudo apt update; then
      has_updated_apt=true
    fi
  fi
}

is_exec() {
  local -r name="$1"
  command -v "$name" >/dev/null 2>&1
}

os_is_linux() {
  if [[ "$NORMALIZED_OS" == "linux" ]]; then
    return 0
  else
    return 1
  fi
}

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
  -s)
    tag=$(color -green "info")
    rest_args=$(color -green "${@:2}")
    ;;
  *)
    tag=$(color -white "info")
    rest_args=$(color -white "$@")
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

  local -r colored=$(color -blue "${text[*]}")
  echo -e "${colored[*]}"
}

install() {
  get_installer_name() {
    local -r bin_name="$1"
    echo "install_${bin_name}_${NORMALIZED_OS}_${NORMALIZED_ARCH}"
  }

  has_installer() {
    local -r func_name="$1"
    declare -F "$func_name" >/dev/null
  }

  install_neovim_linux_x86_64() {
    if is_exec "nvim"; then
      log -i "[skipped]: neovim is already installed."
      return 0
    fi

    local -r filename="nvim-linux-x86_64.tar.gz"

    cleanup() {
      rm -f "$filename" || true
    }

    cleanup

    {
      curl -fLO "https://github.com/neovim/neovim/releases/download/v0.11.2/$filename" &&
        maybe_sudo tar -C "/opt" -xzf "$filename" &&
        rm -rf "/opt/nvim-linux-x86_64/.git" &&
        log -s "Neovim installed!"
    } || {
      log -e "Failed to install neovim"
    }

    cleanup
  }

  local -r bin_name="$1"
  local -r installer_name="$(get_installer_name "$bin_name")"

  if has_installer "$installer_name"; then
    "$installer_name"
  else
    log -e "No installer implemented"
  fi
}

main() {
  banner 2>/dev/null || true

  log "Checking operating system..."
  log "Detected $NORMALIZED_OS os"
  log "Detected architecture $NORMALIZED_ARCH"

  if ! os_is_linux; then
    log -w "Not implemented for this os"
    return 0
  fi

  install_base_tools() {
    if ! is_exec 'apt'; then
      log -e "Can't find apt package manager. Failed to install fuzzy finder."
      return 1
    fi

    update_apt

    local -r tools=("fzf" "curl")
    log -i "Installing base tools ${tools[*]}"

    local tool=''
    for tool in "${tools[@]}"; do
      if is_exec "$tool"; then
        log -i "[Skipped]: $tool is already installed."
      else
        apt install -y "$tool"
      fi
    done
  }

  install_base_tools

  local -r bins=("neovim" "go" "rust" "ripgrep" "lazygit")
  selected=$(printf "%s\n" "${bins[@]}" | fzf --multi --prompt="Select binaries> ")

  local bin_name=""
  for bin_name in $selected; do
    install "$bin_name"
  done
}

main
