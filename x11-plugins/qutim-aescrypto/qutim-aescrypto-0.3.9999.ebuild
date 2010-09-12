# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git eutils qt4-r2 cmake-utils

EGIT_REPO_URI="git://gitorious.org/qutim/plugins.git"
EGIT_BRANCH="master"
EGIT_COMMIT="${EGIT_BRANCH}"
EGIT_PROJECT="qutim-plugins"
DESCRIPTION="Aescrypto plugin for net-im/qutim"
HOMEPAGE="http://www.qutim.org"

LICENSE="GPL-2"
SLOT="0.3-live"
KEYWORDS=""
IUSE="debug"

RDEPEND="net-im/qutim:${SLOT}
	app-crypt/qca"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6"

RESTRICT="debug? ( strip )"

MY_PN=${PN#qutim-}

src_unpack() {
	git_src_unpack
}

src_prepare() {
	if (use debug) ; then
		unset CFLAGS CXXFLAGS
		append-flags -O1 -g -ggdb
		CMAKE_BUILD_TYPE="debug"
	fi
	mycmakeargs="-DANTIBOSS=off \
		-DANTISPAM=off \
		-DASPELLER=off \
		-DAWN=off \
		-DCLCONF=off \
		-DCONNECTIONMANAGER=off \
		-DDBUSAPI=off \
		-DDBUSNOTIFICATIONS=off \
		-DFLOATIES=off \
		-DHISTMAN=off \
		-DIMAGEPUB=off \
		-DINDICATOR=off \
		-DLOGGER=off \
		-DMAC-INTEGRATION=off \
		-DMASSMESSAGING=off \
		-DPHONONSOUND=off \
		-DPLUGMAN=off \
		-DSCRIPTAPI=off \
		-DSQLHISTORY=off \
		-DURLPREVIEW=off \
		-DWEATHER=off \
		-DWEBHISTORY=off \
		-DYANDEXNAROD=off"
# 	for i in $(grep -rl "<qutim/" "${S}" | grep -v "\.git"); do
# 		sed -e "s/<qutim\//<qutim-${PV}\//" -i "${i}";
# 	done
# 	sed -e "s/qutim/qutim-${PV}/" \
# 		-e "s/QutimPlugin/QutimPlugin-${PV}/" -i "${S}/CMakeLists.txt"
	CMAKE_IN_SOURCE_BUILD=1
}
