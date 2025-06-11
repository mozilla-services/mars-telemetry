OUTPUT_DIR := build
.DEFAULT_GOAL := translate

.PHONY: lint translate

lint: ## lint the yaml files
	@echo "Glinting..."
	@glean_parser glinter telemetry/glean/metrics.yaml telemetry/glean/pings.yaml

translate: lint ## generate the go server code from the yaml files
	@echo "Generating go server package..."
	@glean_parser translate -o ${OUTPUT_DIR} -f go_server telemetry/glean/metrics.yaml telemetry/glean/pings.yaml

help: ## show this help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)