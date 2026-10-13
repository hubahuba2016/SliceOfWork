#!/bin/sh
printf '\033c\033]0;%s\a' SliceOfWork
base_path="$(dirname "$(realpath "$0")")"
"$base_path/SliceOfWorkLINUX.x86_64" "$@"
