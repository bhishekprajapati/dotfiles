#!/usr/bin/env python3
"""Minimal bottom status bar pane: battery, time, date. Matches the top tab bar's style."""
import shutil
import sys
import time
from datetime import datetime

RESET = "\033[0m"
DIM = "\033[2m"
FG_FOG = "\033[38;2;139;136;168m"    # #8b88a8 — date
FG_MIST = "\033[38;2;214;212;232m"   # #d6d4e8 — battery (normal)
FG_ACCENT = "\033[38;2;79;124;255m"  # #4f7cff — time (accent, matches active tab)
FG_RED = "\033[38;2;255;77;109m"     # #ff4d6d — battery (low)
FG_GREEN = "\033[38;2;52;211;153m"   # #34d399 — battery (charging)

BAT_PATH = "/sys/class/power_supply/BAT0"
DOT = f"{DIM}{FG_FOG}·{RESET}"


def battery_segment() -> tuple[str, str]:
    """Return (plain_text, colored_text) for the battery segment, or ("", "") if none."""
    try:
        with open(f"{BAT_PATH}/capacity") as f:
            percent = int(f.read().strip())
        with open(f"{BAT_PATH}/status") as f:
            status = f.read().strip()
    except (FileNotFoundError, ValueError):
        return "", ""
    if status == "Discharging":
        color = FG_RED if percent <= 15 else FG_MIST
    else:
        color = FG_GREEN
    plain = f"{percent}%"
    return plain, f"{color}{plain}{RESET}"


def main() -> None:
    sys.stdout.write("\033[?25l")  # hide cursor
    sys.stdout.flush()
    try:
        while True:
            now = datetime.now()
            bat_plain, bat_colored = battery_segment()
            time_plain = now.strftime("%H:%M")
            date_plain = now.strftime("%a %d %b")

            left_plain = f"  {bat_plain}" if bat_plain else ""
            left_colored = f"  {bat_colored}" if bat_colored else ""

            right_plain = f"{time_plain}   {date_plain}  "
            right_colored = f"{FG_ACCENT}{time_plain}{RESET}   {DOT}   {DIM}{FG_FOG}{date_plain}{RESET}  "

            cols = shutil.get_terminal_size((80, 1)).columns
            pad = max(cols - len(left_plain) - len(right_plain), 0)

            sys.stdout.write(f"\r\033[K{left_colored}{' ' * pad}{right_colored}")
            sys.stdout.flush()
            time.sleep(1)
    except KeyboardInterrupt:
        pass
    finally:
        sys.stdout.write("\033[?25h")
        sys.stdout.flush()


if __name__ == "__main__":
    main()
