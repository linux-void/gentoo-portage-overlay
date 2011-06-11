# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

EGIT_HAS_SUBMODULES="true"

inherit git-2 eutils cmake-utils confutils

EGIT_REPO_URI="git://github.com/euroelessar/qutim.git"
CMAKE_USE_DIR="${S}/protocols"
EGIT_BRANCH="master"

EGIT_PROJECT="qutim"
DESCRIPTION="Jabber protocol plugin for net-im/qutim"
HOMEPAGE="http://www.qutim.org"

LICENSE="GPL-2"
SLOT="0.3-live"
KEYWORDS=""
IUSE="debug"

RDEPEND="net-im/qutim:${SLOT}
	>=x11-libs/qt-core-4.6.3
	sys-libs/zlib
	net-dns/libidn
	app-crypt/qca
	app-crypt/qca-cyrus-sasl"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6
	!x11-plugins/qutim-protocols:${SLOT}
	!app-crypt/qca-ossl"

RESTRICT="debug? ( strip )"

src_unpack() {
	git-2_src_unpack
}

src_prepare() {
	if (use debug) ; then
		unset CFLAGS CXXFLAGS
		append-flags -O1 -g -ggdb
		CMAKE_BUILD_TYPE="debug"
	fi
	mycmakeargs="-DQUTIM_ENABLE_ALL_PLUGINS=off -DJABBER=on"
	CMAKE_IN_SOURCE_BUILD=1
}

src_install() {
	cmake-utils_src_install
}
