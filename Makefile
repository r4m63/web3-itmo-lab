# ========== paths =========
src_main_java := src/main/java
# ========== environment =========
java_version := 17
java_home := /Users/ramiltadzheddinov/Library/Java/JavaVirtualMachines/corretto-17.0.14/Contents/Home
javac_executable := $(java_home)/bin/javac

docker_home := /usr/local/bin/docker
docker_compose_home := /usr/local/bin/docker-compose
wildfly_home := /opt/wildfly-36.0.0.Final
wildfly_deployment := $(wildfly_home)/standalone/deployments
project_name := lab3
war_file := gnu/build/lab3.war

# ========== paths =========
src_main_java := src/main/java
src_main_resources := src/main/resources
src_main_webapp := src/main/webapp

src_test_java := src/test/java
src_test_resources := src/test/resources

lib := lib

dir_build := gnu/build
dir_build_classes := $(dir_build)/classes
dir_build_resources := $(dir_build)/resources
dir_build_test_reports := $(dir_build)/test-reports
dir_build_test_classes := $(dir_build)/test-classes
native_output_dir := $(dir_build_resources)/resources-native



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
  https://repo1.maven.org/maven2/org/slf4j/slf4j-simple/2.0.9/slf4j-simple-2.0.9.jar \
  https://repo1.maven.org/maven2/jakarta/annotation/jakarta.annotation-api/2.1.0/jakarta.annotation-api-2.1.0.jar

#test_lib_urls := \
#  https://repo1.maven.org/maven2/org/junit/jupiter/junit-jupiter-api/$(junit_version)/junit-jupiter-api-$(junit_version).jar \
#  https://repo1.maven.org/maven2/org/junit/jupiter/junit-jupiter-engine/$(junit_version)/junit-jupiter-engine-$(junit_version).jar \
#  https://repo1.maven.org/maven2/org/junit/platform/junit-platform-commons/$(junit_platform_version)/junit-platform-commons-$(junit_platform_version).jar \
#  https://repo1.maven.org/maven2/org/junit/platform/junit-platform-engine/$(junit_platform_version)/junit-platform-engine-$(junit_platform_version).jar \
#  https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/$(junit_platform_version)/junit-platform-console-standalone-$(junit_platform_version).jar \
#  https://repo1.maven.org/maven2/org/apiguardian/apiguardian-api/1.1.2/apiguardian-api-1.1.2.jar \
#  https://repo1.maven.org/maven2/org/opentest4j/opentest4j/1.2.0/opentest4j-1.2.0.jar

# ========== tests =========
junit_version := 5.10.0
junit_platform_version := 1.10.0

# ========== зависимости тестов ==========
test_libs := junit-platform-console-standalone-$(junit_platform_version).jar
test_lib_urls := \
  https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/$(junit_platform_version)/junit-platform-console-standalone-$(junit_platform_version).jar

# ========== classpath ==========
test_classpath := $(addprefix $(lib)/,$(test_libs)):$(dir_build_classes):$(dir_build_test_classes)


.PHONY: deploy

REMOTE_USER := NAME
REMOTE_HOST := HOST
REMOTE_DIR  := /path/on/server

deploy:
	@echo "Deploying lab3.war to $(REMOTE_HOST)..."
	scp gnu/build/lab3.war $(REMOTE_USER)@$(REMOTE_HOST):$(REMOTE_DIR)
	@echo "Deployment complete."



.PHONY: native2ascii

native2ascii:
	@echo "Converting localization files with native2ascii..."

	# Удалить старую директорию
	rm -rf $(native_output_dir)

	# Создать новую директорию
	mkdir -p $(native_output_dir)

	# Конвертировать все .properties файлы
	find $(src_main_resources) -name '*.properties' | while read file; do \
		rel_path=$$(realpath --relative-to=$(src_main_resources) $$file); \
		dest_file=$(native_output_dir)/$$rel_path; \
		mkdir -p $$(dirname $$dest_file); \
		native2ascii -encoding ISO-8859-1 "$$file" "$$dest_file"; \
	done

	# Копировать конвертированные .properties в classes
	@echo "Copying converted properties to $(dir_build_classes)..."
	rsync -a --include='*.properties' --exclude='*' $(native_output_dir)/ $(dir_build_classes)/

	@echo "Done."




