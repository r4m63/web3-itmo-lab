src_main_java = src/main/java
java_version = 17
java_home = /Users/ramiltadzheddinov/Library/Java/JavaVirtualMachines/corretto-17.0.14/Contents/Home
javac_executable = $(java_home)/bin/javac
docker_home = /usr/local/bin/docker
docker_compose_home = /usr/local/bin/docker-compose
wildfly_home = /opt/wildfly-36.0.0.Final
wildfly_deployment = $(wildfly_home)/standalone/deployments
project_name = lab3
war_file = gnu/build/lab3.war
src_main_java = src/main/java
src_main_resources = src/main/resources
src_main_webapp = src/main/webapp
src_test_java = src/test/java
src_test_resources = src/test/resources
lib = lib
dir_build = gnu/build
dir_build_classes = $(dir_build)/classes
dir_build_resources = $(dir_build)/resources
dir_build_test_reports = $(dir_build)/test-reports
dir_build_test_classes = $(dir_build)/test-classes
native_output_dir = $(dir_build_resources)/resources-native
file_war = $(dir_build)/lab3.war
dir_build_alt = $(dir_build)/alt
dir_build_alt_src = $(dir_build_alt)/src
dir_build_alt_web = $(dir_build_alt)/web
dir_build_alt_classes = $(dir_build_alt)/classes
dir_build_alt_lib = $(dir_build_alt)/lib
file_alt_war = $(dir_build_alt)/alt-lab3.war
replace_regex_oldName = AreaBean
replace_regex_newName = AltAreaBean
name_project = lab3
name_project_bin = lab3.war
file_music = music/mc.ogg
diff_critical_classes = server/DatabaseManager.java
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
  https://repo1.maven.org/maven2/org/slf4j/slf4j-simple/2.0.9/slf4j-simple-2.0.9.jar \
  https://repo1.maven.org/maven2/jakarta/annotation/jakarta.annotation-api/2.1.0/jakarta.annotation-api-2.1.0.jar
junit_version = 5.10.0
junit_platform_version = 1.10.0
test_libs = junit-platform-console-standalone-$(junit_platform_version).jar
test_lib_urls = \
  https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/$(junit_platform_version)/junit-platform-console-standalone-$(junit_platform_version).jar

test_classpath = $(addprefix $(lib)/,$(test_libs)):$(dir_build_classes):$(dir_build_test_classes)

.PHONY: all download-deps scp

