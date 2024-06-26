# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Three dimensional inductance computation program, Whiteley Research version"
HOMEPAGE="http://www.wrcad.com/freestuff.html"
SRC_URI="http://www.wrcad.com/ftp/pub/fasthenry-$(ver_cut 1-2)wr-$(ver_cut 4)$(ver_cut 5)$(ver_cut 3).tar.gz"

LICENSE="all-rights-reserved"
RESTRICT="mirror bindist"

SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND=""

S=${WORKDIR}/fasthenry-3.0wr

PATCHES=(
	"${FILESDIR}/${P}-cflags.patch"
	"${FILESDIR}/${P}-ldflags.patch"
	"${FILESDIR}/${P}-ar.patch"
)

src_compile() {
	# -Werror=lto-type-mismatch
	# https://bugs.gentoo.org/862450
	#
	# Upstream provides a contact email. I have sent an email describing the
	# bug. They responded to say it is now fixed and a new version will be
	# available shortly.
	filter-lto

	tc-export CC AR
	emake all
}

src_install() {
	dobin bin/fasthenry
	dobin bin/zbuf
	dodoc -r doc/*
	dodoc -r examples
}