.PHONY: history

build_success := false
max_attempts := 2
history_file := $(dir_build)/history_diff.txt

history:
	@echo "Starting historical build search..."
	@mkdir -p $(dir_build)
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








.PHONY: diff

diff_critical_classes := server/DatabaseManager.java

diff:
	@printf "\033[1;34m***** Checking git changes *****\033[0m\n"

	@changed_files=$$(git diff --name-only HEAD | grep -v '.DS_Store'); \
	echo "Changed files (excluding .DS_Store):"; \
	echo "$$changed_files" | sed 's/^/  /';

	@critical_changes="false"; \
	if [ -n "$$changed_files" ]; then \
		for critical_class in $(diff_critical_classes); do \
			if echo "$$changed_files" | grep -q "$$critical_class"; then \
				printf "\033[1;31mChanges affect critical class: $$critical_class. Commit skipped.\033[0m\n"; \
				critical_changes="true"; \
				break; \
			fi; \
		done; \
	fi; \

	@if [ "$$critical_changes" = "false" ]; then \
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


.PHONY: env

env:
	@printf "\033[1;32m***** Setting up environment (WildFly + PostgreSQL) *****\033[0m\n"

	# 1. Проверка Docker
	@if ! command -v docker >/dev/null; then \
		printf "\033[1;31mError: Docker not found at $(docker_home)\033[0m\n"; \
		exit 1; \
	fi

	# 2. Остановка существующих контейнеров
	@printf "\033[1;34mStopping any running containers...\033[0m\n"
	@docker-compose down || true

	# 3. Запуск PostgreSQL
	@printf "\033[1;34mStarting PostgreSQL...\033[0m\n"
	@docker-compose up -d

	# 4. Проверка работы PostgreSQL
	@printf "\033[1;34mChecking PostgreSQL status...\033[0m\n"
	@if ! docker inspect -f '{{.State.Running}}' lab3-postgres | grep -q "true"; then \
		printf "\033[1;31mError: PostgreSQL container is not running\033[0m\n"; \
		exit 1; \
	fi

	# 5. Проверка WildFly
	@printf "\033[1;34mChecking WildFly installation...\033[0m\n"
	@if [ ! -d "$(wildfly_home)" ]; then \
		printf "\033[1;31mError: WildFly not found at $(wildfly_home)\033[0m\n"; \
		exit 1; \
	fi

	# 6. Остановка WildFly если работает
	@printf "\033[1;34mStopping WildFly if running...\033[0m\n"
	@if [ -f "$(wildfly_home)/bin/jboss-cli.sh" ]; then \
		"$(wildfly_home)/bin/jboss-cli.sh" --connect command=:shutdown || true; \
		sleep 3; \
	fi

	# 7. Деплой WAR-файла
	@printf "\033[1;34mDeploying $(name_project_bin) to WildFly...\033[0m\n"
	@mkdir -p "$(wildfly_deployment)"
	@cp "$(file_war)" "$(wildfly_deployment)/$(name_project_bin)"

	# 8. Запуск WildFly в фоновом режиме
	@printf "\033[1;34mStarting WildFly...\033[0m\n"
	@JAVA_HOME="$(java_home)" "$(wildfly_home)/bin/standalone.sh" -b 0.0.0.0 &

	# 9. Ожидание запуска WildFly (макс 30 секунд)
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

	# 10. Открытие приложения в браузере (macOS)
	@printf "\033[1;34mOpening application in browser...\033[0m\n"
	@open "http://localhost:8080/$(name_project)"

	@printf "\033[1;32m***** Environment setup completed successfully *****\033[0m\n"

.PHONY: env-stop