download-deps:
	@printf "\033[1;32m***** Downloading Dependencies *****\033[0m\n"
	@mkdir -p $(LIB)/temp
	@for url in $(DEPS); do \
	  echo "Downloading: $$url"; \
	  curl -L --retry 3 --fail -O -J -s "$$url" --output-dir $(LIB)/temp; \
	done
	@cp $(LIB)/temp/* $(LIB)/
	@rm -rf $(LIB)/temp

	@mkdir -p $(LIB)/temp
	@for url in $(TEST_LIB_URLS); do \
	  echo "Downloading: $$url"; \
	  curl -L --retry 3 --fail -s -o $(LIB)/temp/$$(basename $$url) "$$url"; \
	done
	@cp $(LIB)/temp/* $(LIB)/
	@rm -rf $(LIB)/temp

	@printf "\033[1;32m***** Downloading Successful *****\033[0m\n"

scp:
	@echo "Deploying lab3.war to $(REMOTE_HOST)..."
	scp $(WAR_FILE) $(REMOTE_USER)@$(REMOTE_HOST):$(REMOTE_DIR)
	@echo "Deployment complete."


native2ascii:
	@echo "Converting localization files with native2ascii..."
	rm -rf $(NATIVE_OUTPUT_DIR)
	mkdir -p $(NATIVE_OUTPUT_DIR)
	find $(SRC_MAIN_RESOURCES) -name '*.properties' | while read file; do \
		rel_path=$$(realpath --relative-to=$(SRC_MAIN_RESOURCES) $$file); \
		dest_file=$(NATIVE_OUTPUT_DIR)/$$rel_path; \
		mkdir -p $$(dirname $$dest_file); \
		native2ascii -encoding ISO-8859-1 "$$file" "$$dest_file"; \
	done
	@echo "Copying converted properties to $(DIR_BUILD_CLASSES)..."
	rsync -a --include='*.properties' --exclude='*' $(NATIVE_OUTPUT_DIR)/ $(DIR_BUILD_CLASSES)/
	@echo "Done."

build_success := false
max_attempts := 2
history_file := $(DIR_BUILD)/history_diff.txt

history:
	@echo "Starting historical build search..."
	@mkdir -p $(DIR_BUILD)
	@rm -f $(history_file)
	@touch $(history_file)
	@build_success=false; \
	for attempt in `seq 1 $(max_attempts)`; do \
		if [ "$$build_success" = "false" ]; then \
			echo "Attempt $$attempt: Trying to compile..."; \
			if ! $(MAKE) compile; then \
				echo "Compilation failed in attempt $$attempt"; \
				echo "Resetting to previous commit..."; \
				git reset --hard HEAD~1; \
			else \
				build_success=true; \
				echo "Successful build found!"; \
				current_revision=`git rev-parse HEAD`; \
				git show "$$current_revision~1..$$current_revision" > $(history_file); \
				echo "Diff saved to $(history_file)"; \
			fi; \
		else \
			echo "Build already succeeded - skipping remaining attempts"; \
		fi; \
	done; \
	if [ "$$build_success" = "false" ]; then \
		echo "No working revisions found in $(max_attempts) attempts!"; \
		echo "Project cannot be compiled in any recent revision"; \
	fi


DIFF_CRITICAL_CLASSES = server/DatabaseManager.java

diff:
	@printf "\033[1;34m***** Checking git changes *****\033[0m\n"
	@changed_files=$$(git diff --name-only HEAD | grep -v '.DS_Store'); \
	echo "Changed files (excluding .DS_Store):"; \
	echo "$$changed_files" | sed 's/^/  /'; \
	critical_changes="false"; \
	if [ -n "$$changed_files" ]; then \
		for critical_class in $(DIFF_CRITICAL_CLASSES); do \
			if echo "$$changed_files" | grep -q "$$critical_class"; then \
				printf "\033[1;31mChanges affect critical class: $$critical_class. Commit skipped.\033[0m\n"; \
				critical_changes="true"; \
				break; \
			fi; \
		done; \
	fi; \
	if [ "$$critical_changes" = "false" ]; then \
		if [ -n "$$changed_files" ]; then \
			printf "\033[1;32mNo critical changes detected. Performing commit...\033[0m\n"; \
			commit_time=$$(date "+%Y-%m-%d %H:%M:%S"); \
			if ! git commit -a -m "Auto-commit at $$commit_time"; then \
				printf "\033[1;31mCommit failed\033[0m\n"; \
				exit 1; \
			fi; \
		else \
			printf "\033[1;33mNo changes to commit (after filtering .DS_Store).\033[0m\n"; \
		fi; \
	else \
		printf "\033[1;35mSkipping commit due to critical changes.\033[0m\n"; \
	fi
	@printf "\033[1;34m***** Check completed *****\033[0m\n"

env:
	@printf "\033[1;32m***** Setting up environment (WildFly + PostgreSQL) *****\033[0m\n"
	@if ! command -v docker >/dev/null; then \
		printf "\033[1;31mError: Docker not found at $(DOCKER)\033[0m\n"; \
		exit 1; \
	fi
	@printf "\033[1;34mStopping any running containers...\033[0m\n"
	@$(DOCKER_COMPOSE) down || true
	@printf "\033[1;34mStarting PostgreSQL...\033[0m\n"
	@$(DOCKER_COMPOSE) up -d
	@printf "\033[1;34mChecking PostgreSQL status...\033[0m\n"
	@if ! $(DOCKER) inspect -f '{{.State.Running}}' lab3-postgres | grep -q "true"; then \
		printf "\033[1;31mError: PostgreSQL container is not running\033[0m\n"; \
		exit 1; \
	fi
	@printf "\033[1;34mChecking WildFly installation...\033[0m\n"
	@if [ ! -d "$(WILDFLY_HOME)" ]; then \
		printf "\033[1;31mError: WildFly not found at $(WILDFLY_HOME)\033[0m\n"; \
		exit 1; \
	fi
	@printf "\033[1;34mStopping WildFly if running...\033[0m\n"
	@if [ -f "$(WILDFLY_HOME)/bin/jboss-cli.sh" ]; then \
		"$(WILDFLY_HOME)/bin/jboss-cli.sh" --connect command=:shutdown || true; \
		sleep 3; \
	fi
	@printf "\033[1;34mDeploying $(NAME_PROJECT_BIN) to WildFly...\033[0m\n"
	@mkdir -p "$(WILDFLY_DEPLOYMENT)"
	@cp "$(WAR_FILE)" "$(WILDFLY_DEPLOYMENT)/$(NAME_PROJECT_BIN)"
	@printf "\033[1;34mStarting WildFly...\033[0m\n"
	@JAVA_HOME="$(JAVA_HOME)" "$(WILDFLY_HOME)/bin/standalone.sh" -b 0.0.0.0 &
	@printf "\033[1;34mWaiting for WildFly to start (max 30 seconds)...\033[0m\n"
	@timeout=30; \
	while ! curl -s -f -o /dev/null "http://localhost:8080/"; do \
		if [ $$timeout -le 0 ]; then \
			printf "\033[1;31mError: WildFly failed to start\033[0m\n"; \
			exit 1; \
		fi; \
		sleep 1; \
		timeout=$$((timeout-1)); \
	done
	@printf "\033[1;34mOpening application in browser...\033[0m\n"
	@open "http://localhost:8080/$(NAME_PROJECT)"
	@printf "\033[1;32m***** Environment setup completed successfully *****\033[0m\n"



