#!/bin/bash
#
# Bash script to install LaTeX from sources in a CENTOS box
# Author: luismartingil
# Year: 2018
#

install_latex_centos() {
    # perl-Digest-MD5 for centos7
    sudo yum install -y wget perl-devel freetype-devel fontconfig-devel perl-Digest-MD5
    PROFILE=/tmp/texlive.profile
    cat <<'EOF' > ${PROFILE}
selected_scheme scheme-basic
TEXDIR /usr/local/texlive/2017
binary_x86_64-linux 1
tlpdbopt_sys_bin /usr/local/bin
TEXMFCONFIG ~/.texlive2017/texmf-config
TEXMFHOME ~/texmf
TEXMFVAR ~/.texlive2017/texmf-var
TEXMFLOCAL /usr/local/texlive/texmf-local
TEXMFSYSCONFIG /usr/local/texlive/2017/texmf-config
TEXMFSYSVAR /usr/local/texlive/2017/texmf-var
option_doc 0
option_src 0
EOF
    pushd /tmp
    # Static 2017 works well on Centos6.
    # Apr 2018 kpswhich tools depends on GLIBC_2.14 and Centos comes with glibc 2.12, which is a headache to upgrade
    # We don't want to use anymore latest LaTeX installation repos such as: http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
    # REPO=ftp://tug.org/historic/systems/texlive/2017/tlnet-final/
    REPO=http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2017/tlnet-final/
    wget -qO- ${REPO}/install-tl-unx.tar.gz | tar xz
    cd install-tl-*
    ./install-tl --version
    TEXLIVE=/usr/local/texlive
    sudo mkdir -p ${TEXLIVE}
    sudo chmod -R 777 ${TEXLIVE}
    CURRENT_TEXLIVE=${TEXLIVE}/2017
    PDFLATEX=${CURRENT_TEXLIVE}/bin/x86_64-linux/pdflatex
    ./install-tl -profile ${PROFILE} -no-persistent-downloads -repository ${REPO}
    TLMGR=${CURRENT_TEXLIVE}/bin/x86_64-linux/tlmgr
    ${TLMGR} conf tlmgr persistent-downloads 0
    ${TLMGR} install luatex l3build
    ${TLMGR} install cm etex knuth-lib latex-bin tex tex-ini-files unicode-data xetex
    ${TLMGR} install --no-depends babel ptex uptex ptex-base uptex-base ptex-fonts uptex-fonts platex uplatex float
    ${TLMGR} install metafont mfware fncychap tabulary varwidth
    ${TLMGR} install graphics graphics-cfg graphics-def oberdiek
    ${TLMGR} install --no-depends fontspec
    ${TLMGR} install ifluatex lm lualibs luaotfload
    ${TLMGR} install --no-depends chemformula ctex mhchem siunitx unicode-math
    ${TLMGR} install --no-depends cjk
    ${TLMGR} install adobemapping amsfonts amsmath chemgreek cjkpunct ctablestack ec environ etoolbox fandol filehook ifxetex lm-math lualatex-math luatexbase luatexja ms pgf tools trimspaces ucharcat ulem units xcolor xecjk xkeyval xunicode zhmetrics zhnumber
    ${TLMGR} install cmap mmap times babel-english fancybox titlesec framed fancyvrb threeparttable mdwtools wrapfig parskip upquote capt-of needspace multirow eqparbox pgfplots sansmath lastpage eso-pic collection-fontsrecommended
    ${TLMGR} option -- autobackup 0
    ${TLMGR} update --self --all --no-auto-install
    # Doing a symlink solution for the path based on  @i.ribakov old Ansible approach
    BIN_DEST=/usr/local/bin/
    sudo find ${CURRENT_TEXLIVE}/bin/x86_64-linux -maxdepth 1 -name "*" -type f -exec ln -s {} ${BIN_DEST} \;
    sudo find ${CURRENT_TEXLIVE}/bin/x86_64-linux -maxdepth 1 -name "*" ! -name "man" -type l -exec ln -s {} ${BIN_DEST} \;
    popd
    rm -fr /tmp/install-tl-*
    ${PDFLATEX} -v
}

install_latex_centos
