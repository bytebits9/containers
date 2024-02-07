#define default shell
SHELL := bash

.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
# display a warning if variable is not defined
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

OS?=$(shell uname)

ifeq ($(OS),Windows_NT)
	SHELL := bash.exe
endif

# bash colors
COLOR_RED:=\033[0;31m
COLOR_GREEN:=\033[0;32m
COLOR_YELLOW:=\033[0;33m
NO_COLOR:=\033[0m

-include devops/docker/.env

# sets default goal
.DEFAULT_GOAL:=help

include devops/make/*.mk

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\n\033[1mUsage:\033[0m\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-40s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' Makefile devops/make/*.mk
