set -e
TARGET=~/rustyv8bins/
TRIPLET=x86_64-unknown-linux-gnu

build() {
	cp target/${BUILD_TYPE}/gn_out/src_binding.rs target/src_binding_ptrcomp_sandbox_${BUILD_TYPE}_${TRIPLET}.rs
	mv target/src_binding_ptrcomp_sandbox_${BUILD_TYPE}_${TRIPLET}.rs ${TARGET}
	gzip -9c target/${BUILD_TYPE}/gn_out/obj/librusty_v8.a > target/librusty_v8_ptrcomp_sandbox_${BUILD_TYPE}_${TRIPLET}.a.gz
	mv target/librusty_v8_ptrcomp_sandbox_${BUILD_TYPE}_${TRIPLET}.a.gz ${TARGET}
}

BUILD_TYPE=release
RUST_BACKTRACE=1 V8_FROM_SOURCE=1 cargo build --release --features v8_enable_sandbox -vvv
build

BUILD_TYPE=debug
rm -rf target
RUST_BACKTRACE=1 V8_FROM_SOURCE=1 cargo build --features v8_enable_sandbox -vvv
build
