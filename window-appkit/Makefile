BUILD_DIR = build

compile: main.swift | $(BUILD_DIR)
	swiftc main.swift -o $(BUILD_DIR)/main

$(BUILD_DIR):
	mkdir -p $@

clean:
	rm -r $(BUILD_DIR)

run:
	./build/main
