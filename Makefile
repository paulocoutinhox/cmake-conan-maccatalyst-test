ROOT_DIR=${PWD}

.DEFAULT_GOAL := help
.PHONY: build conan

# tasks
help:
	@echo "Type: make [rule]. Available options are:"
	@echo ""
	@echo "- help"
	@echo "- clean"
	@echo ""
	@echo "- conan-catalyst"
	@echo "- conan-ios"
	@echo ""
	@echo "- build-catalyst"
	@echo "- build-catalyst-toolchain"
	@echo ""
	@echo "- build-ios"
	@echo "- build-ios-toolchain"

clean:
	@echo "Cleaning..."
	@rm -rf build
	@rm -rf .DS_Store
	@rm -rf *.pyc
	@rm -rf Thumbs.db
	@echo "OK"

conan-catalyst:
	mkdir -p build/conan

	cd build/conan && conan install ${ROOT_DIR} \
		-pr:b default \
		-pr:h ${ROOT_DIR}/conan/profiles/catalyst_profile \
		-s:h build_type=Release \
		-s:h arch=x86_64 \
		-o:h tools.apple:enable_arc=True \
		-o:h tools.apple:enable_bitcode=False \
		-o:h tools.apple:enable_visibility=False \
		-s:h os.subsystem.ios_version=13.1 \
		-s:h os.sdk=macosx \
		--build=missing \
		--update

build-catalyst:
	# clean
	@rm -rf build && mkdir build

	# conan
	@make conan-catalyst

	# cmake
	cmake -S . \
		-B build \
		-GXcode \
		-DCMAKE_TOOLCHAIN_FILE=build/conan/conan_toolchain.cmake

	cmake --build build --config Release

conan-ios:
	mkdir -p build/conan

	cd build/conan && conan install ${ROOT_DIR} \
		-pr:b default \
		-pr:h ${ROOT_DIR}/conan/profiles/ios_profile \
		-s:h build_type=Release \
		-o:h tools.apple:enable_arc=True \
		-o:h tools.apple:enable_bitcode=False \
		-o:h tools.apple:enable_visibility=False \
		--build=missing \
		--update

build-ios:
	# clean
	@rm -rf build && mkdir build

	# conan
	@make conan-ios

	# cmake
	cmake -S . \
		-B build \
		-GXcode \
		-DCMAKE_TOOLCHAIN_FILE=build/conan/conan_toolchain.cmake

	cmake --build build --config Release

build-ios-toolchain:
	# clean
	@rm -rf build && mkdir build

	# cmake
	cmake -S . \
		-B build \
		-GXcode \
		-DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake \
		-DPLATFORM=OS64

	cmake --build build --config Release

build-catalyst-toolchain:
	# clean
	@rm -rf build && mkdir build

	# cmake
	cmake -S . \
		-B build \
		-GXcode \
		-DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake \
		-DPLATFORM=MAC_CATALYST_ARM64

	cmake --build build --config Release
