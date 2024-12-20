# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1

EAPI=8

CRATES="
	adler@1.0.2
	anstream@0.3.2
	anstyle@1.0.1
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@1.0.1
	autocfg@1.1.0
	bitflags@1.3.2
	bitvec@1.0.1
	bytemuck@1.13.1
	byteorder@1.4.3
	cc@1.0.79
	cfg-if@1.0.0
	clap@4.3.8
	clap_builder@4.3.8
	clap_lex@0.5.0
	color_quant@1.1.0
	colorchoice@1.0.0
	crc32fast@1.3.2
	crossbeam-channel@0.5.8
	crossbeam-deque@0.8.3
	crossbeam-epoch@0.9.15
	crossbeam-utils@0.8.16
	either@1.8.1
	env_logger@0.10.0
	equivalent@1.0.0
	errno@0.3.1
	errno-dragonfly@0.1.2
	fdeflate@0.3.0
	filetime@0.2.21
	flate2@1.0.26
	funty@2.0.0
	glob@0.3.1
	hashbrown@0.14.0
	hermit-abi@0.2.6
	hermit-abi@0.3.1
	image@0.24.6
	indexmap@2.0.0
	io-lifetimes@1.0.11
	is-terminal@0.4.7
	libc@0.2.146
	libdeflate-sys@1.19.0
	libdeflater@1.19.0
	linux-raw-sys@0.3.8
	log@0.4.20
	memoffset@0.9.0
	miniz_oxide@0.7.1
	num-integer@0.1.45
	num-rational@0.4.1
	num-traits@0.2.15
	num_cpus@1.15.0
	png@0.17.9
	radium@0.7.0
	rayon@1.7.0
	rayon-core@1.11.0
	redox_syscall@0.2.16
	rgb@0.8.36
	rustc-hash@1.1.0
	rustc_version@0.4.0
	rustix@0.37.20
	scopeguard@1.1.0
	semver@1.0.17
	simd-adler32@0.3.7
	strsim@0.10.0
	tap@1.0.1
	termcolor@1.1.3
	terminal_size@0.2.6
	typed-arena@2.0.2
	utf8parse@0.2.1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.48.0
	windows-targets@0.48.0
	windows_aarch64_gnullvm@0.48.0
	windows_aarch64_msvc@0.48.0
	windows_i686_gnu@0.48.0
	windows_i686_msvc@0.48.0
	windows_x86_64_gnu@0.48.0
	windows_x86_64_gnullvm@0.48.0
	windows_x86_64_msvc@0.48.0
	wyz@0.5.1
	zopfli@0.8.0
"

inherit cargo

DESCRIPTION="Multithreaded lossless PNG compression optimizer written in Rust"
HOMEPAGE="https://github.com/shssoichiro/oxipng"
SRC_URI="https://github.com/shssoichiro/oxipng/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="
	Apache-2.0
	|| ( Apache-2.0 MIT )
	|| ( Apache-2.0 MIT ZLIB )
	MIT
	|| ( MIT Unlicense )
"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~riscv ~x86"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_install() {
	cargo_src_install

	dodoc CHANGELOG.md README.md
}
