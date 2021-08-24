SHELL := /usr/bin/env bash

.EXPORT_ALL_VARIABLES:

BUILD_TAG ?= $(shell git describe --tags 2>/dev/null || echo "0.0.0")
BUILD_REF ?= $(shell git rev-parse --short HEAD 2>/dev/null || echo "devel")
BUILD_DATE ?= $(shell date +"%b %d %Y %T")

BASE_DIR ?= "$(CURDIR)"

SRC_DIR ?= "$(BASE_DIR)/src"
OUT_DIR ?= "$(BASE_DIR)/bin"

.PHONY: all
all:
	@echo -e "\033[93m\033[1mCommands:\033[0m"
	@sed -n 's/^\([a-zA-Z_-]*\):.*\#\# \(.*\)/\1\t\2/p' $(MAKEFILE_LIST) | awk -F\t '{ printf "\033[96m\xe2\x80\xba \033[1m%s\033[0m\t%s\n", $$1, $$2 }'

run: build ## Build and run the client and server binaries
	$(OUT_DIR)/hvc & $(OUT_DIR)/hvs

build: clean ## Build debug client and server binaries
	@BASE_DIR="$(BASE_DIR)" BUILD_TAG="$(BUILD_TAG)" BUILD_REF="$(BUILD_REF)" BUILD_DATE="$(BUILD_DATE)" $(MAKE) -C "$(SRC_DIR)/hvc" build
	@BASE_DIR="$(BASE_DIR)" BUILD_TAG="$(BUILD_TAG)" BUILD_REF="$(BUILD_REF)" BUILD_DATE="$(BUILD_DATE)" $(MAKE) -C "$(SRC_DIR)/hvs" build

build-release: clean ## Build release client and server binaries
	@BASE_DIR="$(BASE_DIR)" BUILD_TAG="$(BUILD_TAG)" BUILD_REF="$(BUILD_REF)" BUILD_DATE="$(BUILD_DATE)" $(MAKE) -C "$(SRC_DIR)/hvc" build-release
	@BASE_DIR="$(BASE_DIR)" BUILD_TAG="$(BUILD_TAG)" BUILD_REF="$(BUILD_REF)" BUILD_DATE="$(BUILD_DATE)" $(MAKE) -C "$(SRC_DIR)/hvs" build-release

clean: ## Clean the output directory
	@BASE_DIR="$(BASE_DIR)" $(MAKE) -C "$(SRC_DIR)/hvc" clean
	@BASE_DIR="$(BASE_DIR)" $(MAKE) -C "$(SRC_DIR)/hvs" clean
