# Copyright (c) 2024-present Sven Greb <development@svengreb.de>
# This source code is licensed under the GPL-3.0 license found in the license file.

_current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ETHEREON_TMUX_COLOR_FILE=src/ethereon.conf

__init() {
    tmux source-file "$_current_dir/$ETHEREON_TMUX_COLOR_FILE"
}

__cleanup() {
    unset -v ETHEREON_TMUX_COLOR_FILE
    unset -f __init __cleanup
}

__init
__cleanup
