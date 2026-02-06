SHELL := /usr/bin/env bash


CHECKMAKE=go run github.com/checkmake/checkmake/cmd/checkmake@latest




.PHONY: all

all: help ## default target (invokes help)

.PHONY: test
	test: check ## perform tests (checks/linting).


.PHONY: shellcheck
shellcheck: ## lint shell scripts

	shellcheck --severity=warning --format=gcc --shell=bash  $(shell find .  -type f -name '*.sh') 

.PHONY: check
check: checkmake shellcheck  ## perform checks and linting

.PHONY: makeckmake
checkmake: ## lint the Makefile with checkmake.
	@$(CHECKMAKE) Makefile

.PHONY: clean

clean: ## clean the working directory (currently vain).
	@echo "Note: no generated files.  not cleaning. use git to clean."

.PHONY: help
help: ## Show usage info  for the Makefile targets.
	@echo  "Usage: make [OPTION1=value OPTION2=value  ...] [TARGET ...]"
	@echo " Available targets:"
	@grep --no-filename -E '^[a-zA-Z0-9_%-. ]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


