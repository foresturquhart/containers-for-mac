SHELL := /usr/bin/env bash

.EXPORT_ALL_VARIABLES:

BUILD_TAG ?= $(shell git describe --tags 2>/dev/null || echo "0.0.0")
BUILD_REF ?= $(shell git rev-parse --short HEAD 2>/dev/null || echo "devel")
BUILD_DATE ?= $(shell date +"%b %d %Y %T")

SWIFTC_FLAGS =
LINKER_FLAGS = -Xlinker -L/usr/local/lib

BASE_DIR ?= "$(CURDIR)"

SWIFT_DIR ?= "$(BASE_DIR)/.swift"

OUT_DIR ?= "$(BASE_DIR)/bin"
OUT_BIN ?= "hvs"

.PHONY: all
all:
	@echo -e "\033[93m\033[1mCommands:\033[0m"
	@sed -n 's/^\([a-zA-Z_-]*\):.*\#\# \(.*\)/\1\t\2/p' $(MAKEFILE_LIST) | awk -F\t '{ printf "\033[96m\xe2\x80\xba \033[1m%s\033[0m\t%s\n", $$1, $$2 }'

run: build ## Build and run the server binary
	$(OUT_DIR)/$(OUT_BIN)

build: clean ## Build the debug server binary
	@swift build -c debug --build-path=$(SWIFT_DIR) $(SWIFTC_FLAGS) $(LINKER_FLAGS)
	@cp -f $(SWIFT_DIR)/debug/hvs $(OUT_DIR)/$(OUT_BIN)
	@chmod u+x $(OUT_DIR)/$(OUT_BIN)

build-release: clean ## Build the release server binary
	@swift build -c release --build-path=$(SWIFT_DIR) $(SWIFTC_FLAGS) $(LINKER_FLAGS)
	@cp -f $(SWIFT_DIR)/release/hvs $(OUT_DIR)/$(OUT_BIN)
	@chmod u+x $(OUT_DIR)/$(OUT_BIN)

clean: ## Clean the output directory
	@mkdir -p "$(OUT_DIR)" || true
	@rm -f "$(OUT_DIR)/$(OUT_BIN)" 2> /dev/null || true
