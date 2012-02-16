# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit kde4-base flag-o-matic cmake-utils git-2

DESCRIPTION="KDEIntegration plugin for net-im/qutim"
HOMEPAGE="http://www.qutim.org/"

LICENSE="GPL-2"
SLOT="0.3"
KEYWORDS="~amd64 ~x86"

EGIT_COMMIT="v0.3.0"

EGIT_REPO_URI="git://github.com/euroelessar/qutim.git"
EGIT_BRANCH="0.3-release"
EGIT_HAS_SUBMODULES="true"
EGIT_PROJECT="qutim-${SLOT}"

CMAKE_USE_DIR="${S}/plugins"
CMAKE_IN_SOURCE_BUILD=1

IUSE="debug"

RDEPEND="net-im/qutim:${SLOT}"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6"

RESTRICT="mirror
	debug? ( strip )"

KDE_MINIMAL="4.2"

src_configure() {
	if use debug ; then
		filter-flags -O* -f*
		append-flags -O1 -g -ggdb
	fi
	mycmakeargs=(
		-DQUTIM_ENABLE_ALL_PLUGINS=off
		-DKDEINTEGRATION=on
	)
	cmake-utils_src_configure
}