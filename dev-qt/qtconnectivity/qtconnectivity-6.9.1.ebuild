# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qt6-build

DESCRIPTION="Bluetooth and NFC support library for the Qt6 framework"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="amd64 arm arm64 ~loong ppc ppc64 ~riscv x86"
fi

IUSE="+bluetooth neard nfc smartcard"
REQUIRED_USE="
	|| ( bluetooth nfc )
	nfc? ( ?? ( neard smartcard ) )
"

DEPEND="
	~dev-qt/qtbase-${PV}:6
	bluetooth? (
		~dev-qt/qtbase-${PV}:6[dbus,network]
		net-wireless/bluez:=
	)
	nfc? (
		neard? ( ~dev-qt/qtbase-${PV}:6[dbus] )
		smartcard? ( sys-apps/pcsc-lite )
	)
"
RDEPEND="
	${DEPEND}
	nfc? (
		neard? ( net-wireless/neard )
	)
"

CMAKE_SKIP_TESTS=(
	# most hardware tests are auto-skipped, but some still misbehave
	# if bluez/hardware is available (generally tests here may not be
	# very relevant without hardware, lists may need to be extended)
	tst_qbluetoothdevicediscoveryagent #936485
	tst_qbluetoothlocaldevice
	tst_qbluetoothserver
	tst_qbluetoothservicediscoveryagent
	tst_qbluetoothserviceinfo
	tst_qlowenergycontroller
)

src_prepare() {
	qt6-build_src_prepare

	use bluetooth ||
		sed -i '/add_subdirectory(bluetooth)/d' src/CMakeLists.txt || die
	use nfc ||
		sed -i '/add_subdirectory(nfc)/d' src/CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		$(usev nfc "
			$(qt_feature neard)
			$(qt_feature smartcard pcsclite)
		")
	)

	qt6-build_src_configure
}

src_install() {
	qt6-build_src_install

	# broken (unnecessary) symlink due to add_app() being used over add_tool()
	use !bluetooth || rm -- "${ED}"/usr/bin/sdpscanner6 || die

	if use test; then
		local delete=( # sigh
			"${D}${QT6_BINDIR}"/bluetoothtestdevice
			"${D}${QT6_BINDIR}"/bttestui
			"${D}${QT6_BINDIR}"/qlecontroller-server
		)
		# using -f given not tracking which tests may be skipped or not
		rm -f -- "${delete[@]}" || die
	fi
}
