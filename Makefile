# ========== paths =========
src_main_java := src/main/java
# ========== environment =========
java_version := 17
java_home := /Users/ramiltadzheddinov/Library/Java/JavaVirtualMachines/corretto-17.0.14/Contents/Home
javac_executable := $(java_home)/bin/javac

docker_home := /usr/local/bin/docker
wildfly_home := /opt/wildfly-36.0.0.Final
wildfly_deployment := $(wildfly_home)/standalone/deployments

# ========== paths =========
src_main_java := src/main/java
src_main_resources := src/main/resources
src_main_webapp := src/main/webapp

src_test_java := src/test/java
src_test_resources := src/test/resources

lib := lib

dir_build := ant/build
dir_build_classes := $(dir_build)/classes
dir_build_resources := $(dir_build)/resources
dir_build_test_reports := $(dir_build)/test-reports

file_war := $(dir_build)/lab3.war

# ========== alternatives =========
dir_build_alt := $(dir_build)/alt
dir_build_alt_src := $(dir_build_alt)/src
dir_build_alt_web := $(dir_build_alt)/web
dir_build_alt_classes := $(dir_build_alt)/classes
dir_build_alt_lib := $(dir_build_alt)/lib
file_alt_war := $(dir_build_alt)/alt-lab3.war
replace_regex_oldName := AreaBean
replace_regex_newName := AltAreaBean

# ========== project =========
name_project := lab3
name_project_bin := lab3.war

# ========== resources =========
file_music := music/mc.ogg
diff_critical_classes := server/DatabaseManager.java

# ========== tests =========
junit_version := 5.10.0
junit_platform_version := 1.10.0


# ========== dependencies =========
deps = \
  https://repo1.maven.org/maven2/jakarta/platform/jakarta.jakartaee-web-api/9.0.0/jakarta.jakartaee-web-api-9.0.0.jar \
  https://repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.13.0/antlr4-runtime-4.13.0.jar \
  https://repo1.maven.org/maven2/org/primefaces/primefaces/14.0.6/primefaces-14.0.6-jakarta.jar \
  https://repo1.maven.org/maven2/org/primefaces/themes/all-themes/1.1.0/all-themes-1.1.0.jar \
  https://repo1.maven.org/maven2/org/webjars/npm/primeflex/3.3.1/primeflex-3.3.1.jar \
  https://repo1.maven.org/maven2/org/webjars/npm/primeicons/7.0.0/primeicons-7.0.0.jar \
  https://repo1.maven.org/maven2/org/hibernate/orm/hibernate-core/6.6.1.Final/hibernate-core-6.6.1.Final.jar \
  https://repo1.maven.org/maven2/org/jboss/logging/jboss-logging/3.5.3.Final/jboss-logging-3.5.3.Final.jar \
  https://repo1.maven.org/maven2/jakarta/persistence/jakarta.persistence-api/3.1.0/jakarta.persistence-api-3.1.0.jar \
  https://repo1.maven.org/maven2/org/hibernate/common/hibernate-commons-annotations/6.0.6.Final/hibernate-commons-annotations-6.0.6.Final.jar \
  https://repo1.maven.org/maven2/net/bytebuddy/byte-buddy/1.14.11/byte-buddy-1.14.11.jar \
  https://repo1.maven.org/maven2/org/jboss/spec/javax/transaction/jboss-transaction-api_1.3_spec/2.0.0.Final/jboss-transaction-api_1.3_spec-2.0.0.Final.jar \
  https://repo1.maven.org/maven2/com/fasterxml/classmate/1.5.1/classmate-1.5.1.jar \
  https://repo1.maven.org/maven2/org/postgresql/postgresql/42.7.4/postgresql-42.7.4.jar \
  https://repo1.maven.org/maven2/ch/qos/logback/logback-classic/1.3.12/logback-classic-1.3.12.jar \
  https://repo1.maven.org/maven2/ch/qos/logback/logback-core/1.3.12/logback-core-1.3.12.jar \
  https://repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.9/slf4j-api-2.0.9.jar \
  https://repo1.maven.org/maven2/org/projectlombok/lombok/1.18.34/lombok-1.18.34.jar \
  https://repo1.maven.org/maven2/org/apiguardian/apiguardian-api/1.1.2/apiguardian-api-1.1.2.jar \
  https://repo1.maven.org/maven2/com/jcraft/jsch/0.1.54/jsch-0.1.54.jar \
  https://repo1.maven.org/maven2/org/apache/ant/ant-jsch/1.10.14/ant-jsch-1.10.14.jar \
  https://repo1.maven.org/maven2/org/slf4j/slf4j-simple/2.0.9/slf4j-simple-2.0.9.jar


# ========== rules =========

