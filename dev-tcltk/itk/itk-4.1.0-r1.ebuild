# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools virtualx

MY_PV=${PV/_beta/b}

DESCRIPTION="Object Oriented Enhancements for Tcl/Tk"
HOMEPAGE="http://incrtcl.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/project/incrtcl/%5Bincr%20Tcl_Tk%5D-4-source/itk%20${MY_PV}/${PN}${MY_PV}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="amd64 ~arm64 ppc ~riscv sparc x86 ~amd64-linux ~x86-linux"
RESTRICT="!test? ( test )"

DEPEND="
	>=dev-lang/tk-8.6:=
	>=dev-tcltk/itcl-4.1"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}${MY_PV}"

QA_CONFIG_IMPL_DECL_SKIP=(
	stat64 # used to test for Large File Support
)

src_prepare() {
	mv configure.{in,ac} || die
	AT_M4DIR=.. eautoconf
	sed 's:-pipe::g' -i configure || die
	default
}

src_configure() {
	local itcl_package=$(best_version dev-tcltk/itcl)
	local itcl_version=${itcl_package#*/*-}
	local ITCL_VERSION="${itcl_version%-*}"
	source "${EPREFIX}"/usr/$(get_libdir)/itcl${ITCL_VERSION}*/itclConfig.sh || die
	econf \
		--with-tcl="${EPREFIX}"/usr/$(get_libdir) \
		--with-tclinclude="${EPREFIX}"/usr/include \
		--with-tk="${EPREFIX}"/usr/$(get_libdir) \
		--with-tkinclude="${EPREFIX}"/usr/include \
		--with-itcl="${ITCL_SRC_DIR}" \
		--with-x
}

src_compile() {
	emake CFLAGS_DEFAULT="${CFLAGS}"
}

src_test() {
	virtx default
}

src_install() {
	default

	dodoc license.terms

	cat >> "${T}"/34${PN} <<- EOF
	LDPATH="${EPREFIX}/usr/$(get_libdir)/${PN}${MY_PV}/"
	EOF
	doenvd "${T}"/34${PN}
	dosym . /usr/$(get_libdir)/${PN}${MY_PV}/library
}
