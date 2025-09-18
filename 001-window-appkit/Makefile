BUILD_DIR = build

build: main.swift | make_dir
	swiftc main.swift -o $(BUILD_DIR)/main

make_dir:
	mkdir -p $(BUILD_DIR)

clean:
	rm -r $(BUILD_DIR)

run:
	./build/main