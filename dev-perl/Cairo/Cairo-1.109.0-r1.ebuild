# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=XAOC
DIST_VERSION=1.109
DIST_EXAMPLES=("examples/*")
inherit perl-module

DESCRIPTION="Perl interface to the cairo library"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~arm64 ~hppa ~mips ppc ppc64 ~riscv sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x64-solaris"

RDEPEND="
	>=x11-libs/cairo-1.0.0
"
DEPEND="
	>=x11-libs/cairo-1.0.0
"
BDEPEND="
	${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	>=dev-perl/ExtUtils-Depends-0.200.0
	>=dev-perl/ExtUtils-PkgConfig-1.0.0
	test? (
		dev-perl/Test-Number-Delta
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-1.107-fatal-exit.patch"
	"${FILESDIR}/${PN}-1.109.0-c99.patch"
)
