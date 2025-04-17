JAVAC = javac
JAVA_SRC = $(wildcard src/main/java/**/*.java)
LIB_DIR = lib
DEPS = $(LIB_DIR)/jakarta.jakartaee-web-api-9.0.0.jar

all: myapp.jar

myapp.jar: $(JAVA_SRC) $(DEPS)
	$(JAVAC) -source 17 -target 17 -d build -cp "$(LIB_DIR)/*" $(JAVA_SRC)
	jar cf $@ -C build .

$(LIB_DIR)/%.jar:
	mkdir -p $(LIB_DIR)
	wget -P $(LIB_DIR) https://repo1.maven.org/maven2/$*/$@

clean:
	rm -rf build myapp.jar