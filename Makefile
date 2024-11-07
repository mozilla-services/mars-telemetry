OUTPUT_DIR := build

.PHONY: lint translate

lint: ## ling the yaml files
	@echo "Glinting..."
	@glean_parser glinter telemetry/glean/metrics.yaml telemetry/glean/pings.yaml

translate: ## generate the go server code from the yaml files
	@echo "Generating go server package..."
	@glean_parser translate -o ${OUTPUT_DIR} -f go_server telemetry/glean/metrics.yaml telemetry/glean/pings.yaml
