SHELL := /usr/bin/env bash

.EXPORT_ALL_VARIABLES:

BUILD_TAG ?= $(shell git describe --tags 2>/dev/null || echo "0.0.0")
BUILD_REF ?= $(shell git rev-parse --short HEAD 2>/dev/null || echo "devel")
BUILD_DATE ?= $(shell date +"%b %d %Y %T")

PWD := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

BASE_DIR ?= $(CURDIR)

OUT_DIR ?= $(BASE_DIR)/bin
OUT_BIN ?= hvc

.PHONY: all
all:
	@echo -e "\033[93m\033[1mCommands:\033[0m"
	@sed -n 's/^\([a-zA-Z_-]*\):.*\#\# \(.*\)/\1\t\2/p' $(MAKEFILE_LIST) | awk -F\t '{ printf "\033[96m\xe2\x80\xba \033[1m%s\033[0m\t%s\n", $$1, $$2 }'

run: build ## Build and run the client binary
	@$(OUT_DIR)/$(OUT_BIN)

proto: ## Compile the client protocol buffer
	@protoc --proto_path="$(abspath $(PWD)/../)" --go_out="$(abspath $(PWD)/../)" --go_opt="Mdefs.proto=hvc/pkg/hvc/proto" "defs.proto"

build: clean proto ## Build the debug client binary
	@go build -ldflags "-X 'hvc/pkg/hvc.Tag=$(BUILD_TAG)' -X 'hvc/pkg/hvc.Ref=$(BUILD_REF)' -X 'hvc/pkg/hvc.Date=$(BUILD_DATE)'" -o $(OUT_DIR)/$(OUT_BIN) cmd/hvc/main.go
	@chmod u+x $(OUT_DIR)/$(OUT_BIN)

build-release: clean ## Build the release client binary
	@go build -trimpath -ldflags "-s -w -X 'hvc/pkg/hvc.Tag=$(BUILD_TAG)' -X 'hvc/pkg/hvc.Ref=$(BUILD_REF)' -X 'hvc/pkg/hvc.Date=$(BUILD_DATE)'" -o $(OUT_DIR)/$(OUT_BIN) cmd/hvc/main.go
	@chmod u+x $(OUT_DIR)/$(OUT_BIN)

clean: ## Clean the output directory
	@mkdir -p "$(OUT_DIR)"
	@rm -f "$(OUT_DIR)/$(OUT_BIN)" 2> /dev/null || true
