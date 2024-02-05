# Copyright (c) 2024-present Sven Greb <development@svengreb.de>
# This source code is licensed under the GPL-3.0 license found in the license file.

_current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ETHEREON_TMUX_COLOR_FILE="src/ethereon.conf"
ETHEREON_TMUX_STATUS_CONTENT_FILE="src/ethereon-status-content.conf"

__init() {
    tmux source-file "$_current_dir/$ETHEREON_TMUX_COLOR_FILE"

    if [ "$(tmux show-option -gqv "clock-mode-style")" == '12' ]; then
        tmux set-environment -g ETHEREON_TMUX_STATUS_TIME_FORMAT "%I:%M %p"
    else
        tmux set-environment -g ETHEREON_TMUX_STATUS_TIME_FORMAT "%H:%M"
    fi

    if [ -z "$date_format" ]; then
        tmux set-environment -g ETHEREON_TMUX_STATUS_DATE_FORMAT "%m/%d/%Y"
    else
        tmux set-environment -g ETHEREON_TMUX_STATUS_DATE_FORMAT "$date_format"
    fi

    tmux source-file "$_current_dir/$ETHEREON_TMUX_STATUS_CONTENT_FILE"
}

__cleanup() {
    unset -v ETHEREON_TMUX_COLOR_FILE
    unset -v ETHEREON_TMUX_STATUS_CONTENT_FILE
    unset -v _current_dir
    unset -f __init __cleanup
    tmux set-environment -gu ETHEREON_TMUX_STATUS_TIME_FORMAT
    tmux set-environment -gu ETHEREON_TMUX_STATUS_DATE_FORMAT
}

__init
__cleanup
