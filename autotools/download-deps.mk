# Директории
LIB_DIR = $(top_srcdir)/lib
TEMP_DIR = $(LIB_DIR)/temp

# URL зависимостей
DEPS = \
    https://repo1.maven.org/maven2/jakarta/platform/jakarta.jakartaee-web-api/9.0.0/jakarta.jakartaee-web-api-9.0.0.jar \
    https://repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.13.0/antlr4-runtime-4.13.0.jar \
    https://repo1.maven.org/maven2/org/slf4j/slf4j-simple/2.0.9/slf4j-simple-2.0.9.jar

.PHONY: download-deps
download-deps:
	@echo "Downloading dependencies..."
	@mkdir -p $(TEMP_DIR)
	@for url in $(DEPS); do \
		echo "Fetching $$url..."; \
		wget -q -P $(TEMP_DIR) --timestamping $$url || exit 1; \
	done
	@cp -f $(TEMP_DIR)/*.jar $(LIB_DIR)/
	@rm -rf $(TEMP_DIR)
	@echo "Dependencies downloaded to $(LIB_DIR)"