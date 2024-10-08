# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Easily upload your wireshark captures to CloudShark"
HOMEPAGE="https://cloudshark.io/articles/wireshark-plugin/ https://github.com/cloudshark/wireshark-plugin"
SRC_URI="https://github.com/${PN}/wireshark-plugin/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="
	net-analyzer/wireshark:=[lua]
	net-misc/curl
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/wireshark-plugin-${PV}"

get_PV() {
	local pv=$(best_version $1)
	pv=${pv#$1-}; pv=${pv%-r*}
	pv=${pv//_}; echo ${pv}
}

src_prepare() {
	#cloudshark isn't meant to be installed systemwide, we fix that
	eapply "${FILESDIR}"/cs_log_dir.patch

	sed -i "s#%s/cloudshark_init.lua#/usr/$(get_libdir)/wireshark/plugins/$(get_PV net-analyzer/wireshark)/cloudshark_init.lua#" cloudshark.lua

	#this enables cloudshark by DEFAULT on tshark, not desired
	#sed -i 's#CLOUDSHARK_TSHARK = "n"#CLOUDSHARK_TSHARK = "y"#' cloudshark_init.default
	default
}

src_install() {
	insinto /usr/$(get_libdir)/wireshark/plugins/$(get_PV net-analyzer/wireshark)
	doins cloudshark.lua json.lua
	newins cloudshark_init.default cloudshark_init.lua
	dodoc README.md
}