.PHONY: download-deps
download-deps:
	@printf "\033[1;32m***** Downloading Dependencies *****\033[0m\n"
	@mkdir -p $(lib)/temp
	@for url in $(deps); do \
	  echo "Downloading: $$url"; \
	  curl -L --retry 3 --fail -O -J -s "$$url" --output-dir $(lib)/temp; \
	done
	@cp $(lib)/temp/* $(lib)/
	@rm -rf $(lib)/temp
	@printf "\033[1;32m***** Downloading Successful *****\033[0m\n"


.PHONY: compile
CLASSPATH := $(shell find $(lib) -name "*.jar" | tr '\n' ':')
compile:
	@printf "\033[1;32m***** Compiling Java Sources *****\033[0m\n"
	@mkdir -p "$(dir_build_classes)"

	$(javac_executable) -source $(java_version) -target $(java_version) \
		-encoding UTF-8 \
		-parameters \
		-Xlint:unchecked -Xlint:deprecation \
		-g \
		-classpath "$(CLASSPATH)" \
		-d "$(dir_build_classes)" \
		$$(find $(src_main_java) -type f -name '*.java')

	@printf "\033[1;32mЭто ничего страшного, предупреждение по поводу deprecated, можно смело игнорировать\033[0m\n"
	@echo "Copying resources..."
	@if [ -d "$(src_main_resources)" ]; then \
		find "$(src_main_resources)" -type f ! -name '*.java' | while read -r file; do \
			rel_path="$${file#$(src_main_resources)/}"; \
			target_dir="$(dir_build_classes)/$$(dirname "$$rel_path")"; \
			mkdir -p "$$target_dir"; \
			cp "$$file" "$$target_dir/"; \
		done; \
	else \
		echo "Resources directory not found: $(src_main_resources)"; \
	fi

	@echo "Creating MANIFEST.MF..."
	@mkdir -p "$(dir_build)/META-INF"
	@echo "Manifest-Version: 1.0.0" > "$(dir_build)/META-INF/MANIFEST.MF"
	@echo "Implementation-Version: 1.0.0" >> "$(dir_build)/META-INF/MANIFEST.MF"
	@printf "\033[1;32m***** Compiling Successful *****\033[0m\n"

.PHONY: build

WEBAPP_DIR := $(src_main_webapp)
WEB_XML := $(WEBAPP_DIR)/WEB-INF/web.xml
TMP_WAR_DIR := $(dir_build)/war_temp

build: compile
	@printf "\033[1;32m***** Building WAR: $(file_war) *****\033[0m\n"
	@mkdir -p "$(dir_build)"
	@mkdir -p "$(TMP_WAR_DIR)"

	@if [ -d "$(WEBAPP_DIR)" ]; then \
		echo "Copying webapp resources..."; \
		find "$(WEBAPP_DIR)" -type f ! -path "$(WEBAPP_DIR)/WEB-INF/web.xml" | while read -r file; do \
			rel_path="$${file#$(WEBAPP_DIR)/}"; \
			target_dir="$(TMP_WAR_DIR)/$$(dirname "$$rel_path")"; \
			mkdir -p "$$target_dir"; \
			cp "$$file" "$$target_dir/"; \
		done; \
	else \
		echo "Warning: Webapp directory not found: $(WEBAPP_DIR)"; \
	fi

	@if [ -f "$(WEB_XML)" ]; then \
		echo "Copying web.xml..."; \
		mkdir -p "$(TMP_WAR_DIR)/WEB-INF"; \
		cp "$(WEB_XML)" "$(TMP_WAR_DIR)/WEB-INF/"; \
	else \
		echo "Warning: web.xml not found at $(WEB_XML)"; \
	fi

	@if [ -d "$(lib)" ]; then \
		echo "Copying libraries..."; \
		mkdir -p "$(TMP_WAR_DIR)/WEB-INF/lib"; \
		find "$(lib)" -type f -name "*.jar" ! -name "*.properties" -exec cp {} "$(TMP_WAR_DIR)/WEB-INF/lib/" \;; \
	else \
		echo "Warning: Lib directory not found: $(lib)"; \
	fi

	@if [ -d "$(dir_build_classes)" ]; then \
		echo "Copying classes..."; \
		mkdir -p "$(TMP_WAR_DIR)/WEB-INF/classes"; \
		find "$(dir_build_classes)" -type f ! -name "package-info.class" | while read -r file; do \
			rel_path="$${file#$(dir_build_classes)/}"; \
			target_dir="$(TMP_WAR_DIR)/WEB-INF/classes/$$(dirname "$$rel_path")"; \
			mkdir -p "$$target_dir"; \
			cp "$$file" "$$target_dir/"; \
		done; \
	else \
		echo "Error: Classes directory not found: $(dir_build_classes)"; \
		exit 1; \
	fi

	@if [ -d "$(dir_build_classes)/META-INF" ]; then \
		echo "Copying META-INF..."; \
		cp -R "$(dir_build_classes)/META-INF" "$(TMP_WAR_DIR)/"; \
	fi

	@echo "Creating WAR file..."
	@(cd "$(TMP_WAR_DIR)" && zip -qr "$(abspath $(file_war))" .)
	@rm -rf "$(TMP_WAR_DIR)"
	@echo "Successfully created WAR file at $(file_war)"

	@$(MAKE) music
	@printf "\033[1;32m***** Building Successfully *****\033[0m\n"




.PHONY: clean

clean:
	@printf "\033[1;32m***** Cleaning build directories *****\033[0m\n"
	@if [ -d "ant" ]; then \
		echo "Removing ant/ directory..."; \
		rm -rf ant; \
	else \
		echo "ant/ directory does not exist - nothing to remove"; \
	fi

	@if [ -d "lib" ]; then \
		echo "Removing lib/ directory..."; \
		rm -rf lib; \
	else \
		echo "lib/ directory does not exist - nothing to remove"; \
	fi

	@printf "\033[1;32m***** Clean complete *****\033[0m\n"

.PHONY: music

# Определяем ОС
UNAME_S := $(shell uname -s)

music:
	@echo "Playing build complete music..."
ifeq ($(UNAME_S),Darwin)
	@# macOS версия
	@if [ -f "$(file_music)" ]; then \
		afplay "$(file_music)" & \
		echo "Playing $(file_music) using afplay"; \
	else \
		echo "Music file not found: $(file_music)"; \
	fi
else ifeq ($(OS),Windows_NT)
	@# Windows версия
	@if exist "$(subst /,\,$(file_music))" ( \
		cmd /c start /B "$(subst /,\,$(file_music))" & \
		echo Playing $(subst /,\,$(file_music)) \
	) else ( \
		echo Music file not found: $(subst /,\,$(file_music)) \
	)
else
	@echo "Music playback not supported on this OS"
endif



.PHONY: doc

doc:
	@printf "\033[1;32m***** Starting documentation *****\033[0m\n"

	@if [ ! -f "$(file_war)" ]; then \
		echo "Error: WAR file not found at $(file_war)"; \
		exit 1; \
	fi

	@echo "Generating MD5 checksum..."
	@if command -v md5sum >/dev/null; then \
		war_md5=$$(md5sum "$(file_war)" | awk '{print $$1}'); \
	elif command -v md5 >/dev/null; then \
		war_md5=$$(md5 -q "$(file_war)"); \
	else \
		echo "Error: Neither md5sum nor md5 command found"; \
		exit 1; \
	fi; \
	echo "MD5: $${war_md5}"

	@echo "Generating SHA-1 checksum..."
	@if command -v sha1sum >/dev/null; then \
		war_sha1=$$(sha1sum "$(file_war)" | awk '{print $$1}'); \
	elif command -v shasum >/dev/null; then \
		war_sha1=$$(shasum -a 1 "$(file_war)" | awk '{print $$1}'); \
	else \
		echo "Error: Neither sha1sum nor shasum command found"; \
		exit 1; \
	fi; \
	echo "SHA-1: $${war_sha1}"

	@echo "Creating MANIFEST.MF with checksums..."
	@mkdir -p "$(dir_build)/META-INF"
	@echo "Manifest-Version: 1.0.0" > "$(dir_build)/META-INF/MANIFEST.MF"
	@echo "Implementation-Version: 1.0.0" >> "$(dir_build)/META-INF/MANIFEST.MF"
	@echo "MD5: $${war_md5}" >> "$(dir_build)/META-INF/MANIFEST.MF"
	@echo "SHA-1: $${war_sha1}" >> "$(dir_build)/META-INF/MANIFEST.MF"

	@echo "Updating WAR file with MANIFEST.MF..."
	@(cd "$(dir_build)/META-INF" && zip -qr "$(abspath $(file_war))" MANIFEST.MF)

	@echo "Generating Javadoc..."
	@mkdir -p "$(dir_build)/javadoc"
	@if [ -d "$(src_main_java)" ]; then \
		find "$(src_main_java)" -name "*.java" > "$(dir_build)/javadoc_sources.txt"; \
		if [ -s "$(dir_build)/javadoc_sources.txt" ]; then \
			$(java_home)/bin/javadoc \
				-d "$(dir_build)/javadoc" \
				-classpath "$(CLASSPATH)" \
				-use \
				-author \
				-version \
				-doctitle "Lab3 API" \
				-quiet \
				@"$(dir_build)/javadoc_sources.txt"; \
		else \
			echo "Error: No Java source files found in $(src_main_java)"; \
			exit 1; \
		fi; \
		rm -f "$(dir_build)/javadoc_sources.txt"; \
	else \
		echo "Error: Java source directory not found at $(src_main_java)"; \
		exit 1; \
	fi

	@if [ -d "$(dir_build)/javadoc" ]; then \
		echo "Adding Javadoc to WAR file..."; \
		(cd "$(dir_build)/javadoc" && zip -qr "$(abspath $(file_war))" .); \
	else \
		echo "Error: Javadoc directory not created"; \
		exit 1; \
	fi

	@printf "\033[1;32m***** Documentation tasks completed successfully *****\033[0m\n"

