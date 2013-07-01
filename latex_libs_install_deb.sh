#!/bin/bash
#
# Bash script to install LaTeX.
# Author: luismartingil
# Year: 2012
#
# Debian installation script

WEB=https://raw.github.com/luismartingil/scripts/master/latex/
ARRAY=(
    lstcustom.sty
    minted.sty
    )

# Bash functions to install dependencies.
# Probably more deps than needed!
install_debian_req () {
    sudo apt-get install -y texlive-base texlive-fonts-recommended texlive-latex-base texlive-latex-recommended texify multex-bin tetex-frogg  tex-gyre  texlive-xetex texlive-pictures texlive-luatex texlive-bibtex-extra  texlive-extra-utils  texlive-font-utils texlive-fonts-extra  texlive-formats-extra texlive-generic-extra texlive-games  texlive-plain-extra texlive-latex-extra texlive-science  tshark texlive-base texlive-fonts-recommended texlive-latex-base ttf-dejavu-core ttf-gfs-* ttf-dejavu ttf-liberation ttf-bitstream-vera python-setuptools
    # Pygments is used for coloring and adding source files
    # in our LaTeX documents.
    sudo easy_install Pygments
}

# Please install the dependencies
install_debian_req

# Lets grab the .sty files
for i in "${ARRAY[@]}"
do
    wget -c $WEB$i -O $i
    cp $i /usr/share/texmf-texlive/tex/latex/
done

# Updating tex libs
texhash

echo 'LaTeX is installed!'