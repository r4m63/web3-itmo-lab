.PHONY: download-deps

# ========== paths =========
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

# ========== deps =========
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

test_lib_urls = \
  https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.10.0/junit-platform-console-standalone-1.10.0.jar

download-deps:
	@echo "***** Downloading Dependencies *****"
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
	@echo "***** Downloading Successful *****"