env-stop:
	@echo "Checking WildFly installation..."
	@if [ -d "$(wildfly_home)" ]; then \
		echo "Stopping WildFly server..."; \
		$(wildfly_home)/bin/jboss-cli.sh --connect command=:shutdown || true; \
		echo "WildFly server stopped"; \
	else \
		echo "WildFly not found at $(wildfly_home), skipping..."; \
	fi

	@echo "Checking Docker installation..."
	@if command -v docker-compose > /dev/null; then \
		echo "Stopping Docker containers..."; \
		docker-compose down || true; \
		echo "Docker containers stopped and removed"; \
	else \
		echo "Docker not found, skipping..."; \
	fi

	@echo "Killing any remaining WildFly standalone.sh processes..."
	@pkill -f standalone.sh || true




.PHONY: test


test:
	@echo "Preparing to run tests..."
	@mkdir -p $(dir_build_test_classes)
	@mkdir -p $(dir_build_test_reports)

	@echo "Compiling test classes..."
	@$(javac_executable) -d $(dir_build_test_classes) \
		--release 17 \
		-classpath "$(test_classpath):$(CLASSPATH)" \
		$$(find $(src_test_java) -type f -name "*.java") || { echo "Test compilation failed"; exit 1; }

	@if [ -z "$$(ls -A $(dir_build_test_classes))" ]; then \
		echo "Error: No test classes compiled"; \
		exit 1; \
	fi

	@echo "Running tests with JUnit ConsoleLauncher..."
	@$(java_home)/bin/java \
		-classpath "$(test_classpath):$(CLASSPATH):$(dir_build_test_classes):$(dir_build_classes)" \
		org.junit.platform.console.ConsoleLauncher \
		--class-path "$(dir_build_test_classes):$(dir_build_classes)" \
		--scan-class-path \
		--include-classname '.*Test' \
		--reports-dir "$(dir_build_test_reports)" \
		|| { echo "Some tests failed"; exit 1; }

	@echo "✅ Test execution completed. Reports are in $(dir_build_test_reports)"




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

	@mkdir -p $(lib)/temp
	@for url in $(test_lib_urls); do \
	  echo "Downloading: $$url"; \
	  curl -L --retry 3 --fail -s -o $(lib)/temp/$$(basename $$url) "$$url"; \
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

	@if [ -d "$(dir_build)" ]; then \
		echo "Removing $(dir_build)/ directory..."; \
		rm -rf "$(dir_build)"; \
		rm -rf "gnu/"; \
	fi

	# Удалим верхнюю директорию, если она пуста
	@if [ -d "$(dir_build)" ]; then \
		echo "Warning: $(dir_build)/ was not removed"; \
	elif [ -d "$(dir_build:%/build=%)" ]; then \
		dir_to_check="$(dir_build:%/build=%)"; \
		if [ -z "$$(ls -A "$$dir_to_check")" ]; then \
			echo "Removing empty directory $$dir_to_check..."; \
			rmdir "$$dir_to_check"; \
		fi; \
	fi

	@if [ -d "$(lib)" ]; then \
		echo "Removing $(lib)/ directory..."; \
		rm -rf "$(lib)"; \
	else \
		echo "$(lib)/ directory does not exist - nothing to remove"; \
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

	@echo "Generating checksums and writing MANIFEST.MF..."; \
	mkdir -p "$(dir_build)/META-INF"; \
	war_md5="$$( \
		if command -v md5sum >/dev/null; then \
			md5sum "$(file_war)" | awk '{print $$1}'; \
		elif command -v md5 >/dev/null; then \
			md5 -q "$(file_war)"; \
		else \
			echo "Error: Neither md5sum nor md5 found" >&2; \
			exit 1; \
		fi)"; \
	war_sha1="$$( \
		if command -v sha1sum >/dev/null; then \
			sha1sum "$(file_war)" | awk '{print $$1}'; \
		elif command -v shasum >/dev/null; then \
			shasum -a 1 "$(file_war)" | awk '{print $$1}'; \
		else \
			echo "Error: Neither sha1sum nor shasum found" >&2; \
			exit 1; \
		fi)"; \
	echo "MD5: $$war_md5"; \
	echo "SHA-1: $$war_sha1"; \
	{ \
		echo "Manifest-Version: 1.0.0"; \
		echo "Implementation-Version: 1.0.0"; \
		echo "MD5: $$war_md5"; \
		echo "SHA-1: $$war_sha1"; \
	} > "$(dir_build)/META-INF/MANIFEST.MF"


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

