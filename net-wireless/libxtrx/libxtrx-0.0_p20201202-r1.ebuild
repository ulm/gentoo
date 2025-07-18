# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="High-level XTRX API library"
HOMEPAGE="https://github.com/xtrx-sdr/libxtrx"
LICENSE="LGPL-2.1"
SLOT="0/${PV}"

if [[ ${PV} =~ "9999" ]]; then
	EGIT_REPO_URI="https://github.com/xtrx-sdr/libxtrx.git"
	inherit git-r3
else
	COMMIT="acb0b1cf7ab92744034767a04c1d4b4c281b840f"
	SRC_URI="https://github.com/xtrx-sdr/libxtrx/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64 ~x86"
fi

RDEPEND="
		net-wireless/libxtrxll:=
		net-wireless/libxtrxdsp:=
		net-wireless/liblms7002m:=
"
#		soapy? ( net-wireless/soapysdr )
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-cmake4.patch )

src_configure() {
	#fails to build, not sure why
	#-DENABLE_SOAPY="$(usex soapy ON OFF)"
	local mycmakeargs=(
		-DENABLE_SOAPY=OFF
	)
	cmake_src_configure
}
