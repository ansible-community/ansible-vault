default: help

.PHONY: help
help: ## list makefile targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: lint
lint: ## lint all scenarios
	for scenario in $(shell ls molecule); do \
		molecule lint -s $$scenario; \
	done

.PHONY: test
test: ## test all scenarios
	for scenario in $(shell ls molecule); do \
		molecule test -s $$scenario; \
		$(MAKE) clean; \
	done

.PHONY: clean
clean: ## clean temporary files
	rm -rf files/EULA.txt files/TermsOfEvaluation.txt files/vault files/vault_*