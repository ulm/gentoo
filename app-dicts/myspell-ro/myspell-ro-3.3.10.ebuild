# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MYSPELL_DICT=(
	"ro_RO.aff"
	"ro_RO.dic"
)

MYSPELL_HYPH=(
	"hyph_ro_RO.dic"
)

MYSPELL_THES=(
	"th_ro_RO.dat"
	"th_ro_RO.idx"
)

inherit myspell-r2

DESCRIPTION="Romanian dictionaries for myspell/hunspell"
HOMEPAGE="https://rospell.wordpress.com"
SRC_URI="
	https://downloads.sourceforge.net/rospell/ro_RO.${PV}.zip
	https://downloads.sourceforge.net/rospell/hyph_ro_RO.${PV}.zip
	https://downloads.sourceforge.net/rospell/th_ro_RO.3.3.zip
"

LICENSE="GPL-2 LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~loong ~mips ppc ppc64 ~riscv sparc x86"
